// To parse this JSON data, do
//
//     final returnStock = returnStockFromJson(jsonString);

import 'dart:convert';

ReturnStock returnStockFromJson(String str) => ReturnStock.fromJson(json.decode(str));

String returnStockToJson(ReturnStock data) => json.encode(data.toJson());

class ReturnStock {
  int? poolDetailId;

  ReturnStock({
    this.poolDetailId,
  });

  factory ReturnStock.fromJson(Map<String, dynamic> json) => ReturnStock(
    poolDetailId: json["pool_detail_id"],
  );

  Map<String, dynamic> toJson() => {
    "pool_detail_id": poolDetailId,
  };
}
