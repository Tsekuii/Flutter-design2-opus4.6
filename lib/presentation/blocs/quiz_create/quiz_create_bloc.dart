import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/quiz_model.dart';
import '../../../data/models/question_model.dart';
import '../../../data/repositories/quiz_repository.dart';

part 'quiz_create_event.dart';
part 'quiz_create_state.dart';

class QuizCreateBloc extends Bloc<QuizCreateEvent, QuizCreateState> {
  QuizCreateBloc(this._quizRepo) : super(QuizCreateState.initial()) {
    on<QuizCreateTitleChanged>(_onTitleChanged);
    on<QuizCreateQuestionAdded>(_onQuestionAdded);
    on<QuizCreateQuestionRemoved>(_onQuestionRemoved);
    on<QuizCreateQuestionUpdated>(_onQuestionUpdated);
    on<QuizCreateSaveRequested>(_onSave);
    on<QuizCreateLoadMyQuizzes>(_onLoadMyQuizzes);
  }

  final QuizRepository _quizRepo;

  void _onTitleChanged(QuizCreateTitleChanged event, Emitter<QuizCreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onQuestionAdded(QuizCreateQuestionAdded event, Emitter<QuizCreateState> emit) {
    final q = event.question;
    emit(state.copyWith(questions: [...state.questions, q]));
  }

  void _onQuestionRemoved(QuizCreateQuestionRemoved event, Emitter<QuizCreateState> emit) {
    final list = state.questions.where((q) => q.id != event.questionId).toList();
    emit(state.copyWith(questions: list));
  }

  void _onQuestionUpdated(QuizCreateQuestionUpdated event, Emitter<QuizCreateState> emit) {
    final list = state.questions.map((q) => q.id == event.question.id ? event.question : q).toList();
    emit(state.copyWith(questions: list));
  }

  Future<void> _onSave(QuizCreateSaveRequested event, Emitter<QuizCreateState> emit) async {
    if (state.title.trim().isEmpty) {
      emit(state.copyWith(saveError: 'Quiz-ийн нэр оруулна уу'));
      return;
    }
    emit(state.copyWith(saving: true, saveError: null));
    try {
      final quiz = QuizModel(
        id: state.quizId,
        title: state.title.trim(),
        questions: state.questions,
      );
      final saved = await _quizRepo.saveQuiz(quiz);
      emit(state.copyWith(saving: false, saveSuccess: true, quizId: saved?.id ?? state.quizId));
    } catch (e) {
      emit(state.copyWith(saving: false, saveError: e.toString()));
    }
  }

  Future<void> _onLoadMyQuizzes(QuizCreateLoadMyQuizzes event, Emitter<QuizCreateState> emit) async {
    final list = await _quizRepo.getMyQuizzes();
    emit(state.copyWith(myQuizzes: list));
  }
}
