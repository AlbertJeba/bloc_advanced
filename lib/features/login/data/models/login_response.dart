import 'dart:convert';
import 'package:bloc_advanced/shared/models/user_data.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) =>
    json.encode(data.toJson());

class LoginResponse {
  final bool? status;
  final String? message;
  final LoginData? data;

  const LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  String? get accessToken => data?.accessToken;

  String? get refreshToken => data?.refreshToken;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? LoginData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "message": message,
        if (data != null) "data": data?.toJson(),
      };
}

class LoginData {
  final String? accessToken;
  final String? refreshToken;
  final UserData? user;

  const LoginData({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      LoginData(
        accessToken: json["accessToken"] ?? "",
        refreshToken: json["refreshToken"] ?? "",
        user: json["user"] != null ? UserData.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() =>
      {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        if (user != null) "user": user?.toJson(),
      };
}

