import 'dart:convert';

ProductDetailResponse productDetailResponseFromJson(String str) =>
    ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) =>
    json.encode(data.toJson());

class ProductDetailResponse {
  final bool? status;
  final String? message;
  final ProductDetailModel? data;

  const ProductDetailResponse({this.status, this.message, this.data});

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? ProductDetailModel.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class ProductDetailModel {
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
  final List<String>? images;
  final String? description;
  final NutritionModel? nutrition;
  final String? categoryName;
  final String? subcategoryName;

  const ProductDetailModel({
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
    this.images,
    this.description,
    this.nutrition,
    this.categoryName,
    this.subcategoryName,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
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
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x.toString()))
            : [],
        description: json["description"] ?? "",
        nutrition: json["nutrition"] != null
            ? NutritionModel.fromJson(json["nutrition"])
            : null,
        categoryName: json["categoryName"] ?? "",
        subcategoryName: json["subcategoryName"] ?? "",
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
    if (images != null) "images": List<dynamic>.from(images!.map((x) => x)),
    "description": description,
    if (nutrition != null) "nutrition": nutrition?.toJson(),
    "categoryName": categoryName,
    "subcategoryName": subcategoryName,
  };
}

class NutritionModel {
  final String? calories;
  final String? carbs;
  final String? fat;
  final String? protein;

  const NutritionModel({this.calories, this.carbs, this.fat, this.protein});

  factory NutritionModel.fromJson(Map<String, dynamic> json) => NutritionModel(
    calories: json["calories"] ?? "",
    carbs: json["carbs"] ?? "",
    fat: json["fat"] ?? "",
    protein: json["protein"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "calories": calories,
    "carbs": carbs,
    "fat": fat,
    "protein": protein,
  };
}
