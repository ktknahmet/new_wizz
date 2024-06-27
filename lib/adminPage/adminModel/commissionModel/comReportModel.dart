// To parse this JSON data, do
//
//     final comReportModel = comReportModelFromJson(jsonString);

import 'dart:convert';

List<ComReportModel> comReportModelFromJson(String str) => List<ComReportModel>.from(json.decode(str).map((x) => ComReportModel.fromJson(x)));

String comReportModelToJson(List<ComReportModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComReportModel {
  String? userImage;
  String? commPercentage;
  String? commType;
  int? orgId;
  int? calcPoolSaleId;
  bool? isActivePool;
  int? calcPoolId;
  int? userId;
  String? userName;
  int? profileId;
  String? profileMenurole;
  String? salePrice;
  String? saleSerialNumber;
  String? eligibleRoleName;
  String? organisationName;
  String? minAmount;
  String? maxAmount;
  dynamic beginDate;
  dynamic expireDate;
  int? commPoolDetId;
  int? saleId;
  int? profilIdInComm;
  dynamic commCalculatedAt;
  String? commAmount;
  dynamic commAdjustAmount;
  bool? isCommPaid;
  dynamic payAt;
  bool? isCanceledSale;
  dynamic commCanceledAt;
  dynamic clowBackAmount;

  ComReportModel({
    this.userImage,
    this.commPercentage,
    this.commType,
    this.orgId,
    this.calcPoolSaleId,
    this.isActivePool,
    this.calcPoolId,
    this.userId,
    this.userName,
    this.profileId,
    this.profileMenurole,
    this.salePrice,
    this.saleSerialNumber,
    this.eligibleRoleName,
    this.organisationName,
    this.minAmount,
    this.maxAmount,
    this.beginDate,
    this.expireDate,
    this.commPoolDetId,
    this.saleId,
    this.profilIdInComm,
    this.commCalculatedAt,
    this.commAmount,
    this.commAdjustAmount,
    this.isCommPaid,
    this.payAt,
    this.isCanceledSale,
    this.commCanceledAt,
    this.clowBackAmount,
  });

  factory ComReportModel.fromJson(Map<String, dynamic> json) => ComReportModel(
    userImage: json["user_image"],
    commPercentage: json["comm_percentage"],
    commType: json["comm_type"],
    orgId: json["org_id"],
    calcPoolSaleId: json["calc_pool_sale_id"],
    isActivePool: json["is_active_pool"],
    calcPoolId: json["calc_pool_id"],
    userId: json["user_id"],
    userName: json["user_name"],
    profileId: json["profile_id"],
    profileMenurole: json["profile_menurole"],
    salePrice: json["sale_price"],
    saleSerialNumber: json["sale_serial_number"],
    eligibleRoleName: json["eligible_role_name"],
    organisationName: json["organisation_name"],
    minAmount: json["min_amount"],
    maxAmount: json["max_amount"],
    beginDate: json["begin_date"],
    expireDate: json["expire_date"],
    commPoolDetId: json["comm_pool_det_id"],
    saleId: json["sale_id"],
    profilIdInComm: json["profil_id_in_comm"],
    commCalculatedAt: json["comm_calculated_at"],
    commAmount: json["comm_amount"],
    commAdjustAmount: json["comm_adjust_amount"],
    isCommPaid: json["is_comm_paid"],
    payAt: json["pay_at"],
    isCanceledSale: json["is_canceled_sale"],
    commCanceledAt: json["comm_canceled_at"],
    clowBackAmount: json["clow_back_amount"],
  );

  Map<String, dynamic> toJson() => {
    "user_image": userImage,
    "comm_percentage": commPercentage,
    "comm_type": commType,
    "org_id": orgId,
    "calc_pool_sale_id": calcPoolSaleId,
    "is_active_pool": isActivePool,
    "calc_pool_id": calcPoolId,
    "user_id": userId,
    "user_name": userName,
    "profile_id": profileId,
    "profile_menurole": profileMenurole,
    "sale_price": salePrice,
    "sale_serial_number": saleSerialNumber,
    "eligible_role_name": eligibleRoleName,
    "organisation_name": organisationName,
    "min_amount": minAmount,
    "max_amount": maxAmount,
    "begin_date": beginDate,
    "expire_date": expireDate,
    "comm_pool_det_id": commPoolDetId,
    "sale_id": saleId,
    "profil_id_in_comm": profilIdInComm,
    "comm_calculated_at": commCalculatedAt,
    "comm_amount": commAmount,
    "comm_adjust_amount": commAdjustAmount,
    "is_comm_paid": isCommPaid,
    "pay_at": payAt,
    "is_canceled_sale": isCanceledSale,
    "comm_canceled_at": commCanceledAt,
    "clow_back_amount": clowBackAmount,
  };
}
