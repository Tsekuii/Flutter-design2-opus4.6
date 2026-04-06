part of 'quiz_create_bloc.dart';

class QuizCreateState extends Equatable {
  const QuizCreateState({
    this.quizId = '',
    this.title = '',
    this.questions = const [],
    this.myQuizzes = const [],
    this.saving = false,
    this.saveSuccess = false,
    this.saveError,
  });

  factory QuizCreateState.initial() => const QuizCreateState();

  final String quizId;
  final String title;
  final List<QuestionModel> questions;
  final List<QuizModel> myQuizzes;
  final bool saving;
  final bool saveSuccess;
  final String? saveError;

  QuizCreateState copyWith({
    String? quizId,
    String? title,
    List<QuestionModel>? questions,
    List<QuizModel>? myQuizzes,
    bool? saving,
    bool? saveSuccess,
    String? saveError,
  }) {
    return QuizCreateState(
      quizId: quizId ?? this.quizId,
      title: title ?? this.title,
      questions: questions ?? this.questions,
      myQuizzes: myQuizzes ?? this.myQuizzes,
      saving: saving ?? this.saving,
      saveSuccess: saveSuccess ?? this.saveSuccess,
      saveError: saveError,
    );
  }

  @override
  List<Object?> get props => [quizId, title, questions, myQuizzes, saving, saveSuccess, saveError];
}
