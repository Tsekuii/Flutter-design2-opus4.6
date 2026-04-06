part of 'app_nav_bloc.dart';

class AppNavEvent extends Equatable {
  const AppNavEvent();

  @override
  List<Object?> get props => [];
}

class AppNavTabChanged extends AppNavEvent {
  const AppNavTabChanged(this.index);
  final int index;

  @override
  List<Object?> get props => [index];
}
