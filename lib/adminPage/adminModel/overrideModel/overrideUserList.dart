// To parse this JSON data, do
//
//     final overrideUserList = overrideUserListFromJson(jsonString);

import 'dart:convert';

OverrideUserList overrideUserListFromJson(String str) => OverrideUserList.fromJson(json.decode(str));

String overrideUserListToJson(OverrideUserList data) => json.encode(data.toJson());

class OverrideUserList {
  int? id;
  String? name;
  String? menuroles;


  OverrideUserList({
    this.id,
    this.name,
    this.menuroles,
  });

  factory OverrideUserList.fromJson(Map<String, dynamic> json) => OverrideUserList(
    id: json["id"],
    name: json["name"],
    menuroles: json["menuroles"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "menuroles": menuroles,
  };
}
