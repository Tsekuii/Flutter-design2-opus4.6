part of 'quiz_create_bloc.dart';

class QuizCreateEvent extends Equatable {
  const QuizCreateEvent();
  @override
  List<Object?> get props => [];
}

class QuizCreateTitleChanged extends QuizCreateEvent {
  const QuizCreateTitleChanged(this.title);
  final String title;
  @override
  List<Object?> get props => [title];
}

class QuizCreateQuestionAdded extends QuizCreateEvent {
  const QuizCreateQuestionAdded(this.question);
  final QuestionModel question;
  @override
  List<Object?> get props => [question];
}

class QuizCreateQuestionRemoved extends QuizCreateEvent {
  const QuizCreateQuestionRemoved(this.questionId);
  final String questionId;
  @override
  List<Object?> get props => [questionId];
}

class QuizCreateQuestionUpdated extends QuizCreateEvent {
  const QuizCreateQuestionUpdated(this.question);
  final QuestionModel question;
  @override
  List<Object?> get props => [question];
}

class QuizCreateSaveRequested extends QuizCreateEvent {}

class QuizCreateLoadMyQuizzes extends QuizCreateEvent {}
