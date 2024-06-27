// To parse this JSON data, do
//
//     final rewardOrderModel = rewardOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:wizzsales/adminPage/adminModel/rewardOrderModel/orderLine.dart';

RewardOrderModel rewardOrderModelFromJson(String str) => RewardOrderModel.fromJson(json.decode(str));

String rewardOrderModelToJson(RewardOrderModel data) => json.encode(data.toJson());

class RewardOrderModel {
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  int? totalRecords;
  dynamic nextPage;
  dynamic previousPage;
  String? firstPage;
  String? lastPage;
  List<RewardData?>? data;

  RewardOrderModel({
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.totalRecords,
    this.nextPage,
    this.previousPage,
    this.firstPage,
    this.lastPage,
    this.data,
  });

  factory RewardOrderModel.fromJson(Map<String, dynamic> json) => RewardOrderModel(
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    totalPages: json["totalPages"],
    totalRecords: json["totalRecords"],
    nextPage: json["nextPage"],
    previousPage: json["previousPage"],
    firstPage: json["firstPage"],
    lastPage: json["lastPage"],
    data: List<RewardData>.from(json["data"].map((x) => RewardData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "totalPages": totalPages,
    "totalRecords": totalRecords,
    "nextPage": nextPage,
    "previousPage": previousPage,
    "firstPage": firstPage,
    "lastPage": lastPage,
    "data": List<dynamic>.from(data!.map((x) => x!.toJson())),
  };
}

class RewardData {
  int? id;
  int? customerId;
  String? transactionCode;
  String? customerRewardOrderCode;
  int? orderPointSubtotal;
  int? orderCurrencySubtotal;
  DateTime? orderDate;
  bool? isApproved;
  bool? isUsedCodeByCustomer;
  dynamic usedCodeByCustomerDate;
  dynamic whoApproved;
  dynamic approvedDate;
  dynamic whyNotApproved;
  bool? isCanceled;
  dynamic canceledDate;
  Customer? customer;
  List<RewardOrderLine?>? rewardOrderLines;

  RewardData({
    this.id,
    this.customerId,
    this.transactionCode,
    this.customerRewardOrderCode,
    this.orderPointSubtotal,
    this.orderCurrencySubtotal,
    this.orderDate,
    this.isApproved,
    this.isUsedCodeByCustomer,
    this.usedCodeByCustomerDate,
    this.whoApproved,
    this.approvedDate,
    this.whyNotApproved,
    this.isCanceled,
    this.canceledDate,
    this.customer,
    this.rewardOrderLines,
  });

  factory RewardData.fromJson(Map<String, dynamic> json) => RewardData(
    id: json["id"],
    customerId: json["customerId"],
    transactionCode: json["transactionCode"],
    customerRewardOrderCode: json["customerRewardOrderCode"],
    orderPointSubtotal: json["orderPointSubtotal"],
    orderCurrencySubtotal: json["orderCurrencySubtotal"],
    orderDate: DateTime.parse(json["orderDate"]),
    isApproved: json["isApproved"],
    isUsedCodeByCustomer: json["isUsedCodeByCustomer"],
    usedCodeByCustomerDate: json["usedCodeByCustomerDate"],
    whoApproved: json["whoApproved"],
    approvedDate: json["approvedDate"],
    whyNotApproved: json["whyNotApproved"],
    isCanceled: json["isCanceled"],
    canceledDate: json["canceledDate"],
    customer: Customer.fromJson(json["customer"]),
    rewardOrderLines: List<RewardOrderLine>.from(json["rewardOrderLines"].map((x) => RewardOrderLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customerId": customerId,
    "transactionCode": transactionCode,
    "customerRewardOrderCode": customerRewardOrderCode,
    "orderPointSubtotal": orderPointSubtotal,
    "orderCurrencySubtotal": orderCurrencySubtotal,
    "orderDate": orderDate!.toIso8601String(),
    "isApproved": isApproved,
    "isUsedCodeByCustomer": isUsedCodeByCustomer,
    "usedCodeByCustomerDate": usedCodeByCustomerDate,
    "whoApproved": whoApproved,
    "approvedDate": approvedDate,
    "whyNotApproved": whyNotApproved,
    "isCanceled": isCanceled,
    "canceledDate": canceledDate,
    "customer": customer!.toJson(),
    "rewardOrderLines": List<dynamic>.from(rewardOrderLines!.map((x) => x!.toJson())),
  };
}

class Customer {
  int? id;
  String? uuid;
  String? firstName;
  dynamic middleName;
  String? lastName;
  String? loginEmail;
  String? loginPhone;
  String? dateOfBirth;
  String? avatar;
  bool? isActive;
  dynamic spouseFirstName;
  dynamic spouseLastName;
  dynamic spouseEmail;
  String? spousePhone;
  dynamic organisationName;
  dynamic productSerialNumbers;
  String? createdAt;
  dynamic instagram;
  dynamic twitter;
  dynamic tiktok;
  dynamic facebook;
  Organisation? organisation;

  Customer({
    this.id,
    this.uuid,
    this.firstName,
    this.middleName,
    this.lastName,
    this.loginEmail,
    this.loginPhone,
    this.dateOfBirth,
    this.avatar,
    this.isActive,
    this.spouseFirstName,
    this.spouseLastName,
    this.spouseEmail,
    this.spousePhone,
    this.organisationName,
    this.productSerialNumbers,
    this.createdAt,
    this.instagram,
    this.twitter,
    this.tiktok,
    this.facebook,
    this.organisation,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    uuid: json["uuid"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    loginEmail: json["loginEmail"],
    loginPhone: json["loginPhone"],
    dateOfBirth: json["dateOfBirth"],
    avatar: json["avatar"],
    isActive: json["isActive"],
    spouseFirstName: json["spouseFirstName"],
    spouseLastName: json["spouseLastName"],
    spouseEmail: json["spouseEmail"],
    spousePhone: json["spousePhone"],
    organisationName: json["organisationName"],
    productSerialNumbers: json["productSerialNumbers"],
    createdAt: json["createdAt"],
    instagram: json["instagram"],
    twitter: json["twitter"],
    tiktok: json["tiktok"],
    facebook: json["facebook"],
    organisation: Organisation.fromJson(json["organisation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "loginEmail": loginEmail,
    "loginPhone": loginPhone,
    "dateOfBirth": dateOfBirth,
    "avatar": avatar,
    "isActive": isActive,
    "spouseFirstName": spouseFirstName,
    "spouseLastName": spouseLastName,
    "spouseEmail": spouseEmail,
    "spousePhone": spousePhone,
    "organisationName": organisationName,
    "productSerialNumbers": productSerialNumbers,
    "createdAt": createdAt,
    "instagram": instagram,
    "twitter": twitter,
    "tiktok": tiktok,
    "facebook": facebook,
    "organisation": organisation!.toJson(),
  };
}

class Organisation {
  int? id;
  dynamic name;
  dynamic organisationCode;
  dynamic organisationPerfix;
  dynamic organisationInformation;

  Organisation({
    this.id,
    this.name,
    this.organisationCode,
    this.organisationPerfix,
    this.organisationInformation,
  });

  factory Organisation.fromJson(Map<String, dynamic> json) => Organisation(
    id: json["id"],
    name: json["name"],
    organisationCode: json["organisationCode"],
    organisationPerfix: json["organisationPerfix"],
    organisationInformation: json["organisationInformation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "organisationCode": organisationCode,
    "organisationPerfix": organisationPerfix,
    "organisationInformation": organisationInformation,
  };
}



class Reward {
  int? id;
  String? title;
  String? description;
  String? imagePath;
  dynamic inStockCount;
  dynamic onOrderCount;
  dynamic costToUserAsPoint;
  dynamic costToSystemAsPoint;
  dynamic costToUserAsCurrency;
  dynamic costToSystemAsCurrency;
  String? costCurrencyType;

  Reward({
    this.id,
    this.title,
    this.description,
    this.imagePath,
    this.inStockCount,
    this.onOrderCount,
    this.costToUserAsPoint,
    this.costToSystemAsPoint,
    this.costToUserAsCurrency,
    this.costToSystemAsCurrency,
    this.costCurrencyType,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imagePath: json["imagePath"],
    inStockCount: json["inStockCount"],
    onOrderCount: json["onOrderCount"],
    costToUserAsPoint: json["costToUserAsPoint"],
    costToSystemAsPoint: json["costToSystemAsPoint"],
    costToUserAsCurrency: json["costToUserAsCurrency"],
    costToSystemAsCurrency: json["costToSystemAsCurrency"],
    costCurrencyType: json["costCurrencyType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "imagePath": imagePath,
    "inStockCount": inStockCount,
    "onOrderCount": onOrderCount,
    "costToUserAsPoint": costToUserAsPoint,
    "costToSystemAsPoint": costToSystemAsPoint,
    "costToUserAsCurrency": costToUserAsCurrency,
    "costToSystemAsCurrency": costToSystemAsCurrency,
    "costCurrencyType": costCurrencyType,
  };
}
