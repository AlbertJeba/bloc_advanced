import 'dart:convert';

CheckoutSummaryResponse checkoutSummaryResponseFromJson(String str) =>
    CheckoutSummaryResponse.fromJson(json.decode(str));

String checkoutSummaryResponseToJson(CheckoutSummaryResponse data) =>
    json.encode(data.toJson());

class CheckoutSummaryResponse {
  final bool? status;
  final String? message;
  final CheckoutSummaryData? data;

  const CheckoutSummaryResponse({this.status, this.message, this.data});

  factory CheckoutSummaryResponse.fromJson(Map<String, dynamic> json) =>
      CheckoutSummaryResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? CheckoutSummaryData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class CheckoutSummaryData {
  final int? itemCount;
  final num? subtotal;
  final num? savings;
  final String? couponCode;
  final num? discount;
  final num? deliveryFee;
  final num? taxes;
  final num? grandTotal;

  const CheckoutSummaryData({
    this.itemCount,
    this.subtotal,
    this.savings,
    this.couponCode,
    this.discount,
    this.deliveryFee,
    this.taxes,
    this.grandTotal,
  });

  factory CheckoutSummaryData.fromJson(Map<String, dynamic> json) =>
      CheckoutSummaryData(
        itemCount: json["itemCount"] ?? 0,
        subtotal: json["subtotal"] ?? 0,
        savings: json["savings"] ?? 0,
        couponCode: json["couponCode"] ?? "",
        discount: json["discount"] ?? 0,
        deliveryFee: json["deliveryFee"] ?? 0,
        taxes: (json["taxes"] ?? json["tax"]) ?? 0,
        grandTotal: (json["grandTotal"] ?? json["totalPayable"]) ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "itemCount": itemCount,
    "subtotal": subtotal,
    "savings": savings,
    "couponCode": couponCode,
    "discount": discount,
    "deliveryFee": deliveryFee,
    "taxes": taxes,
    "grandTotal": grandTotal,
  };
}
