import 'dart:convert';

ProductRequest productRequestFromJson(String str) =>
    ProductRequest.fromJson(json.decode(str));

String productRequestToJson(ProductRequest data) => json.encode(data.toJson());

class ProductRequest {
  final int? page;
  final int? limit;
  final String? categoryId;
  final String? subcategoryId;
  final String? search;
  final String? sortBy;

  const ProductRequest({
    this.page,
    this.limit,
    this.categoryId,
    this.subcategoryId,
    this.search,
    this.sortBy,
  });

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
    page: json["page"],
    limit: json["limit"],
    categoryId: json["categoryId"] ?? "",
    subcategoryId: json["subcategoryId"] ?? "",
    search: json["search"] ?? "",
    sortBy: json["sortBy"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    if (page != null) "page": page,
    if (limit != null) "limit": limit,
    if (categoryId != null && categoryId!.isNotEmpty) "categoryId": categoryId,
    if (subcategoryId != null && subcategoryId!.isNotEmpty)
      "subcategoryId": subcategoryId,
    if (search != null && search!.isNotEmpty) "search": search,
    if (sortBy != null && sortBy!.isNotEmpty) "sortBy": sortBy,
  };

  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> params = {};
    if (page != null) {
      params["page"] = page;
    }
    if (limit != null) {
      params["limit"] = limit;
    }
    if (categoryId != null && categoryId!.isNotEmpty) {
      params["categoryId"] = categoryId;
    }
    if (subcategoryId != null && subcategoryId!.isNotEmpty) {
      params["subcategoryId"] = subcategoryId;
    }
    if (search != null && search!.isNotEmpty) {
      params["search"] = search;
    }
    if (sortBy != null && sortBy!.isNotEmpty) {
      params["sortBy"] = sortBy;
    }
    return params;
  }
}
