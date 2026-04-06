part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {}

class ProfileClassUpdated extends ProfileEvent {
  const ProfileClassUpdated(this.classGrade);
  final int classGrade;
  @override
  List<Object?> get props => [classGrade];
}

class ProfileTabChanged extends ProfileEvent {
  const ProfileTabChanged(this.tab);
  final String tab; // 'progress' | 'settings'
  @override
  List<Object?> get props => [tab];
}
