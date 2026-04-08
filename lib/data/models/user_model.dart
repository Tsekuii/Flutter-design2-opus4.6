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

  /// Row from Supabase `public.profiles` (snake_case columns).
  factory UserModel.fromSupabase(Map<String, dynamic> json) {
    int asInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    return UserModel(
      id: json['id'] as String,
      displayName: json['display_name'] as String? ?? '',
      email: json['email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      classGrade: asInt(json['class_grade']),
      level: asInt(json['level']),
      xp: asInt(json['xp']),
      coins: asInt(json['coins']),
      streakDays: asInt(json['streak_days']),
      completedLessonsCount: asInt(json['completed_lessons_count']),
      totalTimeMinutes: asInt(json['total_time_minutes']),
      averageScorePercent: asInt(json['average_score_percent']),
      awardsCount: asInt(json['awards_count']),
    );
  }

  /// Fields for `profiles` update/insert (snake_case).
  Map<String, dynamic> toSupabaseRow() {
    return {
      'id': id,
      'display_name': displayName,
      'email': email,
      'avatar_url': avatarUrl,
      'class_grade': classGrade,
      'level': level,
      'xp': xp,
      'coins': coins,
      'streak_days': streakDays,
      'completed_lessons_count': completedLessonsCount,
      'total_time_minutes': totalTimeMinutes,
      'average_score_percent': averageScorePercent,
      'awards_count': awardsCount,
    };
  }

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
