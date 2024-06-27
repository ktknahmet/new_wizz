// To parse this JSON data, do
//
//     final expenseSale = expenseSaleFromJson(jsonString);

import 'dart:convert';

List<ExpenseSale> expenseSaleFromJson(String str) => List<ExpenseSale>.from(json.decode(str).map((x) => ExpenseSale.fromJson(x)));

String expenseSaleToJson(List<ExpenseSale> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseSale {
  int? id;
  String? serialid;
  dynamic date;
  String? cname;

  ExpenseSale({
    this.id,
    this.serialid,
    this.date,
    this.cname,
  });

  factory ExpenseSale.fromJson(Map<String, dynamic> json) => ExpenseSale(
    id: json["id"],
    serialid: json["serialid"],
    date: DateTime.parse(json["date"]),
    cname: json["cname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serialid": serialid,
    "date": date,
    "cname": cname,
  };
}
