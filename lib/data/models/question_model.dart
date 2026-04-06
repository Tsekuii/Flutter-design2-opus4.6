import 'package:equatable/equatable.dart';

enum QuestionType { multipleChoice, trueFalse, textAnswer }

class QuestionModel extends Equatable {
  const QuestionModel({
    required this.id,
    required this.type,
    required this.text,
    this.options = const [],
    this.correctOptionIndex,
    this.correctTextAnswer,
    this.explanation,
  });

  final String id;
  final QuestionType type;
  final String text;
  final List<String> options;
  final int? correctOptionIndex;
  final String? correctTextAnswer;
  final String? explanation;

  QuestionModel copyWith({
    String? id,
    QuestionType? type,
    String? text,
    List<String>? options,
    int? correctOptionIndex,
    String? correctTextAnswer,
    String? explanation,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      text: text ?? this.text,
      options: options ?? this.options,
      correctOptionIndex: correctOptionIndex ?? this.correctOptionIndex,
      correctTextAnswer: correctTextAnswer ?? this.correctTextAnswer,
      explanation: explanation ?? this.explanation,
    );
  }

  @override
  List<Object?> get props => [id, type, text, options, correctOptionIndex, correctTextAnswer, explanation];
}
