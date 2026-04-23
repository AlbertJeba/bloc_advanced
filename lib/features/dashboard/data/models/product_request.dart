import 'dart:convert';

ProductRequest productRequestFromJson(String str) => ProductRequest.fromJson(json.decode(str));
String productRequestToJson(ProductRequest data) => json.encode(data.toJson());

/// ProductRequest model for fetching products with pagination
class ProductRequest {
  int? limit;
  int? skip;

  ProductRequest({
    this.limit,
    this.skip,
  });

  ProductRequest.fromJson(dynamic json) {
    limit = json['limit'];
    skip = json['skip'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['limit'] = limit;
    map['skip'] = skip;
    return map;
  }
}
