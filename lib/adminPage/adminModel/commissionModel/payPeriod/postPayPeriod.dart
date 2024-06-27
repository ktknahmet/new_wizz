// To parse this JSON data, do
//
//     final comExist = comExistFromJson(jsonString);

import 'dart:convert';

PostPayPeriod postPayPeriodFromJson(String str) => PostPayPeriod.fromJson(json.decode(str));

String postPayPeriodToJson(PostPayPeriod data) => json.encode(data.toJson());

class PostPayPeriod {
  String? payPeriod;
  String? payDate;

  PostPayPeriod({
    this.payPeriod,
    this.payDate,
  });

  factory PostPayPeriod.fromJson(Map<String, dynamic> json) => PostPayPeriod(
    payPeriod: json["pay_period"],
    payDate: json["pay_date"],
  );

  Map<String, dynamic> toJson() => {
    "pay_period": payPeriod,
    "pay_date": payDate,
  };
}
