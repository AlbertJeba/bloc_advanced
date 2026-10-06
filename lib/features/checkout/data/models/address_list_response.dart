import 'dart:convert';
import 'package:bloc_advanced/features/checkout/data/models/address_model.dart';

AddressListResponse addressListResponseFromJson(String str) =>
    AddressListResponse.fromJson(json.decode(str));

String addressListResponseToJson(AddressListResponse data) =>
    json.encode(data.toJson());

class AddressListResponse {
  final bool? status;
  final String? message;
  final AddressListData? data;

  const AddressListResponse({this.status, this.message, this.data});

  factory AddressListResponse.fromJson(Map<String, dynamic> json) =>
      AddressListResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? AddressListData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if (data != null) "data": data?.toJson(),
  };
}

class AddressListData {
  final List<AddressModel>? items;

  const AddressListData({this.items});

  factory AddressListData.fromJson(Map<String, dynamic> json) =>
      AddressListData(
        items: json["items"] != null
            ? List<AddressModel>.from(
                json["items"].map((x) => AddressModel.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
    if (items != null)
      "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}
