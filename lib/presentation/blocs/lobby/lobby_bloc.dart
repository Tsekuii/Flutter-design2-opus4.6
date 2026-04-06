import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/lobby_model.dart';
import '../../../data/repositories/lobby_repository.dart';

part 'lobby_event.dart';
part 'lobby_state.dart';

class LobbyBloc extends Bloc<LobbyEvent, LobbyState> {
  LobbyBloc(this._lobbyRepo) : super(LobbyState.initial()) {
    on<LobbyLoadOpenRequested>(_onLoadOpen);
    on<LobbySearchChanged>(_onSearch);
    on<LobbyCreateRequested>(_onCreate);
    on<LobbyJoinByPinRequested>(_onJoinByPin);
    on<LobbyTabChanged>(_onTabChanged);
  }

  final LobbyRepository _lobbyRepo;

  Future<void> _onLoadOpen(LobbyLoadOpenRequested event, Emitter<LobbyState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final list = await _lobbyRepo.getOpenLobbies(search: state.search);
      emit(state.copyWith(loading: false, openLobbies: list));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void _onSearch(LobbySearchChanged event, Emitter<LobbyState> emit) {
    emit(state.copyWith(search: event.query));
    add(LobbyLoadOpenRequested());
  }

  Future<void> _onCreate(LobbyCreateRequested event, Emitter<LobbyState> emit) async {
    emit(state.copyWith(creating: true, createError: null));
    try {
      final lobby = await _lobbyRepo.createLobby(
        title: event.title,
        quizOrLessonId: event.quizOrLessonId,
        maxParticipants: event.maxParticipants,
        isPrivate: event.isPrivate,
      );
      emit(state.copyWith(creating: false, createdLobby: lobby));
      add(LobbyLoadOpenRequested());
    } catch (e) {
      emit(state.copyWith(creating: false, createError: e.toString()));
    }
  }

  Future<void> _onJoinByPin(LobbyJoinByPinRequested event, Emitter<LobbyState> emit) async {
    emit(state.copyWith(joining: true, joinError: null));
    try {
      final ok = await _lobbyRepo.joinByPin(event.pin);
      emit(state.copyWith(joining: false, joinSuccess: ok));
    } catch (e) {
      emit(state.copyWith(joining: false, joinError: e.toString()));
    }
  }

  void _onTabChanged(LobbyTabChanged event, Emitter<LobbyState> emit) {
    emit(state.copyWith(activeTab: event.tab));
  }
}
