import 'dart:convert';
import 'package:bloc_advanced/features/grocery/data/models/category_model.dart';

CategoryResponse categoryResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  final bool? status;
  final String? message;
  final CategoryData? data;

  const CategoryResponse({this.status, this.message, this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? CategoryData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class CategoryData {
  final List<CategoryModel>? items;

  const CategoryData({this.items});

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    items: json["items"] != null
        ? List<CategoryModel>.from(
            json["items"].map((x) => CategoryModel.fromJson(x)),
          )
        : [],
  );

  Map<String, dynamic> toJson() => {
    if (items != null)
      "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}
