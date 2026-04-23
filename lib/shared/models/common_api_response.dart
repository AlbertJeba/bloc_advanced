import 'dart:convert';

CommonApiResponse commonApiResponseFromJson(String str) => CommonApiResponse.fromJson(json.decode(str));
String commonApiResponseToJson(CommonApiResponse data) => json.encode(data.toJson());

class CommonApiResponse {
  String? message;
  int? status;

  CommonApiResponse({
    this.message,
    this.status,
  });

  CommonApiResponse.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}
