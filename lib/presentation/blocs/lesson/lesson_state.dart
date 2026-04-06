part of 'lesson_bloc.dart';

class LessonState extends Equatable {
  const LessonState({
    this.selectedClass = 1,
    this.subjects = const [],
    this.selectedSubject,
    this.units = const [],
    this.loading = false,
    this.error,
  });

  factory LessonState.initial() => const LessonState();

  final int selectedClass;
  final List<SubjectModel> subjects;
  final SubjectModel? selectedSubject;
  final List<UnitModel> units;
  final bool loading;
  final String? error;

  LessonState copyWith({
    int? selectedClass,
    List<SubjectModel>? subjects,
    SubjectModel? selectedSubject,
    List<UnitModel>? units,
    bool? loading,
    String? error,
  }) {
    return LessonState(
      selectedClass: selectedClass ?? this.selectedClass,
      subjects: subjects ?? this.subjects,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      units: units ?? this.units,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [selectedClass, subjects, selectedSubject, units, loading, error];
}
