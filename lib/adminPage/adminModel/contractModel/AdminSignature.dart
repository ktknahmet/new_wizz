// To parse this JSON data, do
//
//     final adminSignature = adminSignatureFromJson(jsonString);

import 'dart:convert';

List<AdminSignature> adminSignatureFromJson(String str) => List<AdminSignature>.from(json.decode(str).map((x) => AdminSignature.fromJson(x)));

String adminSignatureToJson(List<AdminSignature> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminSignature {
  int? distributorEsignatureId;
  int? distributorId;
  String? documentPath;
  DateTime? createdAt;
  String? distributorName;
  bool? check;

  AdminSignature({
    this.distributorEsignatureId,
    this.distributorId,
    this.documentPath,
    this.createdAt,
    this.distributorName,
    this.check = false
  });

  factory AdminSignature.fromJson(Map<String, dynamic> json) => AdminSignature(
    distributorEsignatureId: json["distributorEsignatureId"],
    distributorId: json["distributorId"],
    documentPath: json["documentPath"],
    createdAt: DateTime.parse(json["createdAt"]),
    distributorName: json["distributorName"],
  );

  Map<String, dynamic> toJson() => {
    "distributorEsignatureId": distributorEsignatureId,
    "distributorId": distributorId,
    "documentPath": documentPath,
    "createdAt": createdAt!.toIso8601String(),
    "distributorName": distributorName,
  };
}
