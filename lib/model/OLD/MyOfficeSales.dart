
// ignore_for_file: file_names

import 'dart:convert';
List<MyOfficeSales> myOfficeSalesFromJson(String str) => List<MyOfficeSales>.from(json.decode(str).map((x) => MyOfficeSales.fromJson(x)));

String myOfficeSalesToJson(List<MyOfficeSales> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyOfficeSales {

  int? yasales;
  int? ysales;
  int? wasales;
  int? wsales;
  int? masales;
  int? msales;
  int? dasales;
  int? dsales;

  MyOfficeSales({
    this.yasales,
    this.ysales,
    this.wasales,
    this.wsales,
    this.masales,
    this.msales,
    this.dasales,
    this.dsales,});

  factory MyOfficeSales.fromJson(Map<String, dynamic> json) => MyOfficeSales(
    yasales: json["yasales"],
    ysales: json["ysales"],
    wasales: json["wasales"],
    wsales: json["wsales"],
    masales: json["masales"],
    msales: json["msales"],
    dasales: json["dasales"],
    dsales: json["dsales"],
  );

  Map<String, dynamic> toJson() => {
    "yasales": yasales,
    "ysales": ysales,
    "wasales": wasales,
    "wsales": wsales,
    "masales": masales,
    "msales": msales,
    "dasales": dasales,
    "dsales": dsales,
  };

}