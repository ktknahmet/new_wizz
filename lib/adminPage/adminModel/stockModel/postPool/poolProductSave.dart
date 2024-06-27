// To parse this JSON data, do
//
//     final poolProductSave = poolProductSaveFromJson(jsonString);

import 'dart:convert';

import 'package:wizzsales/adminPage/adminModel/stockModel/postPool/poolStockProduct.dart';

PoolProductSave poolProductSaveFromJson(String str) => PoolProductSave.fromJson(json.decode(str));

String poolProductSaveToJson(PoolProductSave data) => json.encode(data.toJson());

class PoolProductSave {
  int? stockPoolId;
  List<PoolStockProduct>? stockProducts;

  PoolProductSave({
    this.stockPoolId,
    this.stockProducts,
  });

  factory PoolProductSave.fromJson(Map<String, dynamic> json) => PoolProductSave(
    stockPoolId: json["stock_pool_id"],
    stockProducts: List<PoolStockProduct>.from(json["stock_products"].map((x) => PoolStockProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "stock_pool_id": stockPoolId,
    "stock_products": List<dynamic>.from(stockProducts!.map((x) => x.toJson())),
  };
}


