// To parse this JSON data, do
//
//     final checkComAdd = checkComAddFromJson(jsonString);

import 'dart:convert';

CheckComAdd checkComAddFromJson(String str) => CheckComAdd.fromJson(json.decode(str));

String checkComAddToJson(CheckComAdd data) => json.encode(data.toJson());

class CheckComAdd {
  int? calcPoolId;
  int? amountLevel1;
  int? amountLevel2;

  CheckComAdd({
    this.calcPoolId,
    this.amountLevel1,
    this.amountLevel2,
  });

  factory CheckComAdd.fromJson(Map<String, dynamic> json) => CheckComAdd(
    calcPoolId: json["calc_pool_id"],
    amountLevel1: json["amount_level1"],
    amountLevel2: json["amount_level2"],
  );

  Map<String, dynamic> toJson() => {
    "calc_pool_id": calcPoolId,
    "amount_level1": amountLevel1,
    "amount_level2": amountLevel2,
  };
}
