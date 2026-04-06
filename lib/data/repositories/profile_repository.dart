import '../models/user_model.dart';
import '../models/achievement_model.dart';
import '../models/history_item_model.dart';
import 'auth_repository.dart';

/// Profile and progress. New users start with all progress at zero.
class ProfileRepository {
  ProfileRepository(this._authRepo);

  final AuthRepository _authRepo;

  UserModel? get currentUser => _authRepo.currentUser;

  Future<UserModel?> getProfile() async {
    return _authRepo.currentUser;
  }

  Future<void> updateClassGrade(int classGrade) async {
    final u = _authRepo.currentUser;
    if (u == null) return;
    _authRepo.updateUser(u.copyWith(classGrade: classGrade));
  }

  Future<void> updateProfile(UserModel user) async {
    _authRepo.updateUser(user);
  }

  /// Achievements – mock list; unlocked state can come from backend.
  Future<List<AchievementModel>> getAchievements() async {
    final u = _authRepo.currentUser;
    final completed = u?.completedLessonsCount ?? 0;
    return [
      AchievementModel(id: 'a1', titleMn: 'Анхны алхам', descriptionMn: 'Эхний хичээлээ дуусгах', iconName: 'target', isUnlocked: completed >= 1),
      AchievementModel(id: 'a2', titleMn: '7 хоногийн дэс', descriptionMn: '7 хоног дараалан суралцах', iconName: 'flame', isUnlocked: (u?.streakDays ?? 0) >= 7),
      AchievementModel(id: 'a3', titleMn: 'Математикч', descriptionMn: 'Математикийн 10 хичээл дуусгах', iconName: 'math', isUnlocked: false),
      AchievementModel(id: 'a4', titleMn: 'Оюутан', descriptionMn: '50 хичээл дуусгах', iconName: 'graduation', isUnlocked: completed >= 50),
      AchievementModel(id: 'a5', titleMn: 'Мастер', descriptionMn: '100 хичээл дуусгах', iconName: 'crown', isUnlocked: completed >= 100),
    ];
  }

  Future<List<HistoryItemModel>> getHistory() async {
    // Mock: empty for new user (progress starts at zero / no history)
    return [];
  }
}
