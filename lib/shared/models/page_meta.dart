import 'dart:convert';
import 'package:bloc_advanced/core/constants/constant.dart';

// 1. Top-Level Helpers
PageMeta pageMetaFromJson(String str) => PageMeta.fromJson(json.decode(str));

String pageMetaToJson(PageMeta data) => json.encode(data.toJson());

class PageMeta {
  // 2. Variable Declarations
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  // 3. Default Constructor
  const PageMeta({this.page, this.limit, this.total, this.totalPages});

  // 4. Named Constructor
  factory PageMeta.fromJson(Map<String, dynamic> json) => PageMeta(
    page: json["page"] ?? 1,
    limit: json["limit"] ?? pageLimit,
    total: json["total"] ?? 0,
    totalPages: json["totalPages"] ?? 1,
  );

  // 5. Serialization Method
  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPages": totalPages,
  };
}
