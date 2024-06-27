// To parse this JSON data, do
//
//     final allExpenseModel = allExpenseModelFromJson(jsonString);

import 'dart:convert';

List<AllExpenseModel> allExpenseModelFromJson(String str) => List<AllExpenseModel>.from(json.decode(str).map((x) => AllExpenseModel.fromJson(x)));

String allExpenseModelToJson(List<AllExpenseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllExpenseModel {
  int? expenseDetailId;
  String? expenseName;
  int? userId;
  int? saleId;
  int? organisationId;
  String? expenseNetPrice;
  String? expenseTaxPrice;
  dynamic expenseDate;
  dynamic createdAt;
  dynamic updatedAt;
  String? documentPath;
  dynamic startMil;
  dynamic endMil;
  String? customerName;
  dynamic saleDate;
  String? salePrice;
  String? saleTax;
  String? userName;
  String? organisationName;

  AllExpenseModel({
    this.expenseDetailId,
    this.expenseName,
    this.userId,
    this.saleId,
    this.organisationId,
    this.expenseNetPrice,
    this.expenseTaxPrice,
    this.expenseDate,
    this.createdAt,
    this.updatedAt,
    this.documentPath,
    this.startMil,
    this.endMil,
    this.customerName,
    this.saleDate,
    this.salePrice,
    this.saleTax,
    this.userName,
    this.organisationName,
  });

  factory AllExpenseModel.fromJson(Map<String, dynamic> json) => AllExpenseModel(
    expenseDetailId: json["expense_detail_id"],
    expenseName: json["expense_name"],
    userId: json["user_id"],
    saleId: json["sale_id"],
    organisationId: json["organisation_id"],
    expenseNetPrice: json["expense_net_price"],
    expenseTaxPrice: json["expense_tax_price"],
    expenseDate: json["expense_date"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    documentPath: json["document_path"],
    startMil: json["start_mil"],
    endMil: json["end_mil"],
    customerName: json["customer_name"],
    saleDate: json["sale_date"],
    salePrice: json["sale_price"],
    saleTax: json["sale_tax"],
    userName: json["user_name"],
    organisationName: json["organisation_name"],
  );

  Map<String, dynamic> toJson() => {
    "expense_detail_id": expenseDetailId,
    "expense_name": expenseName,
    "user_id": userId,
    "sale_id": saleId,
    "organisation_id": organisationId,
    "expense_net_price": expenseNetPrice,
    "expense_tax_price": expenseTaxPrice,
    "expense_date": expenseDate,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "document_path": documentPath,
    "start_mil": startMil,
    "end_mil": endMil,
    "customer_name": customerName,
    "sale_date": saleDate,
    "sale_price": salePrice,
    "sale_tax": saleTax,
    "user_name": userName,
    "organisation_name": organisationName,
  };
}
