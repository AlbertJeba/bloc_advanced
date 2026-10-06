import 'dart:convert';

OrderDetailRequest orderDetailRequestFromJson(String str) =>
    OrderDetailRequest.fromJson(json.decode(str));

String orderDetailRequestToJson(OrderDetailRequest data) =>
    json.encode(data.toJson());

class OrderDetailRequest {
  final String orderId;

  const OrderDetailRequest({
    required this.orderId,
  });

  factory OrderDetailRequest.fromJson(Map<String, dynamic> json) =>
      OrderDetailRequest(
        orderId: json["orderId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
      };
}
