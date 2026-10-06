import 'dart:convert';

RemoveFromCartRequest removeFromCartRequestFromJson(String str) =>
    RemoveFromCartRequest.fromJson(json.decode(str));

String removeFromCartRequestToJson(RemoveFromCartRequest data) =>
    json.encode(data.toJson());

class RemoveFromCartRequest {
  final String productId;

  const RemoveFromCartRequest({
    required this.productId,
  });

  factory RemoveFromCartRequest.fromJson(Map<String, dynamic> json) =>
      RemoveFromCartRequest(
        productId: json["productId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
      };
}
