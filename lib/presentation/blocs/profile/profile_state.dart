part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.user,
    this.achievements = const [],
    this.history = const [],
    this.loading = false,
    this.error,
    this.activeTab = 'progress',
  });

  factory ProfileState.initial() => const ProfileState();

  final UserModel? user;
  final List<AchievementModel> achievements;
  final List<HistoryItemModel> history;
  final bool loading;
  final String? error;
  final String activeTab;

  ProfileState copyWith({
    UserModel? user,
    List<AchievementModel>? achievements,
    List<HistoryItemModel>? history,
    bool? loading,
    String? error,
    String? activeTab,
  }) {
    return ProfileState(
      user: user ?? this.user,
      achievements: achievements ?? this.achievements,
      history: history ?? this.history,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  List<Object?> get props => [user, achievements, history, loading, error, activeTab];
}
