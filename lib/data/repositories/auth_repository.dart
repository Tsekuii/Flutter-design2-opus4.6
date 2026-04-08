import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthRepository {
  final _supabase = Supabase.instance.client;

  bool get isLoggedIn => _supabase.auth.currentUser != null;

  UserModel? get currentUser {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;
    // We'll load the full profile separately
    return UserModel(
      id: user.id,
      displayName: user.userMetadata?['display_name'] ?? '',
      email: user.email,
    );
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user != null;
    } on AuthException catch (e) {
      debugPrint('Supabase login error: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      debugPrint('Supabase login error (unknown): $e');
      throw Exception('Login failed: $e');
    }
  }

  Future<bool> signUp(
    String email,
    String password,
    String displayName,
    int classGrade,
  ) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'display_name': displayName,
          'class_grade': classGrade,
        },
      );
      // Update the auto-created profile with class_grade
      if (response.user != null) {
        await _supabase
            .from('profiles')
            .update({'class_grade': classGrade, 'display_name': displayName})
            .eq('id', response.user!.id);
      }
      return response.user != null;
    } on AuthException catch (e) {
      debugPrint('Supabase signUp error: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      debugPrint('Supabase signUp error (unknown): $e');
      throw Exception('Sign up failed: $e');
    }
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // Load full profile from DB
  Future<UserModel?> loadProfile() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return null;
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return UserModel.fromSupabase(data);
    } catch (e) {
      return null;
    }
  }

  // Update XP/coins/etc
  Future<void> updateProfile(UserModel user) async {
    await _supabase
        .from('profiles')
        .update(user.toSupabaseRow())
        .eq('id', user.id);
  }
}