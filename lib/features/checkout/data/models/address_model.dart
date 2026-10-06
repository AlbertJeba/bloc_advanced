import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  final String? id;
  final String? userId;
  final String? type;
  final String? addressLine1;
  final String? addressLine2;
  final String? landmark;
  final String? city;
  final String? state;
  final String? pincode;
  final String? phone;
  final bool? isDefault;
  final String? formattedAddress;

  const AddressModel({
    this.id,
    this.userId,
    this.type,
    this.addressLine1,
    this.addressLine2,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.phone,
    this.isDefault,
    this.formattedAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"] ?? "",
    userId: json["userId"] ?? "",
    type: json["type"] ?? "Home",
    addressLine1: json["addressLine1"] ?? "",
    addressLine2: json["addressLine2"] ?? "",
    landmark: json["landmark"] ?? "",
    city: json["city"] ?? "",
    state: json["state"] ?? "",
    pincode: json["pincode"] ?? "",
    phone: json["phone"] ?? "",
    isDefault: json["isDefault"] ?? false,
    formattedAddress: json["formattedAddress"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "type": type,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "landmark": landmark,
    "city": city,
    "state": state,
    "pincode": pincode,
    "phone": phone,
    "isDefault": isDefault,
    "formattedAddress": formattedAddress,
  };
}
