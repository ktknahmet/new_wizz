// To parse this JSON data, do
//
//     final distStockList = distStockListFromJson(jsonString);

import 'dart:convert';

List<DistStockList> distStockListFromJson(String str) => List<DistStockList>.from(json.decode(str).map((x) => DistStockList.fromJson(x)));

String distStockListToJson(List<DistStockList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistStockList {
  String? serialNumber;
  int? quantity;
  String? stockDate;
  int? poolDetailId;
  int? dealerId;
  String? dealerName;
  bool? assignedToDealer;
  String? assignedToDealerAt;
  bool? isPaid;
  String? payDate;
  bool? returnDist;
  dynamic returnDistAt;
  int? warehouseId;
  String? warehouseName;
  String? inSaleProgress;
  dynamic inSaleDate;
  bool? isHistory;

  DistStockList({
    this.serialNumber,
    this.quantity,
    this.stockDate,
    this.poolDetailId,
    this.dealerId,
    this.dealerName,
    this.assignedToDealer,
    this.assignedToDealerAt,
    this.isPaid,
    this.payDate,
    this.returnDist,
    this.returnDistAt,
    this.warehouseId,
    this.warehouseName,
    this.inSaleProgress,
    this.inSaleDate,
    this.isHistory,
  });

  factory DistStockList.fromJson(Map<String, dynamic> json) => DistStockList(
    serialNumber: json["serial_number"],
    quantity: json["quantity"],
    stockDate: json["stock_date"],
    poolDetailId: json["pool_detail_id"],
    dealerId: json["dealer_id"],
    dealerName: json["name"],
    assignedToDealer: json["assigned_to_dealer"],
    assignedToDealerAt: json["assigned_to_dealer_at"],
    isPaid: json["is_paid"],
    payDate: json["paid_at"],
    returnDist: json["return_distributor"],
    returnDistAt: json["return_to_distributor_at"],
    warehouseId: json["warehouse_id"],
    warehouseName: json["warehouse_name"],
    inSaleProgress: json["in_sale_process"],
    inSaleDate: json["in_sale_process_at"],
    isHistory: json["has_history"],
  );

  Map<String, dynamic> toJson() => {
    "serial_number": serialNumber,
    "quantity": quantity,
    "stock_date": stockDate,
    "pool_detail_id": poolDetailId,
    "dealer_id": dealerId,
    "name": dealerName,
    "assigned_to_dealer": assignedToDealer,
    "assigned_to_dealer_at": assignedToDealerAt,
    "is_paid": isPaid,
    "paid_at": payDate,
    "return_distributor": returnDist,
    "return_to_distributor_at": returnDistAt,
    "warehouse_id": warehouseId,
    "warehouse_name": warehouseName,
    "in_sale_process": inSaleProgress,
    "in_sale_process_at": inSaleDate,
    "has_history": isHistory
  };
}
