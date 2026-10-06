import 'dart:convert';

CreateOrderRequest createOrderRequestFromJson(String str) =>
    CreateOrderRequest.fromJson(json.decode(str));

String createOrderRequestToJson(CreateOrderRequest data) =>
    json.encode(data.toJson());

class CreateOrderRequest {
  final String? addressId;
  final String? paymentMethod;
  final String? deliveryInstructions;
  final String? couponCode;
  final int? tipAmount;

  const CreateOrderRequest({
    this.addressId,
    this.paymentMethod,
    this.deliveryInstructions,
    this.couponCode,
    this.tipAmount,
  });

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      CreateOrderRequest(
        addressId: json["addressId"],
        paymentMethod: json["paymentMethod"],
        deliveryInstructions: json["deliveryInstructions"],
        couponCode: json["couponCode"],
        tipAmount: json["tipAmount"],
      );

  Map<String, dynamic> toJson() => {
    if (addressId != null) "addressId": addressId,
    if (paymentMethod != null) "paymentMethod": paymentMethod,
    if (deliveryInstructions != null && deliveryInstructions!.isNotEmpty)
      "deliveryInstructions": deliveryInstructions,
    if (couponCode != null && couponCode!.isNotEmpty) "couponCode": couponCode,
    if (tipAmount != null) "tipAmount": tipAmount,
  };
}
