// To parse this JSON data, do
//
//     final getPoolHistory = getPoolHistoryFromJson(jsonString);

import 'dart:convert';

List<GetPoolHistory> getPoolHistoryFromJson(String str) => List<GetPoolHistory>.from(json.decode(str).map((x) => GetPoolHistory.fromJson(x)));

String getPoolHistoryToJson(List<GetPoolHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPoolHistory {
  int? stockPoolId;
  dynamic stockDate;
  int? totalQuantity;
  int? assignedProductQuantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? poolStatus;
  int? totalSavedStockOfPool;
  String? beginSerial;
  String? endSerial;



  GetPoolHistory({
    this.stockPoolId,
    this.stockDate,
    this.totalQuantity,
    this.assignedProductQuantity,
    this.createdAt,
    this.updatedAt,
    this.poolStatus,
    this.totalSavedStockOfPool,
    this.beginSerial,
    this.endSerial
  });

  factory GetPoolHistory.fromJson(Map<String, dynamic> json) => GetPoolHistory(
    stockPoolId: json["stock_pool_id"],
    stockDate: json["stock_date"],
    totalQuantity: json["total_quantity"],
    assignedProductQuantity: json["assigned_product_quantity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    poolStatus: json["pool_status"],
    totalSavedStockOfPool: json["totalSavedStockOfPool"],
    beginSerial: json["begin_serial_number"],
    endSerial: json["end_serial_number"],
  );

  Map<String, dynamic> toJson() => {
    "stock_pool_id": stockPoolId,
    "stock_date": stockDate,
    "total_quantity": totalQuantity,
    "assigned_product_quantity": assignedProductQuantity,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "pool_status": poolStatus,
    "totalSavedStockOfPool": totalSavedStockOfPool,
    "begin_serial_number": beginSerial,
    "end_serial_number": endSerial,
  };
}
