import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/question_model.dart';
import '../models/quiz_model.dart';

class QuizRepository {
  final _supabase = Supabase.instance.client;

  String? get _userId => _supabase.auth.currentUser?.id;

  Future<List<QuizModel>> getMyQuizzes() async {
    final userId = _userId;
    if (userId == null) return [];
    try {
      final data = await _supabase
          .from('quizzes')
          .select('*, questions(*)')
          .eq('creator_id', userId)
          .order('created_at', ascending: false);

      return (data as List).map((e) => _quizFromRow(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<QuizModel>> getAllQuizzes() async {
    try {
      final data = await _supabase
          .from('quizzes')
          .select('*, questions(*)')
          .order('created_at', ascending: false)
          .limit(50);
      return (data as List).map((e) => _quizFromRow(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<QuizModel?> saveQuiz(QuizModel quiz) async {
    final userId = _userId;
    if (userId == null) return null;

    try {
      if (quiz.id.isEmpty) {
        final quizRow = await _supabase
            .from('quizzes')
            .insert({
              'title': quiz.title,
              'creator_id': userId,
              'subject_id': quiz.subjectId,
              'class_grade': quiz.classGrade,
            })
            .select()
            .single();

        final quizId = quizRow['id'] as String;

        if (quiz.questions.isNotEmpty) {
          await _supabase.from('questions').insert(
                quiz.questions
                    .asMap()
                    .entries
                    .map((e) => _questionToRow(e.value, quizId, e.key))
                    .toList(),
              );
        }

        return quiz.copyWith(
          id: quizId,
          createdAt: DateTime.tryParse(quizRow['created_at'] as String? ?? ''),
        );
      }

      await _supabase
          .from('quizzes')
          .update({'title': quiz.title})
          .eq('id', quiz.id)
          .eq('creator_id', userId);

      await _supabase.from('questions').delete().eq('quiz_id', quiz.id);

      if (quiz.questions.isNotEmpty) {
        await _supabase.from('questions').insert(
              quiz.questions
                  .asMap()
                  .entries
                  .map((e) => _questionToRow(e.value, quiz.id, e.key))
                  .toList(),
            );
      }
      return quiz;
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteQuiz(String id) async {
    await _supabase.from('quizzes').delete().eq('id', id).eq('creator_id', _userId ?? '');
  }

  Future<QuizModel?> getQuiz(String id) async {
    try {
      final data = await _supabase.from('quizzes').select('*, questions(*)').eq('id', id).single();
      return _quizFromRow(data);
    } catch (_) {
      return null;
    }
  }

  QuizModel _quizFromRow(Map<String, dynamic> row) {
    final rawQuestions = (row['questions'] as List? ?? []).cast<Map<String, dynamic>>();
    rawQuestions.sort(
      (a, b) =>
          (a['order_index'] as int? ?? 0).compareTo((b['order_index'] as int? ?? 0)),
    );

    return QuizModel(
      id: row['id'] as String,
      title: row['title'] as String? ?? '',
      subjectId: row['subject_id'] as String?,
      classGrade: row['class_grade'] as int?,
      createdAt: row['created_at'] != null
          ? DateTime.tryParse(row['created_at'] as String)
          : null,
      questions: rawQuestions.map(_questionFromRow).toList(),
    );
  }

  QuestionModel _questionFromRow(Map<String, dynamic> row) {
    QuestionType type;
    switch (row['type'] as String? ?? 'multipleChoice') {
      case 'trueFalse':
        type = QuestionType.trueFalse;
        break;
      case 'textAnswer':
        type = QuestionType.textAnswer;
        break;
      default:
        type = QuestionType.multipleChoice;
    }

    final rawOptions = row['options'];
    List<String> options = [];
    if (rawOptions is List) {
      options = rawOptions.map((e) => e.toString()).toList();
    }

    return QuestionModel(
      id: row['id'] as String,
      type: type,
      text: row['text'] as String? ?? '',
      options: options,
      correctOptionIndex: row['correct_option_index'] as int?,
      correctTextAnswer: row['correct_text_answer'] as String?,
      explanation: row['explanation'] as String?,
    );
  }

  Map<String, dynamic> _questionToRow(
    QuestionModel q,
    String quizId,
    int orderIndex,
  ) {
    return {
      'quiz_id': quizId,
      'text': q.text,
      'type': q.type.name,
      'options': q.options,
      'correct_option_index': q.correctOptionIndex,
      'correct_text_answer': q.correctTextAnswer,
      'explanation': q.explanation,
      'order_index': orderIndex,
    };
  }
}
