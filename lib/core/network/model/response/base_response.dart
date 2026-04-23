import 'dart:convert';

BaseResponse baseResponseFromJson(String str) => BaseResponse.fromJson(json.decode(str));
String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

/// BaseResponse handles common outer structure of API responses.
class BaseResponse {
  num? status;
  String? message;

  BaseResponse({
    this.status,
    this.message,
  });

  BaseResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  BaseResponse copyWith({
    num? status,
    String? message,
  }) {
    return BaseResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }
}
