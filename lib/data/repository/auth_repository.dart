import 'package:todo_app/data/models/login_response.dart';
import 'package:todo_app/data/network/auth_service.dart';

class AuthRepository {
  final LoginService loginService;
  AuthRepository({
    required this.loginService,
  });
  Future<LoginResponse?> login(String username, String password) async {
    return await loginService.login(username, password);
  }

  Future<dynamic> resetPassword(String email) async {
    return await loginService.resetPassword(email);
  }
}
