// To parse this JSON data, do
//
//     final poolDistributor = poolDistributorFromJson(jsonString);

import 'dart:convert';

List<PoolDistributor> poolDistributorFromJson(String str) => List<PoolDistributor>.from(json.decode(str).map((x) => PoolDistributor.fromJson(x)));

String poolDistributorToJson(List<PoolDistributor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoolDistributor {
  int? poolDetailId;
  int? distributorId;
  int? distWarehouseId;

  PoolDistributor({
    this.poolDetailId,
    this.distributorId,
    this.distWarehouseId
  });

  factory PoolDistributor.fromJson(Map<String, dynamic> json) => PoolDistributor(
    poolDetailId: json["pool_detail_id"],
    distributorId: json["distributor_id"],
    distWarehouseId: json["distributor_warehouse_id"],
  );

  Map<String, dynamic> toJson() => {
    "pool_detail_id": poolDetailId,
    "distributor_id": distributorId,
    "distributor_warehouse_id": distWarehouseId,
  };


}
