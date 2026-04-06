import '../models/quiz_model.dart';

/// Saved quizzes (user-created). Mock for frontend.
class QuizRepository {
  final List<QuizModel> _quizzes = [];

  Future<List<QuizModel>> getMyQuizzes() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_quizzes);
  }

  Future<QuizModel?> saveQuiz(QuizModel quiz) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final toSave = quiz.id.isEmpty
        ? quiz.copyWith(id: 'quiz-${DateTime.now().millisecondsSinceEpoch}', createdAt: DateTime.now())
        : quiz;
    final idx = _quizzes.indexWhere((q) => q.id == toSave.id);
    if (idx >= 0) {
      _quizzes[idx] = toSave;
    } else {
      _quizzes.add(toSave);
    }
    return toSave;
  }

  Future<void> deleteQuiz(String id) async {
    _quizzes.removeWhere((q) => q.id == id);
  }

  Future<QuizModel?> getQuiz(String id) async {
    return _quizzes.cast<QuizModel?>().firstWhere((q) => q?.id == id, orElse: () => null);
  }
}
