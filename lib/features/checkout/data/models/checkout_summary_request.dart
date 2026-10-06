import 'dart:convert';

CheckoutSummaryRequest checkoutSummaryRequestFromJson(String str) =>
    CheckoutSummaryRequest.fromJson(json.decode(str));

String checkoutSummaryRequestToJson(CheckoutSummaryRequest data) =>
    json.encode(data.toJson());

class CheckoutSummaryRequest {
  final String? addressId;
  final String? couponCode;

  const CheckoutSummaryRequest({this.addressId, this.couponCode});

  factory CheckoutSummaryRequest.fromJson(Map<String, dynamic> json) =>
      CheckoutSummaryRequest(
        addressId: json["addressId"],
        couponCode: json["couponCode"],
      );

  Map<String, dynamic> toJson() => {
    if (addressId != null) "addressId": addressId,
    if (couponCode != null && couponCode!.isNotEmpty) "couponCode": couponCode,
  };
}
