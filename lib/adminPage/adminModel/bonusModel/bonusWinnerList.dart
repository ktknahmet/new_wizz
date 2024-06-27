// To parse this JSON data, do
//
//     final bonusWinnerList = bonusWinnerListFromJson(jsonString);

import 'dart:convert';

List<BonusWinnerList> bonusWinnerListFromJson(String str) => List<BonusWinnerList>.from(json.decode(str).map((x) => BonusWinnerList.fromJson(x)));

String bonusWinnerListToJson(List<BonusWinnerList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BonusWinnerList {
  int? bonusId;
  int? bonusRuleId;
  int? distributorId;
  int? profileId;
  dynamic vestingDate;
  String? bonusAmount;
  int? totalQuantity;
  int? roleId;
  String? bonusType;
  String? userName;
  String? roleName;

  BonusWinnerList({
    this.bonusId,
    this.bonusRuleId,
    this.distributorId,
    this.profileId,
    this.vestingDate,
    this.bonusAmount,
    this.totalQuantity,
    this.roleId,
    this.bonusType,
    this.userName,
    this.roleName,
  });

  factory BonusWinnerList.fromJson(Map<String, dynamic> json) => BonusWinnerList(
    bonusId: json["bonus_id"],
    bonusRuleId: json["bonus_rule_id"],
    distributorId: json["distributor_id"],
    profileId: json["profile_id"],
    vestingDate: json["vesting_date"],
    bonusAmount: json["bonus_amount"],
    totalQuantity: json["total_quantity"],
    roleId: json["role_id"],
    bonusType: json["bonus_type"],
    userName: json["user_name"],
    roleName: json["role_name"],
  );

  Map<String, dynamic> toJson() => {
    "bonus_id": bonusId,
    "bonus_rule_id": bonusRuleId,
    "distributor_id": distributorId,
    "profile_id": profileId,
    "vesting_date": vestingDate,
    "bonus_amount": bonusAmount,
    "total_quantity": totalQuantity,
    "role_id": roleId,
    "bonus_type": bonusType,
    "user_name": userName,
    "role_name": roleName,
  };
}
