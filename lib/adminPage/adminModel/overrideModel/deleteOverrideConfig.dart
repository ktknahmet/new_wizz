// To parse this JSON data, do
//
//     final overrideType = overrideTypeFromJson(jsonString);

import 'dart:convert';

List<DeleteOverrideConfig> deleteOverrideConfigFromJson(String str) => List<DeleteOverrideConfig>.from(json.decode(str).map((x) => DeleteOverrideConfig.fromJson(x)));

String deleteOverrideConfigToJson(List<DeleteOverrideConfig> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeleteOverrideConfig {
  int? configId;

  DeleteOverrideConfig({
    this.configId,
  });

  factory DeleteOverrideConfig.fromJson(Map<String, dynamic> json) => DeleteOverrideConfig(
    configId: json["override_configuration_id"],
  );

  Map<String, dynamic> toJson() => {
    "override_configuration_id": configId,
  };
}
