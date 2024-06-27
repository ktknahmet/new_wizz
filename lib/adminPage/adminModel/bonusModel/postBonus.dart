// To parse this JSON data, do
//
//     final postBonus = postBonusFromJson(jsonString);

import 'dart:convert';

import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusRule.dart';

PostBonus postBonusFromJson(String str) => PostBonus.fromJson(json.decode(str));

String postBonusToJson(PostBonus data) => json.encode(data.toJson());

class PostBonus {
  int? distributorId;
  List<BonusRule>? bonusRules;

  PostBonus({
    this.distributorId,
    this.bonusRules,
  });

  factory PostBonus.fromJson(Map<String, dynamic> json) => PostBonus(
    distributorId: json["distributor_id"],
    bonusRules: List<BonusRule>.from(json["bonus_rules"].map((x) => BonusRule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "distributor_id": distributorId,
    "bonus_rules": List<dynamic>.from(bonusRules!.map((x) => x.toJson())),
  };
}


