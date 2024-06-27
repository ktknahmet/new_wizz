// To parse this JSON data, do
//
//     final comExist = comExistFromJson(jsonString);

import 'dart:convert';

ComDetails comDetailsFromJson(String str) => ComDetails.fromJson(json.decode(str));

String comDetailsToJson(ComDetails data) => json.encode(data.toJson());

class ComDetails {
  dynamic paidComAnnual;
  dynamic notPaidComAnnual;
  dynamic paidComMonthly;
  dynamic notPaidComMonthly;
  dynamic paidComWeekly;
  dynamic notPaidComWeekly;
  dynamic paidComDaily;
  dynamic notPaidComDaily;
  dynamic paidComYesterday;
  dynamic notPaidComYesterday;
  dynamic paidComLastMonth;
  dynamic notPaidComLastMonth;

  ComDetails({
    this.paidComAnnual,
    this.notPaidComAnnual,
    this.paidComMonthly,
    this.notPaidComMonthly,
    this.paidComWeekly,
    this.notPaidComWeekly,
    this.paidComDaily,
    this.notPaidComDaily,
    this.paidComYesterday,
    this.notPaidComYesterday,
    this.paidComLastMonth,
    this.notPaidComLastMonth,
  });

  factory ComDetails.fromJson(Map<String, dynamic> json) => ComDetails(
    paidComAnnual: json["paid_commission_amount_annualy"],
    notPaidComAnnual: json["not_paid_commission_amount_annualy"],
    paidComMonthly: json["paid_commission_amount_monthly"],
    notPaidComMonthly: json["not_paid_commission_amount_monthly"],
    paidComWeekly: json["paid_commission_amount_weekly"],
    notPaidComWeekly: json["not_paid_commission_amount_weekly"],
    paidComDaily: json["paid_commission_amount_daily"],
    notPaidComDaily: json["not_paid_commission_amount_daily"],
    paidComYesterday: json["paid_commission_amount_yesterday"],
    notPaidComYesterday: json["not_paid_commission_amount_yesterday"],
    paidComLastMonth: json["paid_commission_amount_last_month"],
    notPaidComLastMonth: json["not_paid_commission_amount_last_month"],
  );

  Map<String, dynamic> toJson() => {
    "paid_commission_amount_annualy": paidComAnnual,
    "not_paid_commission_amount_annualy": notPaidComAnnual,
    "paid_commission_amount_monthly": paidComMonthly,
    "not_paid_commission_amount_monthly": notPaidComMonthly,
    "paid_commission_amount_weekly": paidComWeekly,
    "not_paid_commission_amount_weekly": notPaidComWeekly,
    "paid_commission_amount_daily": paidComDaily,
    "not_paid_commission_amount_daily": notPaidComDaily,
    "paid_commission_amount_yesterday": paidComYesterday,
    "not_paid_commission_amount_yesterday": notPaidComYesterday,
    "paid_commission_amount_last_month": paidComLastMonth,
    "not_paid_commission_amount_last_month": notPaidComLastMonth,
  };
}
