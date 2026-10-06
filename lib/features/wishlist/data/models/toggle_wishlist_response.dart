import 'dart:convert';

ToggleWishlistResponse toggleWishlistResponseFromJson(String str) =>
    ToggleWishlistResponse.fromJson(json.decode(str));

String toggleWishlistResponseToJson(ToggleWishlistResponse data) =>
    json.encode(data.toJson());

class ToggleWishlistResponse {
  final bool? status;
  final String? message;
  final ToggleWishlistData? data;

  const ToggleWishlistResponse({this.status, this.message, this.data});

  factory ToggleWishlistResponse.fromJson(Map<String, dynamic> json) =>
      ToggleWishlistResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? ToggleWishlistData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class ToggleWishlistData {
  final bool? inWishlist;
  final String? productId;

  const ToggleWishlistData({this.inWishlist, this.productId});

  factory ToggleWishlistData.fromJson(Map<String, dynamic> json) =>
      ToggleWishlistData(
        inWishlist: json["inWishlist"] ?? false,
        productId: json["productId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "inWishlist": inWishlist,
    "productId": productId,
  };
}
