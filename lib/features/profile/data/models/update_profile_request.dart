import 'dart:convert';

UpdateProfileRequest updateProfileRequestFromJson(String str) =>
    UpdateProfileRequest.fromJson(json.decode(str));

String updateProfileRequestToJson(UpdateProfileRequest data) =>
    json.encode(data.toJson());

class UpdateProfileRequest {
  final String? name;
  final String? phone;
  final String? avatarUrl;

  const UpdateProfileRequest({this.name, this.phone, this.avatarUrl});

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        avatarUrl: json["avatarUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    if (name != null) "name": name,
    if (phone != null) "phone": phone,
    if (avatarUrl != null) "avatarUrl": avatarUrl,
  };
}
