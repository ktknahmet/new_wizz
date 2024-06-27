// To parse this JSON data, do
//
//     final overrideUserDelete = overrideUserDeleteFromJson(jsonString);

import 'dart:convert';

OverrideUserDelete overrideUserDeleteFromJson(String str) => OverrideUserDelete.fromJson(json.decode(str));

String overrideUserDeleteToJson(OverrideUserDelete data) => json.encode(data.toJson());

class OverrideUserDelete {
  int? userId;

  OverrideUserDelete({
    this.userId,
  });

  factory OverrideUserDelete.fromJson(Map<String, dynamic> json) => OverrideUserDelete(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
