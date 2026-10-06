import 'dart:convert';

UpdateCartRequest updateCartRequestFromJson(String str) =>
    UpdateCartRequest.fromJson(json.decode(str));

String updateCartRequestToJson(UpdateCartRequest data) =>
    json.encode(data.toJson());

class UpdateCartRequest {
  final String productId;
  final int quantity;

  const UpdateCartRequest({
    required this.productId,
    required this.quantity,
  });

  factory UpdateCartRequest.fromJson(Map<String, dynamic> json) =>
      UpdateCartRequest(
        productId: json["productId"] ?? "",
        quantity: json["quantity"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}
