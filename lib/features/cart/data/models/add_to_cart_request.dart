import 'dart:convert';

AddToCartRequest addToCartRequestFromJson(String str) =>
    AddToCartRequest.fromJson(json.decode(str));

String addToCartRequestToJson(AddToCartRequest data) =>
    json.encode(data.toJson());

class AddToCartRequest {
  final String? productId;
  final int? quantity;

  const AddToCartRequest({required this.productId, this.quantity = 1});

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      AddToCartRequest(
        productId: json["productId"] ?? "",
        quantity: json["quantity"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
  };
}
