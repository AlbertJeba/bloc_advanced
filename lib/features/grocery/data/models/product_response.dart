import 'dart:convert';
import 'package:bloc_advanced/features/grocery/data/models/product_model.dart';
import 'package:bloc_advanced/shared/models/page_meta.dart';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  final bool? status;
  final String? message;
  final ProductData? data;

  const ProductResponse({this.status, this.message, this.data});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? ProductData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class ProductData {
  final List<ProductModel>? items;
  final PageMeta? pageMeta;

  const ProductData({this.items, this.pageMeta});

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    items: json["items"] != null
        ? List<ProductModel>.from(
            json["items"].map((x) => ProductModel.fromJson(x)),
          )
        : [],
    pageMeta: json["pageMeta"] != null
        ? PageMeta.fromJson(json["pageMeta"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    if (items != null)
      "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    if (pageMeta != null) "pageMeta": pageMeta?.toJson(),
  };
}
