// To parse this JSON data, do
//
//     final distributorContract = distributorContractFromJson(jsonString);

import 'dart:convert';

List<ContractType> contractTypeFromJson(String str) => List<ContractType>.from(json.decode(str).map((x) => ContractType.fromJson(x)));

String contractTypeToJson(List<ContractType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContractType {
  int? contractId;
  String? contractName;

  ContractType({
    this.contractId,
    this.contractName,
  });

  factory ContractType.fromJson(Map<String, dynamic> json) => ContractType(
    contractId: json["contractId"],
    contractName: json["contractName"],
  );

  Map<String, dynamic> toJson() => {
    "contractId": contractId,
    "contractName": contractName,
  };
}
