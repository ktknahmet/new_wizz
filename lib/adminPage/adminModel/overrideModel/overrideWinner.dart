// To parse this JSON data, do
//
//     final overrideWinner = overrideWinnerFromJson(jsonString);

import 'dart:convert';

List<AdminOverrideWinner> overrideWinnerFromJson(String str) => List<AdminOverrideWinner>.from(json.decode(str).map((x) => AdminOverrideWinner.fromJson(x)));

String overrideWinnerToJson(List<AdminOverrideWinner> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminOverrideWinner {
  int? overrideCalcDetailId;
  String? overrideAmount;
  String? organisationName;
  String? overrideType;
  String? userName;
  String? productName;
  dynamic calculatedDate;
  String? serialNumber;

  AdminOverrideWinner({
    this.overrideCalcDetailId,
    this.overrideAmount,
    this.organisationName,
    this.overrideType,
    this.userName,
    this.productName,
    this.calculatedDate,
    this.serialNumber,
  });

  factory AdminOverrideWinner.fromJson(Map<String, dynamic> json) => AdminOverrideWinner(
    overrideCalcDetailId: json["override_calc_detail_id"],
    overrideAmount: json["override_amount"],
    organisationName: json["organisation_name"],
    overrideType: json["override_type"],
    userName: json["user_name"],
    productName: json["product_name"],
    calculatedDate: json["calculated_date"],
    serialNumber: json["serial_number"],
  );

  Map<String, dynamic> toJson() => {
    "override_calc_detail_id": overrideCalcDetailId,
    "override_amount": overrideAmount,
    "organisation_name": organisationName,
    "override_type": overrideType,
    "user_name": userName,
    "product_name": productName,
    "calculated_date": calculatedDate,
    "serial_number": serialNumber,
  };
}
