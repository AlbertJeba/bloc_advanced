import 'dart:convert';
import 'package:bloc_advanced/core/constants/constant.dart';

OrderRequest orderRequestFromJson(String str) =>
    OrderRequest.fromJson(json.decode(str));

String orderRequestToJson(OrderRequest data) => json.encode(data.toJson());

class OrderRequest {
  final int page;
  final int limit;
  final String? status;

  const OrderRequest({this.page = 1, this.limit = pageLimit, this.status});

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
    page: json["page"] ?? 1,
    limit: json["limit"] ?? pageLimit,
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    if (status != null && status!.isNotEmpty) "status": status,
  };

  Map<String, dynamic> toQueryParams() => {
    "page": page,
    "limit": limit,
    if (status != null && status!.isNotEmpty) "status": status,
  };
}
