// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

ResetModel loginFromJson(String str) => ResetModel.fromJson(json.decode(str));

String loginToJson(ResetModel data) => json.encode(data.toJson());

class ResetModel {
  String? email;

  ResetModel({
    this.email
  });

  factory ResetModel.fromJson(Map<String, dynamic> json) => ResetModel(
    email: json["email"]
  );

  Map<String, dynamic> toJson() => {
    "email": email
  };
}
