import '../models/user_model.dart';
import '../models/achievement_model.dart';
import '../models/history_item_model.dart';
import 'auth_repository.dart';
import '../service/progress_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  ProfileRepository(this._authRepo);

  final AuthRepository _authRepo;
  final _supabase = Supabase.instance.client;
  final _progressService = ProgressService();

  // Load profile fresh from Supabase every time
  Future<UserModel?> getProfile() async {
    return await _authRepo.loadProfile();
  }

  Future<void> updateClassGrade(int classGrade) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;
    await _supabase
        .from('profiles')
        .update({'class_grade': classGrade})
        .eq('id', userId);
  }

  Future<void> updateProfile(UserModel user) async {
    await _supabase
        .from('profiles')
        .update(user.toSupabaseRow())
        .eq('id', user.id);
  }

  Future<List<AchievementModel>> getAchievements() async {
    final u = await getProfile();
    final completed = u?.completedLessonsCount ?? 0;
    return [
      AchievementModel(id: 'a1', titleMn: 'Анхны алхам', descriptionMn: 'Эхний хичээлээ дуусгах', iconName: 'target', isUnlocked: completed >= 1),
      AchievementModel(id: 'a2', titleMn: '7 хоногийн дэс', descriptionMn: '7 хоног дараалан суралцах', iconName: 'flame', isUnlocked: (u?.streakDays ?? 0) >= 7),
      AchievementModel(id: 'a3', titleMn: 'Математикч', descriptionMn: 'Математикийн 10 хичээл дуусгах', iconName: 'math', isUnlocked: false),
      AchievementModel(id: 'a4', titleMn: 'Оюутан', descriptionMn: '50 хичээл дуусгах', iconName: 'graduation', isUnlocked: completed >= 50),
      AchievementModel(id: 'a5', titleMn: 'Мастер', descriptionMn: '100 хичээл дуусгах', iconName: 'crown', isUnlocked: completed >= 100),
    ];
  }

  // History = last 20 completed lessons from Supabase
  Future<List<HistoryItemModel>> getHistory() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];
    try {
      final data = await _supabase
          .from('lesson_progress')
          .select('node_id, completed_at')
          .eq('user_id', userId)
          .eq('is_completed', true)
          .order('completed_at', ascending: false)
          .limit(20);
      return (data as List).map((e) => HistoryItemModel(
        id: e['node_id'] as String,
        titleMn: e['node_id'] as String, // you can join with lesson_nodes later
        completedAt: DateTime.parse(e['completed_at']),
      )).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<UserModel>> getLeaderboard() async {
    return _progressService.getLeaderboard();
  }
}