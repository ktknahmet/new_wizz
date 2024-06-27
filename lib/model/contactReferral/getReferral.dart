// To parse this JSON data, do
//
//     final getReferral = getReferralFromJson(jsonString);

import 'dart:convert';

List<GetReferral> getReferralFromJson(String str) => List<GetReferral>.from(json.decode(str).map((x) => GetReferral.fromJson(x)));

String getReferralToJson(List<GetReferral> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetReferral {
  int? employeeReferralId;
  int? employeeId;
  String? referralFirstName;
  dynamic referralLastName;
  String? referralPhone;
  String? referralEmail;
  int? relotionId;
  String? referalSourceType;
  bool? isAccept;
  int? organisationId;
  String? applicationSource;
  String? companyCode;
  int? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  dynamic updatedAt;

  GetReferral({
    this.employeeReferralId,
    this.employeeId,
    this.referralFirstName,
    this.referralLastName,
    this.referralPhone,
    this.referralEmail,
    this.relotionId,
    this.referalSourceType,
    this.isAccept,
    this.organisationId,
    this.applicationSource,
    this.companyCode,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory GetReferral.fromJson(Map<String, dynamic> json) => GetReferral(
    employeeReferralId: json["employee_referral_id"],
    employeeId: json["employee_id"],
    referralFirstName: json["referral_first_name"],
    referralLastName: json["referral_last_name"],
    referralPhone: json["referral_phone"],
    referralEmail: json["referral_email"],
    relotionId: json["relotion_id"],
    referalSourceType: json["referal_source_type"],
    isAccept: json["is_accept"],
    organisationId: json["organisation_id"],
    applicationSource: json["application_source"],
    companyCode: json["company_code"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "employee_referral_id": employeeReferralId,
    "employee_id": employeeId,
    "referral_first_name": referralFirstName,
    "referral_last_name": referralLastName,
    "referral_phone": referralPhone,
    "referral_email": referralEmail,
    "relotion_id": relotionId,
    "referal_source_type": referalSourceType,
    "is_accept": isAccept,
    "organisation_id": organisationId,
    "application_source": applicationSource,
    "company_code": companyCode,
    "created_by": createdBy,
    "created_at": createdAt!.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt,
  };
}