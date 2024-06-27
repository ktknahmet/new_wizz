// To parse this JSON data, do
//
//     final bonusRuleList = bonusRuleListFromJson(jsonString);

import 'dart:convert';

List<BonusRuleList> bonusRuleListFromJson(String str) => List<BonusRuleList>.from(json.decode(str).map((x) => BonusRuleList.fromJson(x)));

String bonusRuleListToJson(List<BonusRuleList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BonusRuleList {
  int? bonusRuleId;
  int? distributorId;
  int? roleId;
  dynamic beginDate;
  dynamic endDate;
  String? bonusType;
  int? minQuantity;
  String? bonusAmount;
  dynamic createdAt;
  dynamic updatedAt;
  bool? isActive;
  String? roleName;

  BonusRuleList({
    this.bonusRuleId,
    this.distributorId,
    this.roleId,
    this.beginDate,
    this.endDate,
    this.bonusType,
    this.minQuantity,
    this.bonusAmount,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.roleName,
  });

  factory BonusRuleList.fromJson(Map<String, dynamic> json) => BonusRuleList(
    bonusRuleId: json["bonus_rule_id"],
    distributorId: json["distributor_id"],
    roleId: json["role_id"],
    beginDate: json["begin_date"],
    endDate: json["end_date"],
    bonusType: json["bonus_type"],
    minQuantity: json["min_quantity"],
    bonusAmount: json["bonus_amount"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    isActive: json["is_active"],
    roleName: json["rolename"],
  );

  Map<String, dynamic> toJson() => {
    "bonus_rule_id": bonusRuleId,
    "distributor_id": distributorId,
    "role_id": roleId,
    "begin_date": beginDate,
    "end_date": endDate,
    "bonus_type": bonusType,
    "min_quantity": minQuantity,
    "bonus_amount": bonusAmount,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "is_active": isActive,
    "rolename": roleName,
  };
}
