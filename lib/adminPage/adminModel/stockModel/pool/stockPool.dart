// To parse this JSON data, do
//
//     final stockPool = stockPoolFromJson(jsonString);

import 'dart:convert';

StockPool stockPoolFromJson(String str) => StockPool.fromJson(json.decode(str));

String stockPoolToJson(StockPool data) => json.encode(data.toJson());

class StockPool {
  String? stockDate;
  int? totalQuantity;
  String? beginSerial;
  String? endSerial;

  StockPool({
    this.stockDate,
    this.totalQuantity,
    this.beginSerial,
    this.endSerial
  });

  factory StockPool.fromJson(Map<String, dynamic> json) => StockPool(
    stockDate: json["stock_date"],
    totalQuantity: json["total_quantity"],
    beginSerial: json["begin_serial_number"],
    endSerial: json["end_serial_number"],
  );

  Map<String, dynamic> toJson() => {
    "stock_date": stockDate,
    "total_quantity": totalQuantity,
    "begin_serial_number": beginSerial,
    "end_serial_number": endSerial,
  };
}
