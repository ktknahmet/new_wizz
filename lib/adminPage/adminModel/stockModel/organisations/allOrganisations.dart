// To parse this JSON data, do
//
//     final allOrganisations = allOrganisationsFromJson(jsonString);

import 'dart:convert';

List<AllOrganisations> allOrganisationsFromJson(String str) => List<AllOrganisations>.from(json.decode(str).map((x) => AllOrganisations.fromJson(x)));

String allOrganisationsToJson(List<AllOrganisations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllOrganisations {
  int? id;
  String? name;
  bool? check;

  AllOrganisations({
    this.id,
    this.name,
    this.check =false
  });

  factory AllOrganisations.fromJson(Map<String, dynamic> json) => AllOrganisations(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
