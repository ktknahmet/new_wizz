// To parse this JSON data, do
//
//     final commisionTypes = commisionTypesFromJson(jsonString);

import 'dart:convert';

List<CommisionTypes> commisionTypesFromJson(String str) => List<CommisionTypes>.from(json.decode(str).map((x) => CommisionTypes.fromJson(x)));

String commisionTypesToJson(List<CommisionTypes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommisionTypes {
  int? calcTypeId;
  String? calcName;
  bool? isActive;
  dynamic createdAt;
  dynamic updatedAt;

  CommisionTypes({
    this.calcTypeId,
    this.calcName,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory CommisionTypes.fromJson(Map<String, dynamic> json) => CommisionTypes(
    calcTypeId: json["calc_type_id"],
    calcName: json["calc_name"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "calc_type_id": calcTypeId,
    "calc_name": calcName,
    "is_active": isActive,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
