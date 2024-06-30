// To parse this JSON data, do
//
//     final responseScanProduct = responseScanProductFromJson(jsonString);

import 'dart:convert';

ResponseScanProduct responseScanProductFromJson(String str) => ResponseScanProduct.fromJson(json.decode(str));

String responseScanProductToJson(ResponseScanProduct data) => json.encode(data.toJson());

class ResponseScanProduct {
  bool? isSuccess;
  String? message;
  int? totalQuantity;
  int? totalSavedStockOfPool;

  ResponseScanProduct({
    this.isSuccess,
    this.message,
    this.totalQuantity,
    this.totalSavedStockOfPool,
  });

  factory ResponseScanProduct.fromJson(Map<String, dynamic> json) => ResponseScanProduct(
    isSuccess: json["isSuccess"],
    message: json["message"],
    totalQuantity: json["total_quantity"],
    totalSavedStockOfPool: json["totalSavedStockOfPool"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "total_quantity": totalQuantity,
    "totalSavedStockOfPool": totalSavedStockOfPool,
  };
}
