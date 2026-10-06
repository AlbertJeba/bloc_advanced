import 'dart:convert';

OrderDetailResponse orderDetailResponseFromJson(String str) =>
    OrderDetailResponse.fromJson(json.decode(str));

String orderDetailResponseToJson(OrderDetailResponse data) =>
    json.encode(data.toJson());

class OrderDetailResponse {
  final bool? status;
  final String? message;
  final OrderDetailData? data;

  const OrderDetailResponse({this.status, this.message, this.data});

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? OrderDetailData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class OrderDetailData {
  final String? id;
  final String? orderId;
  final String? orderNumber;
  final String? status;
  final String? orderStatus;
  final num? subtotal;
  final num? discount;
  final num? deliveryFee;
  final num? taxes;
  final num? grandTotal;
  final num? totalPayable;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? deliverySlot;
  final String? estimatedDeliveryTime;
  final OrderDriver? driver;
  final String? createdAt;
  final List<OrderItemDetail>? items;
  final OrderDeliveryAddress? address;
  final List<OrderTimelineItem>? timeline;

  const OrderDetailData({
    this.id,
    this.orderId,
    this.orderNumber,
    this.status,
    this.orderStatus,
    this.subtotal,
    this.discount,
    this.deliveryFee,
    this.taxes,
    this.grandTotal,
    this.totalPayable,
    this.paymentMethod,
    this.paymentStatus,
    this.deliverySlot,
    this.estimatedDeliveryTime,
    this.driver,
    this.createdAt,
    this.items,
    this.address,
    this.timeline,
  });

  factory OrderDetailData.fromJson(Map<String, dynamic> json) =>
      OrderDetailData(
        id: json["id"] ?? "",
        orderId: json["orderId"] ?? "",
        orderNumber: json["orderNumber"] ?? "",
        status: (json["status"] ?? json["orderStatus"]) ?? "PLACED",
        orderStatus: (json["orderStatus"] ?? json["status"]) ?? "PLACED",
        subtotal: json["subtotal"] ?? 0,
        discount: json["discount"] ?? 0,
        deliveryFee: json["deliveryFee"] ?? 0,
        taxes: (json["taxes"] ?? json["tax"]) ?? 0,
        grandTotal: json["grandTotal"] ?? 0,
        totalPayable: (json["totalPayable"] ?? json["grandTotal"]) ?? 0,
        paymentMethod: json["paymentMethod"] ?? "COD",
        paymentStatus: json["paymentStatus"] ?? "PENDING",
        deliverySlot: json["deliverySlot"] ?? "",
        estimatedDeliveryTime: json["estimatedDeliveryTime"] ?? "",
        driver: json["driver"] != null
            ? OrderDriver.fromJson(json["driver"])
            : null,
        createdAt: json["createdAt"] ?? "",
        items: json["items"] != null
            ? List<OrderItemDetail>.from(
                json["items"].map((x) => OrderItemDetail.fromJson(x)),
              )
            : [],
        address: json["address"] != null
            ? OrderDeliveryAddress.fromJson(json["address"])
            : null,
        timeline: json["timeline"] != null
            ? List<OrderTimelineItem>.from(
                json["timeline"].map((x) => OrderTimelineItem.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderId": orderId,
    "orderNumber": orderNumber,
    "status": status,
    "orderStatus": orderStatus,
    "subtotal": subtotal,
    "discount": discount,
    "deliveryFee": deliveryFee,
    "taxes": taxes,
    "grandTotal": grandTotal,
    "totalPayable": totalPayable,
    "paymentMethod": paymentMethod,
    "paymentStatus": paymentStatus,
    "deliverySlot": deliverySlot,
    "estimatedDeliveryTime": estimatedDeliveryTime,
    if (driver != null) "driver": driver?.toJson(),
    "createdAt": createdAt,
    if (items != null)
      "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    if (address != null) "address": address?.toJson(),
    if (timeline != null)
      "timeline": List<dynamic>.from(timeline!.map((x) => x.toJson())),
  };
}

class OrderDriver {
  final String? name;
  final String? phone;
  final String? vehicle;

  const OrderDriver({this.name, this.phone, this.vehicle});

  factory OrderDriver.fromJson(Map<String, dynamic> json) => OrderDriver(
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    vehicle: json["vehicle"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "vehicle": vehicle,
  };
}

class OrderItemDetail {
  final String? id;
  final String? productId;
  final String? productName;
  final String? packSize;
  final num? unitPrice;
  final int? quantity;
  final num? totalPrice;

  const OrderItemDetail({
    this.id,
    this.productId,
    this.productName,
    this.packSize,
    this.unitPrice,
    this.quantity,
    this.totalPrice,
  });

  factory OrderItemDetail.fromJson(Map<String, dynamic> json) =>
      OrderItemDetail(
        id: json["id"] ?? "",
        productId: json["productId"] ?? "",
        productName: json["productName"] ?? "",
        packSize: json["packSize"] ?? "",
        unitPrice: json["unitPrice"] ?? 0,
        quantity: json["quantity"] ?? 0,
        totalPrice: json["totalPrice"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "productName": productName,
    "packSize": packSize,
    "unitPrice": unitPrice,
    "quantity": quantity,
    "totalPrice": totalPrice,
  };
}

class OrderDeliveryAddress {
  final String? id;
  final String? tag;
  final String? formattedAddress;

  const OrderDeliveryAddress({this.id, this.tag, this.formattedAddress});

  factory OrderDeliveryAddress.fromJson(Map<String, dynamic> json) =>
      OrderDeliveryAddress(
        id: json["id"] ?? "",
        tag: json["tag"] ?? "Home",
        formattedAddress: json["formattedAddress"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tag": tag,
    "formattedAddress": formattedAddress,
  };
}

class OrderTimelineItem {
  final String? status;
  final String? label;
  final bool? completed;
  final String? timestamp;

  const OrderTimelineItem({
    this.status,
    this.label,
    this.completed,
    this.timestamp,
  });

  factory OrderTimelineItem.fromJson(Map<String, dynamic> json) =>
      OrderTimelineItem(
        status: json["status"] ?? "",
        label: json["label"] ?? "",
        completed: json["completed"] ?? false,
        timestamp: json["timestamp"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "label": label,
    "completed": completed,
    "timestamp": timestamp,
  };
}
