import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

/// XP and coin rules — change these numbers to tune difficulty
class ProgressRules {
  // XP earned per quiz based on score %
  static int quizXp(int scorePercent, int questionCount) {
    // Base: 10 XP per correct answer
    final correct = (scorePercent / 100 * questionCount).round();
    int xp = correct * 10;
    // Bonus: +20 XP if score >= 80%
    if (scorePercent >= 80) xp += 20;
    // Bonus: +50 XP if perfect score
    if (scorePercent == 100) xp += 50;
    return xp;
  }

  // Coins: 1 coin per 10 XP earned
  static int coins(int xpEarned) => (xpEarned / 10).floor();

  // XP needed to reach next level (increases each level)
  static int xpForNextLevel(int currentLevel) => currentLevel * 100;

  // Lesson completion: flat 20 XP
  static const int lessonXp = 20;
  static const int lessonCoins = 2;
}

class ProgressService {
  final _supabase = Supabase.instance.client;

  String? get _userId => _supabase.auth.currentUser?.id;

  /// Call this when user finishes a QUIZ
  /// Returns updated UserModel so UI can show "You earned X XP!"
  Future<ProgressResult> onQuizCompleted({
    required int scorePercent,
    required int questionCount,
    String? lobbyId, // if it was a multiplayer lobby quiz
  }) async {
    final userId = _userId;
    if (userId == null) return ProgressResult.empty();

    // 1. Calculate rewards
    final xpEarned = ProgressRules.quizXp(scorePercent, questionCount);
    final coinsEarned = ProgressRules.coins(xpEarned);

    // 2. Load current profile
    final profileData = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    final profile = UserModel.fromSupabase(profileData);

    // 3. Calculate new values
    final newXp = profile.xp + xpEarned;
    final newCoins = profile.coins + coinsEarned;
    final newCount = profile.completedLessonsCount + 1;

    // 4. Check for level up
    int newLevel = profile.level;
    int remainingXp = newXp;
    bool leveledUp = false;
    while (remainingXp >= ProgressRules.xpForNextLevel(newLevel)) {
      remainingXp -= ProgressRules.xpForNextLevel(newLevel);
      newLevel++;
      leveledUp = true;
    }

    // 5. Check streak (if user played yesterday or today already)
    final newStreak = await _calculateStreak(profile.streakDays);

    // 6. Calculate average score
    final newAvg = ((profile.averageScorePercent * (newCount - 1)) + scorePercent) ~/ newCount;

    // 7. Save to Supabase profiles table
    final updatedRow = {
      'xp': newXp,
      'coins': newCoins,
      'level': newLevel,
      'streak_days': newStreak,
      'completed_lessons_count': newCount,
      'average_score_percent': newAvg,
      'last_activity_at': DateTime.now().toIso8601String(),
    };

    await _supabase
        .from('profiles')
        .update(updatedRow)
        .eq('id', userId);

    // 8. Save to lobby_participants if multiplayer
    if (lobbyId != null) {
      await _supabase
          .from('lobby_participants')
          .update({'score': scorePercent})
          .eq('lobby_id', lobbyId)
          .eq('user_id', userId);
    }

    final updatedProfile = profile.copyWith(
      xp: newXp,
      coins: newCoins,
      level: newLevel,
      streakDays: newStreak,
      completedLessonsCount: newCount,
      averageScorePercent: newAvg,
    );

    return ProgressResult(
      updatedProfile: updatedProfile,
      xpEarned: xpEarned,
      coinsEarned: coinsEarned,
      leveledUp: leveledUp,
      newLevel: newLevel,
      newStreak: newStreak,
    );
  }

  /// Call this when user completes a LESSON NODE
  Future<ProgressResult> onLessonCompleted({
    required String nodeId,
    required int timeSpentMinutes,
  }) async {
    final userId = _userId;
    if (userId == null) return ProgressResult.empty();

    // 1. Check if already completed (don't give XP twice)
    final existing = await _supabase
        .from('lesson_progress')
        .select()
        .eq('user_id', userId)
        .eq('node_id', nodeId)
        .maybeSingle();

    final alreadyDone = existing != null && (existing['is_completed'] == true);

    // 2. Save lesson_progress row
    await _supabase.from('lesson_progress').upsert({
      'user_id': userId,
      'node_id': nodeId,
      'is_completed': true,
      'completed_at': DateTime.now().toIso8601String(),
    }, onConflict: 'user_id,node_id');

    // 3. If first time completing — give XP
    if (!alreadyDone) {
      final profileData = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      final profile = UserModel.fromSupabase(profileData);

      final newXp = profile.xp + ProgressRules.lessonXp;
      final newCoins = profile.coins + ProgressRules.lessonCoins;
      final newCount = profile.completedLessonsCount + 1;
      final newTime = profile.totalTimeMinutes + timeSpentMinutes;
      final newStreak = await _calculateStreak(profile.streakDays);

      int newLevel = profile.level;
      bool leveledUp = false;
      int tempXp = newXp;
      while (tempXp >= ProgressRules.xpForNextLevel(newLevel)) {
        tempXp -= ProgressRules.xpForNextLevel(newLevel);
        newLevel++;
        leveledUp = true;
      }

      await _supabase.from('profiles').update({
        'xp': newXp,
        'coins': newCoins,
        'level': newLevel,
        'streak_days': newStreak,
        'completed_lessons_count': newCount,
        'total_time_minutes': newTime,
        'last_activity_at': DateTime.now().toIso8601String(),
      }).eq('id', userId);

      final updatedProfile = profile.copyWith(
        xp: newXp,
        coins: newCoins,
        level: newLevel,
        streakDays: newStreak,
        completedLessonsCount: newCount,
        totalTimeMinutes: newTime,
      );

      return ProgressResult(
        updatedProfile: updatedProfile,
        xpEarned: ProgressRules.lessonXp,
        coinsEarned: ProgressRules.lessonCoins,
        leveledUp: leveledUp,
        newLevel: newLevel,
        newStreak: newStreak,
      );
    }

    // Already completed before — no XP, but still track progress
    return ProgressResult.empty();
  }

  /// Streak logic: if last activity was yesterday → +1, today → keep, else → reset to 1
  Future<int> _calculateStreak(int currentStreak) async {
    final userId = _userId;
    if (userId == null) return currentStreak;
    try {
      final data = await _supabase
          .from('profiles')
          .select('last_activity_at')
          .eq('id', userId)
          .single();

      final lastActivity = data['last_activity_at'] != null
          ? DateTime.parse(data['last_activity_at']).toLocal()
          : null;

      if (lastActivity == null) return 1;

      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));

      final lastDate = DateTime(lastActivity.year, lastActivity.month, lastActivity.day);
      final todayDate = DateTime(today.year, today.month, today.day);
      final yesterdayDate = DateTime(yesterday.year, yesterday.month, yesterday.day);

      if (lastDate == todayDate) return currentStreak; // already played today
      if (lastDate == yesterdayDate) return currentStreak + 1; // played yesterday
      return 1; // streak broken
    } catch (_) {
      return currentStreak;
    }
  }

  /// Load completed node IDs for the current user (to show locked/unlocked state)
  Future<Set<String>> getCompletedNodeIds() async {
    final userId = _userId;
    if (userId == null) return {};
    final data = await _supabase
        .from('lesson_progress')
        .select('node_id')
        .eq('user_id', userId)
        .eq('is_completed', true);
    return (data as List).map((e) => e['node_id'] as String).toSet();
  }

  /// Load full leaderboard
  Future<List<UserModel>> getLeaderboard() async {
    final data = await _supabase
        .from('leaderboard')
        .select()
        .limit(50);
    return (data as List).map((e) => UserModel.fromSupabase(e)).toList();
  }
}

/// What gets returned after completing a quiz or lesson
class ProgressResult {
  const ProgressResult({
    required this.updatedProfile,
    required this.xpEarned,
    required this.coinsEarned,
    required this.leveledUp,
    required this.newLevel,
    required this.newStreak,
  });

  factory ProgressResult.empty() => const ProgressResult(
    updatedProfile: null,
    xpEarned: 0,
    coinsEarned: 0,
    leveledUp: false,
    newLevel: 1,
    newStreak: 0,
  );

  final UserModel? updatedProfile;
  final int xpEarned;
  final int coinsEarned;
  final bool leveledUp;
  final int newLevel;
  final int newStreak;
}