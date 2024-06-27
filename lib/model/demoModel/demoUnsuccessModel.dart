// To parse this JSON data, do
//
//     final demoUnsuccessModel = demoUnsuccessModelFromJson(jsonString);

import 'dart:convert';

List<DemoUnsuccessModel> demoUnsuccessModelFromJson(String str) => List<DemoUnsuccessModel>.from(json.decode(str).map((x) => DemoUnsuccessModel.fromJson(x)));

String demoUnsuccessModelToJson(List<DemoUnsuccessModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DemoUnsuccessModel {
  int? demoId;
  int? userId;
  int? reasonTypeId;

  DemoUnsuccessModel({
    this.demoId,
    this.userId,
    this.reasonTypeId,
  });

  factory DemoUnsuccessModel.fromJson(Map<String, dynamic> json) => DemoUnsuccessModel(
    demoId: json["demo_id"],
    userId: json["user_id"],
    reasonTypeId: json["reason_type_id"],
  );

  Map<String, dynamic> toJson() => {
    "demo_id": demoId,
    "user_id": userId,
    "reason_type_id": reasonTypeId,
  };
}
