import 'dart:convert';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  final bool? status;
  final String? message;
  final OrderData? data;

  const OrderResponse({this.status, this.message, this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] != null ? OrderData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class OrderData {
  final String? id;
  final String? orderNumber;
  final String? status;
  final num? subtotal;
  final num? discount;
  final num? deliveryFee;
  final num? taxes;
  final num? totalPayable;
  final String? paymentMethod;
  final String? estimatedDeliveryTime;
  final String? createdAt;

  const OrderData({
    this.id,
    this.orderNumber,
    this.status,
    this.subtotal,
    this.discount,
    this.deliveryFee,
    this.taxes,
    this.totalPayable,
    this.paymentMethod,
    this.estimatedDeliveryTime,
    this.createdAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"] ?? "",
    orderNumber: json["orderNumber"] ?? "",
    status: json["status"] ?? "PLACED",
    subtotal: json["subtotal"] ?? 0,
    discount: json["discount"] ?? 0,
    deliveryFee: json["deliveryFee"] ?? 0,
    taxes: (json["taxes"] ?? json["tax"]) ?? 0,
    totalPayable: (json["totalPayable"] ?? json["grandTotal"]) ?? 0,
    paymentMethod: json["paymentMethod"] ?? "COD",
    estimatedDeliveryTime: json["estimatedDeliveryTime"] ?? "",
    createdAt: json["createdAt"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderNumber": orderNumber,
    "status": status,
    "subtotal": subtotal,
    "discount": discount,
    "deliveryFee": deliveryFee,
    "taxes": taxes,
    "totalPayable": totalPayable,
    "paymentMethod": paymentMethod,
    "estimatedDeliveryTime": estimatedDeliveryTime,
    "createdAt": createdAt,
  };
}
