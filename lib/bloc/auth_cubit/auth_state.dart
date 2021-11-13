part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class LoginInit extends AuthState {}

class LogingIn extends AuthState {}

class AlreadyLoggedIn extends AuthState {}

class LoggedIn extends AuthState {
  final LoginResponse loginResponse;
  final bool isLoggedIn;
  LoggedIn({
    required this.isLoggedIn,
    required this.loginResponse,
  });

  factory LoggedIn.fromMap(Map<String, dynamic> map) {
    return LoggedIn(
      isLoggedIn: map['is_logged_in'],
      loginResponse: LoginResponse.fromJson(map),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_logged_in': isLoggedIn,
      'token_type': loginResponse.tokenType,
      'expires_in': loginResponse.expiresIn,
      'access_token': loginResponse.accessToken,
      'refresh_token': loginResponse.refreshToken,
    };
  }

  String toJson() => json.encode(toMap());

  factory LoggedIn.fromJson(String source) =>
      LoggedIn.fromMap(json.decode(source));
}

class LoginError extends AuthState {}

class ResetPasswordInit extends AuthState {}

class PasswordResetDone extends AuthState {}

class ResetPasswordError extends AuthState {}

class LoggedOut extends AuthState {
  final LoginResponse loginResponse;
  final bool isLoggedIn;

  LoggedOut({required this.loginResponse, required this.isLoggedIn});
  factory LoggedOut.fromMap(Map<String, dynamic> map) {
    return LoggedOut(
      isLoggedIn: map['is_logged_in'],
      loginResponse: LoginResponse.fromJson(map),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_logged_in': isLoggedIn,
      'token_type': loginResponse.tokenType,
      'expires_in': loginResponse.expiresIn,
      'access_token': loginResponse.accessToken,
      'refresh_token': loginResponse.refreshToken,
    };
  }

  String toJson() => json.encode(toMap());

  factory LoggedOut.fromJson(String source) =>
      LoggedOut.fromMap(json.decode(source));
}
