
// ignore_for_file: file_names

import 'dart:convert';

CareerSales careerSalesFromJson(String str) => CareerSales.fromJson(json.decode(str));

String careerSalesToJson(CareerSales data) => json.encode(data.toJson());

class CareerSales {
  CareerSales({
    this.approvedsalessofar,
  });

  int? approvedsalessofar;

  factory CareerSales.fromJson(Map<String, dynamic> json) => CareerSales(
    approvedsalessofar: json["approvedsalessofar"],
  );

  Map<String, dynamic> toJson() => {
    "approvedsalessofar": approvedsalessofar,
  };
}
