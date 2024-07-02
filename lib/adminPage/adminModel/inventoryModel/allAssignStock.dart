// To parse this JSON data, do
//
//     final allAssignStock = allAssignStockFromJson(jsonString);

import 'dart:convert';

List<AllAssignStock> allAssignStockFromJson(String str) => List<AllAssignStock>.from(json.decode(str).map((x) => AllAssignStock.fromJson(x)));

String allAssignStockToJson(List<AllAssignStock> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllAssignStock {
  int? poolDetailId;
  int? stockPoolId;
  int? productId;
  String? productName;
  String? stockDate;
  int? quantity;
  String? serialNumber;
  int? distributorId;
  bool? assignedToDistributor;
  bool? isPaid;
  dynamic paidAt;
  String? importerWarehouseName;
  String? distributorWarehouseName;
  bool? check;

  AllAssignStock({
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
    this.paidAt,
    this.importerWarehouseName,
    this.distributorWarehouseName,
    this.check = false
  });

  factory AllAssignStock.fromJson(Map<String, dynamic> json) => AllAssignStock(
    poolDetailId: json["pool_detail_id"],
    stockPoolId: json["stock_pool_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    stockDate: json["stock_date"],
    quantity: json["quantity"],
    serialNumber: json["serial_number"],
    distributorId: json["distributor_id"],
    assignedToDistributor: json["assigned_to_distributor"],
    isPaid: json["is_paid"],
    paidAt: json["paid_at"],
    importerWarehouseName: json["importer_warehouse_name"],
    distributorWarehouseName: json["distributor_warehouse_name"],
  );

  Map<String, dynamic> toJson() => {
    "pool_detail_id": poolDetailId,
    "stock_pool_id": stockPoolId,
    "product_id": productId,
    "product_name": productName,
    "stock_date": stockDate,
    "quantity": quantity,
    "serial_number": serialNumber,
    "distributor_id": distributorId,
    "assigned_to_distributor": assignedToDistributor,
    "is_paid": isPaid,
    "paid_at": paidAt,
    "importer_warehouse_name": importerWarehouseName,
    "distributor_warehouse_name": distributorWarehouseName,
  };
}

