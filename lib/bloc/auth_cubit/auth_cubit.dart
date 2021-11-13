import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/models/login_response.dart';
import 'package:todo_app/data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with HydratedMixin {
  final AuthRepository authRepository;
  AuthCubit(
    this.authRepository,
  ) : super(LoginInit());

  void login(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      emit(LoginError());
      return;
    }
    emit(LogingIn());
    authRepository.login(username, password).then((value) => {
          if (value != null)
            {emit(LoggedIn(isLoggedIn: true, loginResponse: value))}
          else
            {emit(LoginError())}
        });
  }

  void logout() {
    emit(LoggedOut(
        isLoggedIn: false,
        loginResponse: LoginResponse(
            accessToken: '', expiresIn: 0, refreshToken: '', tokenType: '')));
  }

  void resetPassword(String email) {
    if (email.isEmpty) {
      emit(ResetPasswordError());
      return;
    }
    authRepository.resetPassword(email).then((value) => {
          if (value != null)
            {emit(PasswordResetDone())}
          else
            {emit(ResetPasswordError())}
        });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return LoggedIn.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is LoggedIn) {
      return state.toMap();
    }

    return null;
  }
}
