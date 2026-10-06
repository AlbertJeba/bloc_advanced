import 'dart:convert';

ToggleWishlistRequest toggleWishlistRequestFromJson(String str) =>
    ToggleWishlistRequest.fromJson(json.decode(str));

String toggleWishlistRequestToJson(ToggleWishlistRequest data) =>
    json.encode(data.toJson());

class ToggleWishlistRequest {
  final String? productId;

  const ToggleWishlistRequest({this.productId});

  factory ToggleWishlistRequest.fromJson(Map<String, dynamic> json) =>
      ToggleWishlistRequest(productId: json["productId"]);

  Map<String, dynamic> toJson() => {
    if (productId != null) "productId": productId,
  };
}
