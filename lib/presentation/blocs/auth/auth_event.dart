part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({required this.email, required this.password});
  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}

class AuthSignUpRequested extends AuthEvent {
  const AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.displayName,
    required this.classGrade,
  });
  final String email;
  final String password;
  final String displayName;
  final int classGrade;
  @override
  List<Object?> get props => [email, password, displayName, classGrade];
}

class AuthLogoutRequested extends AuthEvent {}
