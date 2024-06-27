// To parse this JSON data, do
//
//     final saleDeduction = saleDeductionFromJson(jsonString);

import 'dart:convert';

SaleDeduction saleDeductionFromJson(String str) => SaleDeduction.fromJson(json.decode(str));

String saleDeductionToJson(SaleDeduction data) => json.encode(data.toJson());

class SaleDeduction {
  int? saleId;
  dynamic reserve;
  dynamic fee1;
  dynamic fee2;
  dynamic otherDeductions;
  String? financeBy;
  dynamic financePercentage;

  SaleDeduction({
    this.saleId,
    this.reserve,
    this.fee1,
    this.fee2,
    this.otherDeductions,
    this.financeBy,
    this.financePercentage
  });

  factory SaleDeduction.fromJson(Map<String, dynamic> json) => SaleDeduction(
    saleId: json["sale_id"],
    reserve: json["reserve"],
    fee1: json["fee1"],
    fee2: json["fee2"],
    otherDeductions: json["other_deductions"],
    financeBy: json["financeby"],
    financePercentage: json["financepercentage"],
  );

  Map<String, dynamic> toJson() => {
    "sale_id": saleId,
    "reserve": reserve,
    "fee1": fee1,
    "fee2": fee2,
    "other_deductions": otherDeductions,
    "financeby": financeBy,
    "financepercentage": financePercentage,
  };
}
