// To parse this JSON data, do
//
//     final comInactive = comInactiveFromJson(jsonString);

import 'dart:convert';

ComInactive comInactiveFromJson(String str) => ComInactive.fromJson(json.decode(str));

String comInactiveToJson(ComInactive data) => json.encode(data.toJson());

class ComInactive {
  int? calcPoolId;

  ComInactive({
    this.calcPoolId,
  });

  factory ComInactive.fromJson(Map<String, dynamic> json) => ComInactive(
    calcPoolId: json["calc_pool_id"],
  );

  Map<String, dynamic> toJson() => {
    "calc_pool_id": calcPoolId,
  };
}
