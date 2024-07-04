// To parse this JSON data, do
//
//     final overrideType = overrideTypeFromJson(jsonString);

import 'dart:convert';

List<UpdateOverrideConfig> updateOverrideConfigFromJson(String str) => List<UpdateOverrideConfig>.from(json.decode(str).map((x) => UpdateOverrideConfig.fromJson(x)));

String updateOverrideConfigToJson(List<UpdateOverrideConfig> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateOverrideConfig {
  int? configId;
  String? overrideAmount;

  UpdateOverrideConfig({
    this.configId,
    this.overrideAmount
  });

  factory UpdateOverrideConfig.fromJson(Map<String, dynamic> json) => UpdateOverrideConfig(
    configId: json["override_configuration_id"],
    overrideAmount: json["override_amount"],
  );

  Map<String, dynamic> toJson() => {
    "override_configuration_id": configId,
    "override_amount": overrideAmount,
  };
}
