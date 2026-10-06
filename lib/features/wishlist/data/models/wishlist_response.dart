import 'dart:convert';
import 'package:bloc_advanced/features/grocery/data/models/product_model.dart';
import 'package:bloc_advanced/shared/models/page_meta.dart';

WishlistResponse wishlistResponseFromJson(String str) =>
    WishlistResponse.fromJson(json.decode(str));

String wishlistResponseToJson(WishlistResponse data) =>
    json.encode(data.toJson());

class WishlistResponse {
  final bool? status;
  final String? message;
  final WishlistData? data;

  const WishlistResponse({this.status, this.message, this.data});

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      WishlistResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? WishlistData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class WishlistData {
  final List<ProductModel>? products;
  final PageMeta? pageMeta;

  const WishlistData({this.products, this.pageMeta});

  factory WishlistData.fromJson(Map<String, dynamic> json) => WishlistData(
    products: json["products"] != null
        ? List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x)),
          )
        : [],
    pageMeta: json["pageMeta"] != null
        ? PageMeta.fromJson(json["pageMeta"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    if (products != null)
      "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    if (pageMeta != null) "pageMeta": pageMeta?.toJson(),
  };
}
