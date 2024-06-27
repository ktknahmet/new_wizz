// To parse this JSON data, do
//
//     final postProductCoast = postProductCoastFromJson(jsonString);

import 'dart:convert';

PostProductCoast postProductCoastFromJson(String str) => PostProductCoast.fromJson(json.decode(str));

String postProductCoastToJson(PostProductCoast data) => json.encode(data.toJson());

class PostProductCoast {
  int? productId;
  int? distributorId;
  dynamic costAmount;

  PostProductCoast({
    this.productId,
    this.distributorId,
    this.costAmount,
  });

  factory PostProductCoast.fromJson(Map<String, dynamic> json) => PostProductCoast(
    productId: json["product_id"],
    distributorId: json["distributor_id"],
    costAmount: json["cost_amount"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "distributor_id": distributorId,
    "cost_amount": costAmount,
  };
}
