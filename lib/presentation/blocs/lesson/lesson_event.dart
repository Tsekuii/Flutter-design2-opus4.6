part of 'lesson_bloc.dart';

class LessonEvent extends Equatable {
  const LessonEvent();
  @override
  List<Object?> get props => [];
}

class LessonClassSelected extends LessonEvent {
  const LessonClassSelected(this.classGrade);
  final int classGrade;
  @override
  List<Object?> get props => [classGrade];
}

class LessonSubjectSelected extends LessonEvent {
  const LessonSubjectSelected(this.subject);
  final SubjectModel subject;
  @override
  List<Object?> get props => [subject];
}

class LessonLoadUnits extends LessonEvent {
  const LessonLoadUnits(this.subjectId);
  final String subjectId;
  @override
  List<Object?> get props => [subjectId];
}
