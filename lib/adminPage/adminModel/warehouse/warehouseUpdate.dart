// To parse this JSON data, do
//
//     final warehousePost = warehousePostFromJson(jsonString);

import 'dart:convert';

WarehouseUpdate warehouseUpdateFromJson(String str) => WarehouseUpdate.fromJson(json.decode(str));

String warehouseUpdateToJson(WarehouseUpdate data) => json.encode(data.toJson());

class WarehouseUpdate {
  int? warehouseId;
  String? warehouseName;
  String? warehouseAdress;
  String? warehouseCity;
  String? warehouseState;
  String? warehouseZipcode;
  String? warehouseSpocName;
  String? warehouseEmail;
  String? warehousePhone;

  WarehouseUpdate({
    this.warehouseId,
    this.warehouseName,
    this.warehouseAdress,
    this.warehouseCity,
    this.warehouseState,
    this.warehouseZipcode,
    this.warehouseSpocName,
    this.warehouseEmail,
    this.warehousePhone,
  });

  factory WarehouseUpdate.fromJson(Map<String, dynamic> json) => WarehouseUpdate(
    warehouseId: json["warehouse_id"],
    warehouseName: json["warehouse_name"],
    warehouseAdress: json["warehouse_adress"],
    warehouseCity: json["warehouse_city"],
    warehouseState: json["warehouse_state"],
    warehouseZipcode: json["warehouse_zipcode"],
    warehouseSpocName: json["warehouse_spocName"],
    warehouseEmail: json["warehouse_email"],
    warehousePhone: json["warehouse_phone"],
  );

  Map<String, dynamic> toJson() => {
    "warehouse_id": warehouseId,
    "warehouse_name": warehouseName,
    "warehouse_adress": warehouseAdress,
    "warehouse_city": warehouseCity,
    "warehouse_state": warehouseState,
    "warehouse_zipcode": warehouseZipcode,
    "warehouse_spocName": warehouseSpocName,
    "warehouse_email": warehouseEmail,
    "warehouse_phone": warehousePhone,
  };
}
