// To parse this JSON data, do
//
//     final overrideType = overrideTypeFromJson(jsonString);

import 'dart:convert';

List<DeleteProductCoast> deleteProductCoastFromJson(String str) => List<DeleteProductCoast>.from(json.decode(str).map((x) => DeleteProductCoast.fromJson(x)));

String deleteProductCoastToJson(List<DeleteProductCoast> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeleteProductCoast {
  int? coastId;

  DeleteProductCoast({
    this.coastId,
  });

  factory DeleteProductCoast.fromJson(Map<String, dynamic> json) => DeleteProductCoast(
    coastId: json["cost_id"],
  );

  Map<String, dynamic> toJson() => {
    "cost_id": coastId,
  };
}
