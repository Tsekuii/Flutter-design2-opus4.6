import '../models/user_model.dart';

/// Mock auth. Replace with real backend later.
class AuthRepository {
  UserModel? _currentUser;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  UserModel? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = UserModel(
      id: 'user-1',
      displayName: 'Амар',
      email: email,
      classGrade: 10,
      level: 1,
      xp: 0,
      coins: 0,
      streakDays: 0,
      completedLessonsCount: 0,
      totalTimeMinutes: 0,
      averageScorePercent: 0,
      awardsCount: 0,
    );
    _isLoggedIn = true;
    return true;
  }

  Future<bool> signUp(String email, String password, String displayName, int classGrade) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = UserModel(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      displayName: displayName,
      email: email,
      classGrade: classGrade,
      level: 1,
      xp: 0,
      coins: 0,
      streakDays: 0,
      completedLessonsCount: 0,
      totalTimeMinutes: 0,
      averageScorePercent: 0,
      awardsCount: 0,
    );
    _isLoggedIn = true;
    return true;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUser = null;
    _isLoggedIn = false;
  }

  void updateUser(UserModel user) {
    _currentUser = user;
  }
}
