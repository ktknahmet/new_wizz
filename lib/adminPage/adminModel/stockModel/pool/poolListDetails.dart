// To parse this JSON data, do
//
//     final poolListDetails = poolListDetailsFromJson(jsonString);

import 'dart:convert';

List<PoolListDetails> poolListDetailsFromJson(String str) => List<PoolListDetails>.from(json.decode(str).map((x) => PoolListDetails.fromJson(x)));

String poolListDetailsToJson(List<PoolListDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoolListDetails {
  int? poolDetailId;
  int? stockPoolId;
  int? productId;
  String? productName;
  DateTime? stockDate;
  int? quantity;
  String? serialNumber;
  int? distributorId;
  bool? assignedToDistributor;
  bool? isPaid;
  dynamic paidDate;
  String? importerWarehouseName;
  String? distWarehouseName;
  int? distId;

  PoolListDetails({
    this.poolDetailId,
    this.stockPoolId,
    this.productId,
    this.productName,
    this.stockDate,
    this.quantity,
    this.serialNumber,
    this.distributorId,
    this.assignedToDistributor,
    this.isPaid,
    this.paidDate,
    this.importerWarehouseName,
    this.distWarehouseName,
    this.distId
  });

  factory PoolListDetails.fromJson(Map<String, dynamic> json) => PoolListDetails(
    poolDetailId: json["pool_detail_id"],
    stockPoolId: json["stock_pool_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    stockDate: DateTime.parse(json["stock_date"]),
    quantity: json["quantity"],
    serialNumber: json["serial_number"],
    distributorId: json["distributor_id"],
    assignedToDistributor: json["assigned_to_distributor"],
    isPaid: json["is_paid"],
    paidDate: json["paid_at"],
    importerWarehouseName: json["importer_warehouse_name"],
    distWarehouseName: json["distributor_warehouse_name"],
  );

  Map<String, dynamic> toJson() => {
    "pool_detail_id": poolDetailId,
    "stock_pool_id": stockPoolId,
    "product_id": productId,
    "product_name": productName,
    "stock_date": "${stockDate!.year.toString().padLeft(4, '0')}-${stockDate!.month.toString().padLeft(2, '0')}-${stockDate!.day.toString().padLeft(2, '0')}",
    "quantity": quantity,
    "serial_number": serialNumber,
    "distributor_id": distributorId,
    "assigned_to_distributor": assignedToDistributor,
    "is_paid": isPaid,
    "paid_at": paidDate,
    "importer_warehouse_name": importerWarehouseName,
    "distributor_warehouse_name": distWarehouseName,
  };
}
