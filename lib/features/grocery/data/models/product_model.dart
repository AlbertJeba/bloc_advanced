import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final String? id;
  final String? categoryId;
  final String? subcategoryId;
  final String? name;
  final String? slug;
  final String? packSize;
  final num? mrp;
  final num? discountPrice;
  final int? stock;
  final String? imageUrl;
  final bool? isDeal;
  final String? dealBadge;
  final bool? isPopular;
  final num? rating;
  final int? ratingCount;

  const ProductModel({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.name,
    this.slug,
    this.packSize,
    this.mrp,
    this.discountPrice,
    this.stock,
    this.imageUrl,
    this.isDeal,
    this.dealBadge,
    this.isPopular,
    this.rating,
    this.ratingCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"] ?? "",
    categoryId: json["categoryId"] ?? "",
    subcategoryId: json["subcategoryId"] ?? "",
    name: json["name"] ?? "",
    slug: json["slug"] ?? "",
    packSize: json["packSize"] ?? "",
    mrp: json["mrp"] ?? 0,
    discountPrice: json["discountPrice"] ?? 0,
    stock: json["stock"] ?? 0,
    imageUrl: json["imageUrl"] ?? "",
    isDeal: json["isDeal"] ?? false,
    dealBadge: json["dealBadge"] ?? "",
    isPopular: json["isPopular"] ?? false,
    rating: json["rating"] ?? 0.0,
    ratingCount: json["ratingCount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryId": categoryId,
    "subcategoryId": subcategoryId,
    "name": name,
    "slug": slug,
    "packSize": packSize,
    "mrp": mrp,
    "discountPrice": discountPrice,
    "stock": stock,
    "imageUrl": imageUrl,
    "isDeal": isDeal,
    "dealBadge": dealBadge,
    "isPopular": isPopular,
    "rating": rating,
    "ratingCount": ratingCount,
  };
}
