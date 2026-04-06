import 'package:equatable/equatable.dart';
import 'question_model.dart';

class QuizModel extends Equatable {
  const QuizModel({
    required this.id,
    required this.title,
    this.questions = const [],
    this.subjectId,
    this.classGrade,
    this.createdAt,
  });

  final String id;
  final String title;
  final List<QuestionModel> questions;
  final String? subjectId;
  final int? classGrade;
  final DateTime? createdAt;

  QuizModel copyWith({
    String? id,
    String? title,
    List<QuestionModel>? questions,
    String? subjectId,
    int? classGrade,
    DateTime? createdAt,
  }) {
    return QuizModel(
      id: id ?? this.id,
      title: title ?? this.title,
      questions: questions ?? this.questions,
      subjectId: subjectId ?? this.subjectId,
      classGrade: classGrade ?? this.classGrade,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, questions, subjectId, classGrade, createdAt];
}
