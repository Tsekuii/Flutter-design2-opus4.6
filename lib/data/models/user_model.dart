import 'package:equatable/equatable.dart';

/// User profile. Progress starts at zero for new users.
class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.displayName,
    this.email,
    this.avatarUrl,
    this.classGrade = 1,
    this.level = 1,
    this.xp = 0,
    this.coins = 0,
    this.streakDays = 0,
    this.completedLessonsCount = 0,
    this.totalTimeMinutes = 0,
    this.averageScorePercent = 0,
    this.awardsCount = 0,
  });

  final String id;
  final String displayName;
  final String? email;
  final String? avatarUrl;
  final int classGrade;
  final int level;
  final int xp;
  final int coins;
  final int streakDays;
  final int completedLessonsCount;
  final int totalTimeMinutes;
  final int averageScorePercent;
  final int awardsCount;

  UserModel copyWith({
    String? id,
    String? displayName,
    String? email,
    String? avatarUrl,
    int? classGrade,
    int? level,
    int? xp,
    int? coins,
    int? streakDays,
    int? completedLessonsCount,
    int? totalTimeMinutes,
    int? averageScorePercent,
    int? awardsCount,
  }) {
    return UserModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      classGrade: classGrade ?? this.classGrade,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      coins: coins ?? this.coins,
      streakDays: streakDays ?? this.streakDays,
      completedLessonsCount: completedLessonsCount ?? this.completedLessonsCount,
      totalTimeMinutes: totalTimeMinutes ?? this.totalTimeMinutes,
      averageScorePercent: averageScorePercent ?? this.averageScorePercent,
      awardsCount: awardsCount ?? this.awardsCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        displayName,
        email,
        avatarUrl,
        classGrade,
        level,
        xp,
        coins,
        streakDays,
        completedLessonsCount,
        totalTimeMinutes,
        averageScorePercent,
        awardsCount,
      ];
}
