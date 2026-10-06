import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  dynamic id;
  String? username;
  String? name;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? gender;
  String? image;
  String? avatarUrl;
  String? accessToken;
  String? refreshToken;
  String? createdAt;

  UserData({
    this.id,
    this.username,
    this.name,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.gender,
    this.image,
    this.avatarUrl,
    this.accessToken,
    this.refreshToken,
    this.createdAt,
  });

  UserData.fromJson(dynamic json) {
    if (json == null) return;
    id = json['id'];
    name = json['name']?.toString() ?? json['firstName']?.toString();
    username = json['username']?.toString() ?? name;
    email = json['email']?.toString();
    firstName = json['firstName']?.toString() ?? name;
    lastName = json['lastName']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    avatarUrl = json['avatarUrl']?.toString() ?? json['image']?.toString();
    image = json['image']?.toString() ?? avatarUrl;
    accessToken = json['accessToken']?.toString();
    refreshToken = json['refreshToken']?.toString();
    createdAt = json['createdAt']?.toString();
  }

  /// Alias for accessToken for backward compatibility
  String? get token => accessToken;

  UserData copyWith({
    dynamic id,
    String? username,
    String? name,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? gender,
    String? image,
    String? avatarUrl,
    String? accessToken,
    String? refreshToken,
    String? createdAt,
  }) {
    return UserData(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['name'] = name;
    map['email'] = email;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['phone'] = phone;
    map['gender'] = gender;
    map['image'] = image;
    map['avatarUrl'] = avatarUrl;
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    map['createdAt'] = createdAt;
    return map;
  }
}
