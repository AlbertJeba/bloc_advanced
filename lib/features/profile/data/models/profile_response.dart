import 'dart:convert';
import 'package:bloc_advanced/shared/models/user_data.dart';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  final bool? status;
  final String? message;
  final UserData? data;

  const ProfileResponse({this.status, this.message, this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? UserData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}
