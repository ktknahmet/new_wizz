// To parse this JSON data, do
//
//     final expenseType = expenseTypeFromJson(jsonString);

import 'dart:convert';

List<ExpenseType> expenseTypeFromJson(String str) => List<ExpenseType>.from(json.decode(str).map((x) => ExpenseType.fromJson(x)));

String expenseTypeToJson(List<ExpenseType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseType {
  int? expenseTypeId;
  String? expenseName;
  DateTime? createdAt;
  dynamic updatedAt;

  ExpenseType({
    this.expenseTypeId,
    this.expenseName,
    this.createdAt,
    this.updatedAt,
  });

  factory ExpenseType.fromJson(Map<String, dynamic> json) => ExpenseType(
    expenseTypeId: json["expense_type_id"],
    expenseName: json["expense_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "expense_type_id": expenseTypeId,
    "expense_name": expenseName,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt,
  };
}