// To parse this JSON data, do
//
//     final distributorContract = distributorContractFromJson(jsonString);

import 'dart:convert';

List<DistributorContract> distributorContractFromJson(String str) => List<DistributorContract>.from(json.decode(str).map((x) => DistributorContract.fromJson(x)));

String distributorContractToJson(List<DistributorContract> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistributorContract {
  String? contractPath;
  int? distributorId;
  int? contractId;
  DateTime? createdAt;
  String? distributorName;
  String? contractName;

  DistributorContract({
    this.contractPath,
    this.distributorId,
    this.contractId,
    this.createdAt,
    this.distributorName,
    this.contractName,
  });

  factory DistributorContract.fromJson(Map<String, dynamic> json) => DistributorContract(
    contractPath: json["contractPath"],
    distributorId: json["distributorId"],
    contractId: json["contractId"],
    createdAt: DateTime.parse(json["createdAt"]),
    distributorName: json["distributorName"],
    contractName: json["contractName"],
  );

  Map<String, dynamic> toJson() => {
    "contractPath": contractPath,
    "distributorId": distributorId,
    "contractId": contractId,
    "createdAt": createdAt!.toIso8601String(),
    "distributorName": distributorName,
    "contractName": contractName,
  };
}
