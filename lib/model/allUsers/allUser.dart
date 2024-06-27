// To parse this JSON data, do
//
//     final allUsers = allUsersFromJson(jsonString);

import 'dart:convert';

List<AllUsers> allUsersFromJson(String str) => List<AllUsers>.from(json.decode(str).map((x) => AllUsers.fromJson(x)));

String allUsersToJson(List<AllUsers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllUsers {
  int? id;
  String? name;
  String? menuRoles;

  AllUsers({
    this.id,
    this.name,
    this.menuRoles
  });

  factory AllUsers.fromJson(Map<String, dynamic> json) => AllUsers(
    id: json["id"],
    name: json["name"],
    menuRoles: json["menuroles"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "menuroles":menuRoles
  };
}
