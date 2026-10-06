import 'dart:convert';

ProductDetailRequest productDetailRequestFromJson(String str) =>
    ProductDetailRequest.fromJson(json.decode(str));

String productDetailRequestToJson(ProductDetailRequest data) =>
    json.encode(data.toJson());

class ProductDetailRequest {
  final String id;

  const ProductDetailRequest({
    required this.id,
  });

  factory ProductDetailRequest.fromJson(Map<String, dynamic> json) =>
      ProductDetailRequest(
        id: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
