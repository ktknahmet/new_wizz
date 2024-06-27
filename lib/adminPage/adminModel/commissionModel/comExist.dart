// To parse this JSON data, do
//
//     final comExist = comExistFromJson(jsonString);

import 'dart:convert';

ComExist comExistFromJson(String str) => ComExist.fromJson(json.decode(str));

String comExistToJson(ComExist data) => json.encode(data.toJson());

class ComExist {
  int? profileId;
  int? roleId;

  ComExist({
    this.profileId,
    this.roleId,
  });

  factory ComExist.fromJson(Map<String, dynamic> json) => ComExist(
    profileId: json["profile_id"],
    roleId: json["role_id"],
  );

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "role_id": roleId,
  };
}
