// To parse this JSON data, do
//
//     final comAmount = comAmountFromJson(jsonString);

import 'dart:convert';

ComAmount comAmountFromJson(String str) => ComAmount.fromJson(json.decode(str));

String comAmountToJson(ComAmount data) => json.encode(data.toJson());

class ComAmount {
  int? calcPoolId;
  List<Amount>? amounts;

  ComAmount({
    this.calcPoolId,
    this.amounts,
  });

  factory ComAmount.fromJson(Map<String, dynamic> json) => ComAmount(
    calcPoolId: json["calc_pool_id"],
    amounts: List<Amount>.from(json["amounts"].map((x) => Amount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "calc_pool_id": calcPoolId,
    "amounts": List<dynamic>.from(amounts!.map((x) => x.toJson())),
  };
}

class Amount {
  int? amountLevel1;
  int? amountLevel2;
  int? commAmount;
  int? comPercentage;

  Amount({
    this.amountLevel1,
    this.amountLevel2,
    this.commAmount,
    this.comPercentage
  });

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
    amountLevel1: json["amount_level1"],
    amountLevel2: json["amount_level2"],
    commAmount: json["comm_amount"],
    comPercentage: json["comm_percentage"]
  );

  Map<String, dynamic> toJson() => {
    "amount_level1": amountLevel1,
    "amount_level2": amountLevel2,
    "comm_amount": commAmount,
    "comm_percentage":comPercentage
  };
}
