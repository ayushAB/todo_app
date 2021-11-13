import 'dart:convert';

class LoginResponse {
  late String tokenType;
  late String accessToken;
  late int expiresIn;
  late String refreshToken;
  LoginResponse({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });
  Map<String, dynamic> toMap() {
    return {
      'token_type': tokenType,
      'expires_in': expiresIn,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  LoginResponse.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  String toJson() => json.encode(toMap());
}
