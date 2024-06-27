// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  bool? isSuccess;
  String? message;
  List<String>? validations;

  ResponseModel({
    this.isSuccess,
    this.message,
    this.validations,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    isSuccess: json["isSuccess"],
    message: json["message"],
    validations: List<String>.from(json["validations"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "validations": List<dynamic>.from(validations!.map((x) => x)),
  };
}
