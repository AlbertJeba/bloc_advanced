import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  final String name;
  final String email;
  final String? phone;
  final String password;

  const RegisterRequest({
    required this.name,
    required this.email,
    this.phone,
    required this.password,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        password: json["password"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    if (phone != null && phone!.isNotEmpty) "phone": phone,
    "password": password,
  };
}
