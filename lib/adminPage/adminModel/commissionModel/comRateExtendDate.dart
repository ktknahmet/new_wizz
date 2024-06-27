// To parse this JSON data, do
//
//     final comRateExtendDate = comRateExtendDateFromJson(jsonString);

import 'dart:convert';

ComRateExtendDate comRateExtendDateFromJson(String str) => ComRateExtendDate.fromJson(json.decode(str));

String comRateExtendDateToJson(ComRateExtendDate data) => json.encode(data.toJson());

class ComRateExtendDate {
  int? calcPoolId;
  dynamic calcExpireDate;

  ComRateExtendDate({
    this.calcPoolId,
    this.calcExpireDate,
  });

  factory ComRateExtendDate.fromJson(Map<String, dynamic> json) => ComRateExtendDate(
    calcPoolId: json["calc_pool_id"],
    calcExpireDate: json["calc_expire_date"],
  );

  Map<String, dynamic> toJson() => {
    "calc_pool_id": calcPoolId,
    "calc_expire_date": calcExpireDate,
  };
}
