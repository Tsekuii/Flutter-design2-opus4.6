part of 'lobby_bloc.dart';

class LobbyState extends Equatable {
  const LobbyState({
    this.openLobbies = const [],
    this.search = '',
    this.loading = false,
    this.creating = false,
    this.joining = false,
    this.error,
    this.createError,
    this.joinError,
    this.createdLobby,
    this.joinSuccess = false,
    this.activeTab = 'play',
  });

  factory LobbyState.initial() => const LobbyState();

  final List<LobbyModel> openLobbies;
  final String search;
  final bool loading;
  final bool creating;
  final bool joining;
  final String? error;
  final String? createError;
  final String? joinError;
  final LobbyModel? createdLobby;
  final bool joinSuccess;
  final String activeTab;

  LobbyState copyWith({
    List<LobbyModel>? openLobbies,
    String? search,
    bool? loading,
    bool? creating,
    bool? joining,
    String? error,
    String? createError,
    String? joinError,
    LobbyModel? createdLobby,
    bool? joinSuccess,
    String? activeTab,
  }) {
    return LobbyState(
      openLobbies: openLobbies ?? this.openLobbies,
      search: search ?? this.search,
      loading: loading ?? this.loading,
      creating: creating ?? this.creating,
      joining: joining ?? this.joining,
      error: error ?? this.error,
      createError: createError ?? this.createError,
      joinError: joinError ?? this.joinError,
      createdLobby: createdLobby ?? this.createdLobby,
      joinSuccess: joinSuccess ?? this.joinSuccess,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  List<Object?> get props => [openLobbies, search, loading, creating, joining, error, createError, joinError, createdLobby, joinSuccess, activeTab];
}
