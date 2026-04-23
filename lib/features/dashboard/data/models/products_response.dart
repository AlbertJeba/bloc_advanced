import 'dart:convert';
import 'package:bloc_advanced/features/dashboard/data/models/product.dart';

ProductsResponse productsResponseFromJson(String str) => ProductsResponse.fromJson(json.decode(str));
String productsResponseToJson(ProductsResponse data) => json.encode(data.toJson());

/// Products response model matching DummyJSON products list response
class ProductsResponse {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductsResponse({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  ProductsResponse.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products!.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }
}
