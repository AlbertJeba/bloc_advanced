import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));
String userDataToJson(UserData data) => json.encode(data.toJson());

/// User data model matching DummyJSON user response
class UserData {
  String? username;
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? accessToken;
  String? refreshToken;

  UserData({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.accessToken,
    this.refreshToken,
  });

  UserData.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  /// Alias for accessToken for backward compatibility
  String? get token => accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['gender'] = gender;
    map['image'] = image;
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    return map;
  }
}
