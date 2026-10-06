import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final String? id;
  final String? name;
  final String? slug;
  final String? iconUrl;
  final String? bannerUrl;
  final int? displayOrder;
  final List<SubcategoryModel>? subcategories;

  const CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.iconUrl,
    this.bannerUrl,
    this.displayOrder,
    this.subcategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    slug: json["slug"] ?? "",
    iconUrl: json["iconUrl"] ?? "",
    bannerUrl: json["bannerUrl"] ?? "",
    displayOrder: json["displayOrder"] ?? 0,
    subcategories: json["subcategories"] != null
        ? (json["subcategories"] as List)
              .map((e) => SubcategoryModel.fromJson(e))
              .toList()
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "iconUrl": iconUrl,
    "bannerUrl": bannerUrl,
    "displayOrder": displayOrder,
    if (subcategories != null)
      "subcategories": subcategories!.map((e) => e.toJson()).toList(),
  };
}

class SubcategoryModel {
  final String? id;
  final String? name;
  final String? slug;
  final String? iconUrl;

  const SubcategoryModel({this.id, this.name, this.slug, this.iconUrl});

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      SubcategoryModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        slug: json["slug"] ?? "",
        iconUrl: json["iconUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "iconUrl": iconUrl,
  };
}
