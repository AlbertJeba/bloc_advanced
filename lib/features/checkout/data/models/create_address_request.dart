import 'dart:convert';

CreateAddressRequest createAddressRequestFromJson(String str) =>
    CreateAddressRequest.fromJson(json.decode(str));

String createAddressRequestToJson(CreateAddressRequest data) =>
    json.encode(data.toJson());

class CreateAddressRequest {
  final String? type;
  final String? addressLine1;
  final String? addressLine2;
  final String? landmark;
  final String? city;
  final String? state;
  final String? pincode;
  final String? phone;
  final bool? isDefault;

  const CreateAddressRequest({
    this.type,
    this.addressLine1,
    this.addressLine2,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.phone,
    this.isDefault,
  });

  factory CreateAddressRequest.fromJson(Map<String, dynamic> json) =>
      CreateAddressRequest(
        type: json["type"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        phone: json["phone"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
    if (type != null) "type": type,
    if (addressLine1 != null) "addressLine1": addressLine1,
    if (addressLine2 != null) "addressLine2": addressLine2,
    if (landmark != null) "landmark": landmark,
    if (city != null) "city": city,
    if (state != null) "state": state,
    if (pincode != null) "pincode": pincode,
    if (phone != null) "phone": phone,
    if (isDefault != null) "isDefault": isDefault,
  };
}
