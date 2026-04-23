import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));
String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String? username;
  String? password;
  int? expiresInMins;

  LoginRequest({
    required this.username,
    required this.password,
    this.expiresInMins,
  });

  LoginRequest.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
    expiresInMins = json['expiresInMins'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    if (expiresInMins != null) {
      map['expiresInMins'] = expiresInMins;
    }
    return map;
  }
}