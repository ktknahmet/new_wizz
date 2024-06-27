// To parse this JSON data, do
//
//     final updateComRate = updateComRateFromJson(jsonString);

import 'dart:convert';

UpdateComRate updateComRateFromJson(String str) => UpdateComRate.fromJson(json.decode(str));

String updateComRateToJson(UpdateComRate data) => json.encode(data.toJson());

class UpdateComRate {
  int? calcPoolDetId;
  int? amountLevel1;
  int? amountLevel2;
  String? commType;
  int? commAmount;
  int? commPercentage;

  UpdateComRate({
    this.calcPoolDetId,
    this.amountLevel1,
    this.amountLevel2,
    this.commType,
    this.commAmount,
    this.commPercentage,
  });

  factory UpdateComRate.fromJson(Map<String, dynamic> json) => UpdateComRate(
    calcPoolDetId: json["calc_pool_det_id"],
    amountLevel1: json["amount_level1"],
    amountLevel2: json["amount_level2"],
    commType: json["comm_type"],
    commAmount: json["comm_amount"],
    commPercentage: json["comm_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "calc_pool_det_id": calcPoolDetId,
    "amount_level1": amountLevel1,
    "amount_level2": amountLevel2,
    "comm_type": commType,
    "comm_amount": commAmount,
    "comm_percentage": commPercentage,
  };
}
