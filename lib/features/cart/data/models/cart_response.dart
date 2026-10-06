import 'dart:convert';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  final bool? status;
  final String? message;
  final CartData? data;

  const CartResponse({this.status, this.message, this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] != null ? CartData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class CartData {
  final List<CartItemModel>? items;
  final int? itemCount;
  final num? subtotal;
  final num? savings;
  final num? deliveryFee;
  final num? grandTotal;

  const CartData({
    this.items,
    this.itemCount,
    this.subtotal,
    this.savings,
    this.deliveryFee,
    this.grandTotal,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    items: json["items"] != null
        ? List<CartItemModel>.from(
            json["items"].map((x) => CartItemModel.fromJson(x)),
          )
        : [],
    itemCount: json["itemCount"] ?? 0,
    subtotal: json["subtotal"] ?? 0,
    savings: json["savings"] ?? 0,
    deliveryFee: json["deliveryFee"] ?? 0,
    grandTotal: json["grandTotal"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    if (items != null)
      "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "itemCount": itemCount,
    "subtotal": subtotal,
    "savings": savings,
    "deliveryFee": deliveryFee,
    "grandTotal": grandTotal,
  };
}

class CartItemModel {
  final String? id;
  final String? productId;
  final String? productName;
  final String? slug;
  final String? packSize;
  final num? unitPrice;
  final num? mrp;
  final int? quantity;
  final num? totalPrice;
  final String? imageUrl;
  final int? stock;

  const CartItemModel({
    this.id,
    this.productId,
    this.productName,
    this.slug,
    this.packSize,
    this.unitPrice,
    this.mrp,
    this.quantity,
    this.totalPrice,
    this.imageUrl,
    this.stock,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    id: json["id"] ?? "",
    productId: json["productId"] ?? "",
    productName: json["productName"] ?? "",
    slug: json["slug"] ?? "",
    packSize: json["packSize"] ?? "",
    unitPrice: json["unitPrice"] ?? 0,
    mrp: json["mrp"] ?? 0,
    quantity: json["quantity"] ?? 0,
    totalPrice: json["totalPrice"] ?? 0,
    imageUrl: json["imageUrl"] ?? "",
    stock: json["stock"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "productName": productName,
    "slug": slug,
    "packSize": packSize,
    "unitPrice": unitPrice,
    "mrp": mrp,
    "quantity": quantity,
    "totalPrice": totalPrice,
    "imageUrl": imageUrl,
    "stock": stock,
  };
}
