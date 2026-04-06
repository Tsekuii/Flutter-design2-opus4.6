part of 'app_nav_bloc.dart';

class AppNavState extends Equatable {
  const AppNavState({this.selectedIndex = 0});

  final int selectedIndex;

  AppNavState copyWith({int? selectedIndex}) {
    return AppNavState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  @override
  List<Object?> get props => [selectedIndex];
}
