// To parse this JSON data, do
//
//     final adminContractList = adminContractListFromJson(jsonString);

import 'dart:convert';

List<AdminContractList> adminContractListFromJson(String str) => List<AdminContractList>.from(json.decode(str).map((x) => AdminContractList.fromJson(x)));

String adminContractListToJson(List<AdminContractList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminContractList {
  int? contractId;
  String? contractName;
  String? contractPath;
  int? distributorId;
  DateTime? createdAt;
  dynamic updatedAt;
  String? distributorName;
  bool? check; // = false varsayılan değeri kaldırıldı

  AdminContractList({
    this.contractId,
    this.contractName,
    this.contractPath,
    this.distributorId,
    this.createdAt,
    this.updatedAt,
    this.distributorName,
    this.check = false, // varsayılan değer eklendi
  });

  factory AdminContractList.fromJson(Map<String, dynamic> json) => AdminContractList(
    contractId: json["contractId"],
    contractName: json["contractName"],
    contractPath: json["contractPath"],
    distributorId: json["distributorId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"],
    distributorName: json["distributorName"],
  );

  Map<String, dynamic> toJson() => {
    "contractId": contractId,
    "contractName": contractName,
    "contractPath": contractPath,
    "distributorId": distributorId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt,
    "distributorName": distributorName,
  };
}
