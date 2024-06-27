// To parse this JSON data, do
//
//     final getPayPeriod = getPayPeriodFromJson(jsonString);

import 'dart:convert';

GetPayPeriod getPayPeriodFromJson(String str) => GetPayPeriod.fromJson(json.decode(str));

String getPayPeriodToJson(GetPayPeriod data) => json.encode(data.toJson());

class GetPayPeriod {
  int? periodId;
  int? distributorId;
  String? payPeriod;
  String? payDate;

  GetPayPeriod({
    this.periodId,
    this.distributorId,
    this.payPeriod,
    this.payDate,
  });

  factory GetPayPeriod.fromJson(Map<String, dynamic> json) => GetPayPeriod(
    periodId: json["period_id"],
    distributorId: json["distributor_id"],
    payPeriod: json["pay_period"],
    payDate: json["pay_date"],
  );

  Map<String, dynamic> toJson() => {
    "period_id": periodId,
    "distributor_id": distributorId,
    "pay_period": payPeriod,
    "pay_date": payDate,
  };
}
