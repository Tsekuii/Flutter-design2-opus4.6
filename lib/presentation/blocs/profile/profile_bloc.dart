import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/achievement_model.dart';
import '../../../data/models/history_item_model.dart';
import '../../../data/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._profileRepo) : super(ProfileState.initial()) {
    on<ProfileLoadRequested>(_onLoad);
    on<ProfileClassUpdated>(_onClassUpdated);
    on<ProfileTabChanged>(_onTabChanged);
  }

  final ProfileRepository _profileRepo;

  Future<void> _onLoad(ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final user = await _profileRepo.getProfile();
      final achievements = await _profileRepo.getAchievements();
      final history = await _profileRepo.getHistory();
      emit(state.copyWith(
        loading: false,
        user: user,
        achievements: achievements,
        history: history,
        activeTab: state.activeTab,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onClassUpdated(ProfileClassUpdated event, Emitter<ProfileState> emit) async {
    await _profileRepo.updateClassGrade(event.classGrade);
    add(ProfileLoadRequested());
  }

  void _onTabChanged(ProfileTabChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(activeTab: event.tab));
  }
}
