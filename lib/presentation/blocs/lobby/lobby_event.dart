part of 'lobby_bloc.dart';

class LobbyEvent extends Equatable {
  const LobbyEvent();
  @override
  List<Object?> get props => [];
}

class LobbyLoadOpenRequested extends LobbyEvent {}

class LobbySearchChanged extends LobbyEvent {
  const LobbySearchChanged(this.query);
  final String query;
  @override
  List<Object?> get props => [query];
}

class LobbyCreateRequested extends LobbyEvent {
  const LobbyCreateRequested({
    required this.title,
    required this.quizOrLessonId,
    required this.maxParticipants,
    this.isPrivate = false,
  });
  final String title;
  final String quizOrLessonId;
  final int maxParticipants;
  final bool isPrivate;
  @override
  List<Object?> get props => [title, quizOrLessonId, maxParticipants, isPrivate];
}

class LobbyJoinByPinRequested extends LobbyEvent {
  const LobbyJoinByPinRequested(this.pin);
  final String pin;
  @override
  List<Object?> get props => [pin];
}

class LobbyTabChanged extends LobbyEvent {
  const LobbyTabChanged(this.tab);
  final String tab; // 'play' | 'create'
  @override
  List<Object?> get props => [tab];
}
