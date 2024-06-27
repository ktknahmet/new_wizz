// To parse this JSON data, do
//
//     final updateProductCoast = updateProductCoastFromJson(jsonString);

import 'dart:convert';

UpdateProductCoast updateProductCoastFromJson(String str) => UpdateProductCoast.fromJson(json.decode(str));

String updateProductCoastToJson(UpdateProductCoast data) => json.encode(data.toJson());

class UpdateProductCoast {
  int? costId;
  String? costAmount;

  UpdateProductCoast({
    this.costId,
    this.costAmount,
  });

  factory UpdateProductCoast.fromJson(Map<String, dynamic> json) => UpdateProductCoast(
    costId: json["cost_id"],
    costAmount: json["cost_amount"],
  );

  Map<String, dynamic> toJson() => {
    "cost_id": costId,
    "cost_amount": costAmount,
  };
}
