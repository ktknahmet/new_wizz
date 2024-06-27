// To parse this JSON data, do
//
//     final stockPostResponse = stockPostResponseFromJson(jsonString);

import 'dart:convert';

StockPostResponse stockPostResponseFromJson(String str) => StockPostResponse.fromJson(json.decode(str));

String stockPostResponseToJson(StockPostResponse data) => json.encode(data.toJson());

class StockPostResponse {
  bool? isSuccess;
  String? message;
  int? totalQuantity;
  int? totalSavedStockOfPool;

  StockPostResponse({
    this.isSuccess,
    this.message,
    this.totalQuantity,
    this.totalSavedStockOfPool,
  });

  factory StockPostResponse.fromJson(Map<String, dynamic> json) => StockPostResponse(
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
