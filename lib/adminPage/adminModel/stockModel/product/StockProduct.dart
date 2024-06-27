// To parse this JSON data, do
//
//     final stockProduct = stockProductFromJson(jsonString);

import 'dart:convert';

List<StockProduct> stockProductFromJson(String str) => List<StockProduct>.from(json.decode(str).map((x) => StockProduct.fromJson(x)));

String stockProductToJson(List<StockProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockProduct {
  String? productName;
  int? productId;

  StockProduct({
    this.productName,
    this.productId,
  });

  factory StockProduct.fromJson(Map<String, dynamic> json) => StockProduct(
    productName: json["product_name"],
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "product_id": productId,
  };
}
