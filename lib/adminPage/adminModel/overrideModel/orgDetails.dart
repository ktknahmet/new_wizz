// To parse this JSON data, do
//
//     final orgDetails = orgDetailsFromJson(jsonString);

import 'dart:convert';

List<OrgDetails> orgDetailsFromJson(String str) => List<OrgDetails>.from(json.decode(str).map((x) => OrgDetails.fromJson(x)));

String orgDetailsToJson(List<OrgDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrgDetails {
  String? organisationName;
  String? userName;
  int? organisationId;

  OrgDetails({
    this.organisationName,
    this.userName,
    this.organisationId,
  });

  factory OrgDetails.fromJson(Map<String, dynamic> json) => OrgDetails(
    organisationName: json["organisation_name"],
    userName: json["user_name"],
    organisationId: json["organisation_id"],
  );

  Map<String, dynamic> toJson() => {
    "organisation_name": organisationName,
    "user_name": userName,
    "organisation_id": organisationId,
  };
}
