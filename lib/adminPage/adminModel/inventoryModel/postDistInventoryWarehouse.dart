// To parse this JSON data, do
//
//     final postDistInventoryWarehouse = postDistInventoryWarehouseFromJson(jsonString);

import 'dart:convert';

PostDistInventoryWarehouse postDistInventoryWarehouseFromJson(String str) => PostDistInventoryWarehouse.fromJson(json.decode(str));

String postDistInventoryWarehouseToJson(PostDistInventoryWarehouse data) => json.encode(data.toJson());

class PostDistInventoryWarehouse {
  int? distributorWarehouseId;
  int? poolDetailId;

  PostDistInventoryWarehouse({
    this.distributorWarehouseId,
    this.poolDetailId,
  });

  factory PostDistInventoryWarehouse.fromJson(Map<String, dynamic> json) => PostDistInventoryWarehouse(
    distributorWarehouseId: json["distributor_warehouse_id"],
    poolDetailId: json["pool_detail_id"],
  );

  Map<String, dynamic> toJson() => {
    "distributor_warehouse_id": distributorWarehouseId,
    "pool_detail_id": poolDetailId,
  };
}
