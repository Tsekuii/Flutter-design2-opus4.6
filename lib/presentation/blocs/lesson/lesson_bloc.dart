import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/subject_model.dart';
import '../../../data/models/unit_model.dart';
import '../../../data/repositories/lesson_repository.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc(this._lessonRepo) : super(LessonState.initial()) {
    on<LessonClassSelected>(_onClassSelected);
    on<LessonSubjectSelected>(_onSubjectSelected);
    on<LessonLoadUnits>(_onLoadUnits);
  }

  final LessonRepository _lessonRepo;

  Future<void> _onClassSelected(LessonClassSelected event, Emitter<LessonState> emit) async {
    emit(state.copyWith(selectedClass: event.classGrade, loading: true));
    try {
      final subjects = await _lessonRepo.getSubjectsByClass(event.classGrade);
      emit(state.copyWith(subjects: subjects, loading: false, selectedSubject: null, units: []));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void _onSubjectSelected(LessonSubjectSelected event, Emitter<LessonState> emit) {
    emit(state.copyWith(selectedSubject: event.subject));
    add(LessonLoadUnits(event.subject.id));
  }

  Future<void> _onLoadUnits(LessonLoadUnits event, Emitter<LessonState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final units = await _lessonRepo.getUnitsBySubject(event.subjectId);
      emit(state.copyWith(units: units, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
