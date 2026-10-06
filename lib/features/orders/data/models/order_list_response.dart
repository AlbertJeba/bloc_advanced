import 'dart:convert';

OrderListResponse orderListResponseFromJson(String str) =>
    OrderListResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderListResponse data) =>
    json.encode(data.toJson());

class OrderListResponse {
  final bool? status;
  final String? message;
  final OrderListData? data;

  const OrderListResponse({this.status, this.message, this.data});

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      OrderListResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? OrderListData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class OrderListData {
  final List<OrderSummaryItem>? items;
  final int? totalCount;
  final int? page;

  const OrderListData({this.items, this.totalCount, this.page});

  factory OrderListData.fromJson(Map<String, dynamic> json) => OrderListData(
    items: json["items"] != null
        ? List<OrderSummaryItem>.from(
            json["items"].map((x) => OrderSummaryItem.fromJson(x)),
          )
        : [],
    totalCount: json["totalCount"] ?? 0,
    page: json["page"] ?? 1,
  );

  Map<String, dynamic> toJson() => {
    if (items != null)
      "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "totalCount": totalCount,
    "page": page,
  };
}

class OrderSummaryItem {
  final String? id;
  final String? orderId;
  final String? orderNumber;
  final int? itemCount;
  final num? grandTotal;
  final num? totalPayable;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? status;
  final String? orderStatus;
  final String? estimatedDeliveryTime;
  final String? createdAt;

  const OrderSummaryItem({
    this.id,
    this.orderId,
    this.orderNumber,
    this.itemCount,
    this.grandTotal,
    this.totalPayable,
    this.paymentMethod,
    this.paymentStatus,
    this.status,
    this.orderStatus,
    this.estimatedDeliveryTime,
    this.createdAt,
  });

  factory OrderSummaryItem.fromJson(Map<String, dynamic> json) =>
      OrderSummaryItem(
        id: json["id"] ?? "",
        orderId: json["orderId"] ?? "",
        orderNumber: json["orderNumber"] ?? "",
        itemCount: json["itemCount"] ?? 0,
        grandTotal: json["grandTotal"] ?? 0,
        totalPayable: (json["totalPayable"] ?? json["grandTotal"]) ?? 0,
        paymentMethod: json["paymentMethod"] ?? "COD",
        paymentStatus: json["paymentStatus"] ?? "PENDING",
        status: (json["status"] ?? json["orderStatus"]) ?? "PLACED",
        orderStatus: (json["orderStatus"] ?? json["status"]) ?? "PLACED",
        estimatedDeliveryTime: json["estimatedDeliveryTime"] ?? "",
        createdAt: json["createdAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderId": orderId,
    "orderNumber": orderNumber,
    "itemCount": itemCount,
    "grandTotal": grandTotal,
    "totalPayable": totalPayable,
    "paymentMethod": paymentMethod,
    "paymentStatus": paymentStatus,
    "status": status,
    "orderStatus": orderStatus,
    "estimatedDeliveryTime": estimatedDeliveryTime,
    "createdAt": createdAt,
  };
}
