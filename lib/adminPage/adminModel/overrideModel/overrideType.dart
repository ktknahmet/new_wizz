// To parse this JSON data, do
//
//     final overrideType = overrideTypeFromJson(jsonString);

import 'dart:convert';

List<OverrideType> overrideTypeFromJson(String str) => List<OverrideType>.from(json.decode(str).map((x) => OverrideType.fromJson(x)));

String overrideTypeToJson(List<OverrideType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OverrideType {
  int? overrideTypeId;
  String? overrideTypeName;

  OverrideType({
    this.overrideTypeId,
    this.overrideTypeName,
  });

  factory OverrideType.fromJson(Map<String, dynamic> json) => OverrideType(
    overrideTypeId: json["override_type_id"],
    overrideTypeName: json["override_type_name"],
  );

  Map<String, dynamic> toJson() => {
    "override_type_id": overrideTypeId,
    "override_type_name": overrideTypeName,
  };
}
