part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);
  factory AuthState.loading() => const AuthState(status: AuthStatus.loading);
  factory AuthState.authenticated(UserModel u) => AuthState(status: AuthStatus.authenticated, user: u);
  factory AuthState.unauthenticated() => const AuthState(status: AuthStatus.unauthenticated);
  factory AuthState.failure(String msg) => AuthState(status: AuthStatus.failure, errorMessage: msg);

  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, user, errorMessage];
}
