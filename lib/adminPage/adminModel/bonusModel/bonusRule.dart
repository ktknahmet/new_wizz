class BonusRule {
  int? roleId;
  dynamic beginDate;
  dynamic endDate;
  String? bonusType;
  String? minQuantity;
  String? bonusAmount;

  BonusRule({
    this.roleId,
    this.beginDate,
    this.endDate,
    this.bonusType,
    this.minQuantity,
    this.bonusAmount,
  });

  factory BonusRule.fromJson(Map<String, dynamic> json) => BonusRule(
    roleId: json["role_id"],
    beginDate:json["begin_date"],
    endDate: json["end_date"],
    bonusType: json["bonus_type"],
    minQuantity: json["min_quantity"],
    bonusAmount: json["bonus_amount"],
  );

  Map<String, dynamic> toJson() => {
    "role_id": roleId,
    "begin_date": beginDate,
    "end_date": endDate,
    "bonus_type": bonusType,
    "min_quantity": minQuantity,
    "bonus_amount": bonusAmount,
  };
}