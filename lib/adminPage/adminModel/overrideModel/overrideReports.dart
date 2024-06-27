// To parse this JSON data, do
//
//     final overrideReports = overrideReportsFromJson(jsonString);

import 'dart:convert';

OverrideReports overrideReportsFromJson(String str) => OverrideReports.fromJson(json.decode(str));

String overrideReportsToJson(OverrideReports data) => json.encode(data.toJson());

class OverrideReports {
  dynamic totalPaidPreviousMonth;
  dynamic totalUnpaidPreviousMonth;
  dynamic totalPaidAnnual;
  dynamic totalUnpaidAnnual;

  OverrideReports({
    this.totalPaidPreviousMonth,
    this.totalUnpaidPreviousMonth,
    this.totalPaidAnnual,
    this.totalUnpaidAnnual,
  });

  factory OverrideReports.fromJson(Map<String, dynamic> json) => OverrideReports(
    totalPaidPreviousMonth: json["total_paid_previous_month"],
    totalUnpaidPreviousMonth: json["total_unpaid_previous_month"],
    totalPaidAnnual: json["total_paid_annual"],
    totalUnpaidAnnual: json["total_unpaid_annual"],
  );

  Map<String, dynamic> toJson() => {
    "total_paid_previous_month": totalPaidPreviousMonth,
    "total_unpaid_previous_month": totalUnpaidPreviousMonth,
    "total_paid_annual": totalPaidAnnual,
    "total_unpaid_annual": totalUnpaidAnnual,
  };
}
