// To parse this JSON data, do
//
//     final leadStatusList = leadStatusListFromJson(jsonString);

import 'dart:convert';

List<LeadStatusList> leadStatusListFromJson(String str) => List<LeadStatusList>.from(json.decode(str).map((x) => LeadStatusList.fromJson(x)));

String leadStatusListToJson(List<LeadStatusList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeadStatusList {
  int? id;
  String? name;

  LeadStatusList({
    this.id,
    this.name,
  });

  factory LeadStatusList.fromJson(Map<String, dynamic> json) => LeadStatusList(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
