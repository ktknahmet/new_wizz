// To parse this JSON data, do
//
//     final commisionList = commisionListFromJson(jsonString);

import 'dart:convert';

List<CommisionList> commisionListFromJson(String str) => List<CommisionList>.from(json.decode(str).map((x) => CommisionList.fromJson(x)));

String commisionListToJson(List<CommisionList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommisionList {
  int? calcPoolId;
  int? orgId;
  int? roleId;
  int? profileId;
  dynamic calcBeginDate;
  dynamic calcExpireDate;
  dynamic createdAt;
  dynamic updatedAt;
  bool? isActive;
  String? roleName;
  String? roleViewName;
  dynamic dealerName;
  List<Detail>? details;

  CommisionList({
    this.calcPoolId,
    this.orgId,
    this.roleId,
    this.profileId,
    this.calcBeginDate,
    this.calcExpireDate,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.roleName,
    this.roleViewName,
    this.dealerName,
    this.details,
  });

  factory CommisionList.fromJson(Map<String, dynamic> json) => CommisionList(
    calcPoolId: json["calc_pool_id"],
    orgId: json["org_id"],
    roleId: json["role_id"],
    profileId: json["profile_id"],
    calcBeginDate: json["calc_begin_date"],
    calcExpireDate: json["calc_expire_date"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    isActive: json["is_active"],
    roleName: json["role_name"],
    roleViewName: json["role_view_name"],
    dealerName: json["dealer_name"],
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "calc_pool_id": calcPoolId,
    "org_id": orgId,
    "role_id": roleId,
    "profile_id": profileId,
    "calc_begin_date": calcBeginDate,
    "calc_expire_date": calcExpireDate,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "is_active":isActive,
    "role_name": roleName,
    "role_view_name": roleViewName,
    "dealer_name": dealerName,
    "details": List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  int? calcPoolDetId;
  int? calcPoolId;
  String? amountLevel1;
  String? amountLevel2;
  String? commAmount;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic comPercentage;
  String? comType;

  Detail({
    this.calcPoolDetId,
    this.calcPoolId,
    this.amountLevel1,
    this.amountLevel2,
    this.commAmount,
    this.createdAt,
    this.updatedAt,
    this.comPercentage,
    this.comType
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    calcPoolDetId: json["calc_pool_det_id"],
    calcPoolId: json["calc_pool_id"],
    amountLevel1: json["amount_level1"],
    amountLevel2: json["amount_level2"],
    commAmount: json["comm_amount"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    comPercentage: json["comm_percentage"],
    comType: json["comm_type"],
  );

  Map<String, dynamic> toJson() => {
    "calc_pool_det_id": calcPoolDetId,
    "calc_pool_id": calcPoolId,
    "amount_level1": amountLevel1,
    "amount_level2": amountLevel2,
    "comm_amount": commAmount,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "comm_percentage": comPercentage,
    "comm_type": comType,
  };
}
