// To parse this JSON data, do
//
//     final getWarehouseList = getWarehouseListFromJson(jsonString);

import 'dart:convert';

List<WarehouseList> getWarehouseListFromJson(String str) => List<WarehouseList>.from(json.decode(str).map((x) => WarehouseList.fromJson(x)));

String getWarehouseListToJson(List<WarehouseList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WarehouseList {
  int? warehouseId;
  String? warehouseType;
  String? warehouseName;
  String? warehouseAdress;
  String? warehouseCity;
  String? warehouseState;
  String? warehouseZipcode;
  String? warehouseSpocname;
  String? warehouseEmail;
  String? warehousePhone;
  dynamic distributorId;
  dynamic createdAt;
  dynamic updatedAt;
  String? orgName;

  WarehouseList({
    this.warehouseId,
    this.warehouseType,
    this.warehouseName,
    this.warehouseAdress,
    this.warehouseCity,
    this.warehouseState,
    this.warehouseZipcode,
    this.warehouseSpocname,
    this.warehouseEmail,
    this.warehousePhone,
    this.distributorId,
    this.createdAt,
    this.updatedAt,
    this.orgName
  });

  factory WarehouseList.fromJson(Map<String, dynamic> json) => WarehouseList(
    warehouseId: json["warehouse_id"],
    warehouseType: json["warehouse_type"],
    warehouseName: json["warehouse_name"],
    warehouseAdress: json["warehouse_adress"],
    warehouseCity: json["warehouse_city"],
    warehouseState: json["warehouse_state"],
    warehouseZipcode: json["warehouse_zipcode"],
    warehouseSpocname: json["warehouse_spocname"],
    warehouseEmail: json["warehouse_email"],
    warehousePhone: json["warehouse_phone"],
    distributorId: json["distributor_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    orgName: json["organisation_name"]
  );

  Map<String, dynamic> toJson() => {
    "warehouse_id": warehouseId,
    "warehouse_type": warehouseType,
    "warehouse_name": warehouseName,
    "warehouse_adress": warehouseAdress,
    "warehouse_city": warehouseCity,
    "warehouse_state": warehouseState,
    "warehouse_zipcode": warehouseZipcode,
    "warehouse_spocname": warehouseSpocname,
    "warehouse_email": warehouseEmail,
    "warehouse_phone": warehousePhone,
    "distributor_id": distributorId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "organisation_name":orgName
  };
}
