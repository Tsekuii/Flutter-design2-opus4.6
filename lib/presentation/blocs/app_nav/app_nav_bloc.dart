import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/constants/app_constants.dart';

part 'app_nav_event.dart';
part 'app_nav_state.dart';

class AppNavBloc extends Bloc<AppNavEvent, AppNavState> {
  AppNavBloc() : super(AppNavState(selectedIndex: AppConstants.navHome)) {
    on<AppNavTabChanged>(_onTabChanged);
  }

  void _onTabChanged(AppNavTabChanged event, Emitter<AppNavState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
