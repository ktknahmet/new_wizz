// To parse this JSON data, do
//
//     final productCoastList = productCoastListFromJson(jsonString);

import 'dart:convert';

List<ProductCoastList> productCoastListFromJson(String str) => List<ProductCoastList>.from(json.decode(str).map((x) => ProductCoastList.fromJson(x)));

String productCoastListToJson(List<ProductCoastList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCoastList {
  int? costId;
  int? productId;
  int? distributorId;
  String? costAmount;
  dynamic createdAt;
  dynamic updatedAt;
  String? productName;
  String? distName;

  ProductCoastList({
    this.costId,
    this.productId,
    this.distributorId,
    this.costAmount,
    this.createdAt,
    this.updatedAt,
    this.productName,
    this.distName
  });

  factory ProductCoastList.fromJson(Map<String, dynamic> json) => ProductCoastList(
    costId: json["cost_id"],
    productId: json["product_id"],
    distributorId: json["distributor_id"],
    costAmount: json["cost_amount"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    productName: json["product_name"],
    distName: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "cost_id": costId,
    "product_id": productId,
    "distributor_id": distributorId,
    "cost_amount": costAmount,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "product_name": productName,
    "name": distName,
  };
}
