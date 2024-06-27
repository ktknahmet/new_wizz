// To parse this JSON data, do
//
//     final dealerOverrideWinner = dealerOverrideWinnerFromJson(jsonString);

import 'dart:convert';

List<DealerOverrideWinner> dealerOverrideWinnerFromJson(String str) => List<DealerOverrideWinner>.from(json.decode(str).map((x) => DealerOverrideWinner.fromJson(x)));

String dealerOverrideWinnerToJson(List<DealerOverrideWinner> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DealerOverrideWinner {
  int? overrideCalcDetailId;
  String? overrideAmount;
  String? organisationName;
  String? overrideType;
  String? userName;
  String? productName;
  dynamic calculatedDate;
  String? serialNumber;

  DealerOverrideWinner({
    this.overrideCalcDetailId,
    this.overrideAmount,
    this.organisationName,
    this.overrideType,
    this.userName,
    this.productName,
    this.calculatedDate,
    this.serialNumber,
  });

  factory DealerOverrideWinner.fromJson(Map<String, dynamic> json) => DealerOverrideWinner(
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

