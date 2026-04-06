import 'package:equatable/equatable.dart';

class LessonNodeModel extends Equatable {
  const LessonNodeModel({
    required this.id,
    required this.title,
    required this.type,
    this.isLocked = true,
    this.isCompleted = false,
    this.lessonCount,
    this.testCount,
  });

  final String id;
  final String title;
  final String type; // 'lesson' | 'exercise' | 'test' | 'unit'
  final bool isLocked;
  final bool isCompleted;
  final int? lessonCount;
  final int? testCount;

  @override
  List<Object?> get props => [id, title, type, isLocked, isCompleted, lessonCount, testCount];
}

class UnitModel extends Equatable {
  const UnitModel({
    required this.id,
    required this.subjectId,
    required this.unitNumber,
    required this.title,
    this.lessonCount = 0,
    this.testCount = 0,
    this.nodes = const [],
  });

  final String id;
  final String subjectId;
  final int unitNumber;
  final String title;
  final int lessonCount;
  final int testCount;
  final List<LessonNodeModel> nodes;

  @override
  List<Object?> get props => [id, subjectId, unitNumber, title, lessonCount, testCount, nodes];
}
