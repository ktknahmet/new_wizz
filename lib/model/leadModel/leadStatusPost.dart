// To parse this JSON data, do
//
//     final leadStatusPost = leadStatusPostFromJson(jsonString);

import 'dart:convert';

LeadStatusPost leadStatusPostFromJson(String str) => LeadStatusPost.fromJson(json.decode(str));

String leadStatusPostToJson(LeadStatusPost data) => json.encode(data.toJson());

class LeadStatusPost {
  int? leadId;
  int? leadStatusId;

  LeadStatusPost({
    this.leadId,
    this.leadStatusId,
  });

  factory LeadStatusPost.fromJson(Map<String, dynamic> json) => LeadStatusPost(
    leadId: json["lead_id"],
    leadStatusId: json["lead_status_id"],
  );

  Map<String, dynamic> toJson() => {
    "lead_id": leadId,
    "lead_status_id": leadStatusId,
  };
}
