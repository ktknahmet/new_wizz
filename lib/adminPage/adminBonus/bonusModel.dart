class BonusModel{
  String? roleName;
  int? roleId;
  String? startDate;
  String? endDate;
  String? bonusType;
  dynamic minQuantity;
  dynamic bonusAmount;


  BonusModel(this.roleName,this.roleId,this.startDate,this.endDate,this.bonusType,this.minQuantity,this.bonusAmount);
}