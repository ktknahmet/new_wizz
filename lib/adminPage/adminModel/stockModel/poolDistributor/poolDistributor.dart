// To parse this JSON data, do
//
//     final poolDistributor = poolDistributorFromJson(jsonString);

import 'dart:convert';

List<PoolDistributor> poolDistributorFromJson(String str) => List<PoolDistributor>.from(json.decode(str).map((x) => PoolDistributor.fromJson(x)));

String poolDistributorToJson(List<PoolDistributor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoolDistributor {
  String? serialNumber;
  int? distributorId;
  int? distWarehouseId;

  PoolDistributor({
    this.serialNumber,
    this.distributorId,
    this.distWarehouseId
  });

  factory PoolDistributor.fromJson(Map<String, dynamic> json) => PoolDistributor(
    serialNumber: json["serial_number"],
    distributorId: json["distributor_id"],
    distWarehouseId: json["distributor_warehouse_id"],
  );

  Map<String, dynamic> toJson() => {
    "serial_number": serialNumber,
    "distributor_id": distributorId,
    "distributor_warehouse_id": distWarehouseId,
  };


}
