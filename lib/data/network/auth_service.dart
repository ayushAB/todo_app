import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:todo_app/data/models/login_response.dart';

//Will Handle
class LoginService {
  late String? baseUrl;
  late String? clientSecret;
  late String? grantType;
  late String? clientId;

  //initalizing
  LoginService() {
    baseUrl = dotenv.env['API_URL'];
    clientSecret = dotenv.env['CLIENT_SECRET'];
    grantType = dotenv.env['GRANT_TYPE'];
    clientId = dotenv.env['CLIENT_ID'];
  }
  Future<LoginResponse?> login(String username, String password) async {
    try {
      final response = await post(Uri.parse(baseUrl! + 'oauth/token'), body: {
        "grant_type": grantType,
        "client_id": clientId,
        "client_secret": clientSecret,
        "username": username,
        "password": password
      });
      return LoginResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> resetPassword(String email) async {
    try {
      final response = await post(Uri.parse(baseUrl! + 'api/password/email'),
          body: {"email": email});
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
