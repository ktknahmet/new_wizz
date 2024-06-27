// To parse this JSON data, do
//
//     final overrideUserPost = overrideUserPostFromJson(jsonString);

import 'dart:convert';

OverrideUserPost overrideUserPostFromJson(String str) => OverrideUserPost.fromJson(json.decode(str));

String overrideUserPostToJson(OverrideUserPost data) => json.encode(data.toJson());

class OverrideUserPost {
  int? userId;

  OverrideUserPost({
    this.userId,
  });

  factory OverrideUserPost.fromJson(Map<String, dynamic> json) => OverrideUserPost(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
