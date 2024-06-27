// To parse this JSON data, do
//
//     final bonusOverlapping = bonusOverlappingFromJson(jsonString);

import 'dart:convert';

BonusOverlapping bonusOverlappingFromJson(String str) => BonusOverlapping.fromJson(json.decode(str));

String bonusOverlappingToJson(BonusOverlapping data) => json.encode(data.toJson());

class BonusOverlapping {
  int? distributorId;
  int? roleId;
  dynamic beginDate;
  dynamic endDate;
  String? bonusType;

  BonusOverlapping({
    this.distributorId,
    this.roleId,
    this.beginDate,
    this.endDate,
    this.bonusType,
  });

  factory BonusOverlapping.fromJson(Map<String, dynamic> json) => BonusOverlapping(
    distributorId: json["distributor_id"],
    roleId: json["role_id"],
    beginDate: json["begin_date"],
    endDate: json["end_date"],
    bonusType: json["bonus_type"],
  );

  Map<String, dynamic> toJson() => {
    "distributor_id": distributorId,
    "role_id": roleId,
    "begin_date": beginDate,
    "end_date": endDate,
    "bonus_type": bonusType,
  };
}
