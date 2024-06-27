// To parse this JSON data, do
//
//     final overrideWinner = overrideWinnerFromJson(jsonString);

import 'dart:convert';

PostOverride overrideWinnerFromJson(String str) => PostOverride.fromJson(json.decode(str));

String overrideWinnerToJson(PostOverride data) => json.encode(data.toJson());

class PostOverride {
  int? organisationId;
  int? userId;
  int? productId;
  List<OverrideTypes>? overrideTypes;

  PostOverride({
    this.organisationId,
    this.userId,
    this.productId,
    this.overrideTypes,
  });

  factory PostOverride.fromJson(Map<String, dynamic> json) => PostOverride(
    organisationId: json["organisation_id"],
    userId: json["user_id"],
    productId: json["product_id"],
    overrideTypes: List<OverrideTypes>.from(json["override_types"].map((x) => OverrideTypes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "organisation_id": organisationId,
    "user_id": userId,
    "product_id": productId,
    "override_types": List<dynamic>.from(overrideTypes!.map((x) => x.toJson())),
  };
}

class OverrideTypes {
  String? distName;
  String? overrideTypeName;
  String? userName;
  int? overrideTypeId;
  dynamic overrideAmount;

  OverrideTypes({
    this.distName,
    this.overrideTypeName,
    this.userName,
    this.overrideTypeId,
    this.overrideAmount,
  });

  factory OverrideTypes.fromJson(Map<String, dynamic> json) => OverrideTypes(
    overrideTypeId: json["override_type_id"],
    overrideAmount: json["override_amount"],
  );

  Map<String, dynamic> toJson() => {
    "override_type_id": overrideTypeId,
    "override_amount": overrideAmount,
  };
}
