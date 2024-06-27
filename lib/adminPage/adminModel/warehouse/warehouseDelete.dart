// To parse this JSON data, do
//
//     final warehousePost = warehousePostFromJson(jsonString);

import 'dart:convert';

WarehouseDelete warehouseDeleteFromJson(String str) => WarehouseDelete.fromJson(json.decode(str));

String warehouseDeleteToJson(WarehouseDelete data) => json.encode(data.toJson());

class WarehouseDelete {
  int? warehouseId;


  WarehouseDelete({
    this.warehouseId,

  });

  factory WarehouseDelete.fromJson(Map<String, dynamic> json) => WarehouseDelete(
    warehouseId: json["warehouse_id"],

  );

  Map<String, dynamic> toJson() => {
    "warehouse_id": warehouseId,

  };
}
