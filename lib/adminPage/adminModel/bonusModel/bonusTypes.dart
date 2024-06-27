// To parse this JSON data, do
//
//     final bonusTypes = bonusTypesFromJson(jsonString);

import 'dart:convert';

List<BonusTypes> bonusTypesFromJson(String str) => List<BonusTypes>.from(json.decode(str).map((x) => BonusTypes.fromJson(x)));

String bonusTypesToJson(List<BonusTypes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BonusTypes {
  int? bonusTypeId;
  String? bonusType;

  BonusTypes({
    this.bonusTypeId,
    this.bonusType,
  });

  factory BonusTypes.fromJson(Map<String, dynamic> json) => BonusTypes(
    bonusTypeId: json["bonus_type_id"],
    bonusType: json["bonus_type"],
  );

  Map<String, dynamic> toJson() => {
    "bonus_type_id": bonusTypeId,
    "bonus_type": bonusType,
  };
}
