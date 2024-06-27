// To parse this JSON data, do
//
//     final allOverride = allOverrideFromJson(jsonString);

import 'dart:convert';

List<AllOverride> allOverrideFromJson(String str) => List<AllOverride>.from(json.decode(str).map((x) => AllOverride.fromJson(x)));

String allOverrideToJson(List<AllOverride> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllOverride {
  int? overrideConfigurationId;
  String? overrideAmount;
  String? organisationName;
  String? overrideType;
  String? userName;
  String? productName;

  AllOverride({
    this.overrideConfigurationId,
    this.overrideAmount,
    this.organisationName,
    this.overrideType,
    this.userName,
    this.productName,
  });

  factory AllOverride.fromJson(Map<String, dynamic> json) => AllOverride(
    overrideConfigurationId: json["override_configuration_id"],
    overrideAmount: json["override_amount"],
    organisationName: json["organisation_name"],
    overrideType: json["override_type"],
    userName: json["user_name"],
    productName: json["product_name"],
  );

  Map<String, dynamic> toJson() => {
    "override_configuration_id": overrideConfigurationId,
    "override_amount": overrideAmount,
    "organisation_name": organisationName,
    "override_type": overrideType,
    "user_name": userName,
    "product_name": productName,
  };
}
