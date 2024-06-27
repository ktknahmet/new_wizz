// To parse this JSON data, do
//
//     final allRoles = allRolesFromJson(jsonString);

import 'dart:convert';

List<AllRoles> allRolesFromJson(String str) => List<AllRoles>.from(json.decode(str).map((x) => AllRoles.fromJson(x)));

String allRolesToJson(List<AllRoles> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllRoles {
  int? id;
  String? name;
  String? guardName;
  dynamic createdAt;
  dynamic updatedAt;
  String? viewName;

  AllRoles({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.viewName,
  });

  factory AllRoles.fromJson(Map<String, dynamic> json) => AllRoles(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    viewName: json["view_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "view_name": viewName,
  };
}

enum GuardName {
  API
}

final guardNameValues = EnumValues({
  "api": GuardName.API
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
