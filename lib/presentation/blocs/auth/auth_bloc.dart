import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepo) : super(AuthState.initial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthLoginRequested>(_onLogin);
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthLogoutRequested>(_onLogout);
  }

  final AuthRepository _authRepo;

  void _onCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) {
    if (_authRepo.isLoggedIn && _authRepo.currentUser != null) {
      emit(AuthState.authenticated(_authRepo.currentUser!));
    } else {
      emit(AuthState.unauthenticated());
    }
  }

  Future<void> _onLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());
    try {
      final ok = await _authRepo.login(event.email, event.password);
      if (ok && _authRepo.currentUser != null) {
        emit(AuthState.authenticated(_authRepo.currentUser!));
      } else {
        emit(AuthState.failure('Нэвтрэхэд алдаа гарлаа'));
      }
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onSignUp(AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());
    try {
      final ok = await _authRepo.signUp(
        event.email,
        event.password,
        event.displayName,
        event.classGrade,
      );
      if (ok && _authRepo.currentUser != null) {
        emit(AuthState.authenticated(_authRepo.currentUser!));
      } else {
        emit(AuthState.failure('Бүртгүүлэхэд алдаа гарлаа'));
      }
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _authRepo.logout();
    emit(AuthState.unauthenticated());
  }
}
