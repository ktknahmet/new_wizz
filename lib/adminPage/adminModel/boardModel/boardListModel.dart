// To parse this JSON data, do
//
//     final boardListModel = boardListModelFromJson(jsonString);

import 'dart:convert';

import 'package:wizzsales/adminPage/adminModel/boardModel/appointmentBoard.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/boardDemos.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/saleBoard.dart';

BoardListModel boardListModelFromJson(String str) => BoardListModel.fromJson(json.decode(str));

String boardListModelToJson(BoardListModel data) => json.encode(data.toJson());

class BoardListModel {
  List<AppointmentBoard>? appointments;
  List<SaleBoard>? sales;
  List<BoardDemos>? boardDemo;

  BoardListModel({
    this.appointments,
    this.sales,
    this.boardDemo
  });

  factory BoardListModel.fromJson(Map<String, dynamic> json) => BoardListModel(
    appointments: List<AppointmentBoard>.from(json["appointments"].map((x) => AppointmentBoard.fromJson(x))),
    sales: List<SaleBoard>.from(json["sales"].map((x) => SaleBoard.fromJson(x))),
    boardDemo: List<BoardDemos>.from(json["demos"].map((x) => BoardDemos.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "appointments": List<dynamic>.from(appointments!.map((x) => x.toJson())),
    "sales": List<dynamic>.from(sales!.map((x) => x.toJson())),
    "demos": List<dynamic>.from(boardDemo!.map((x) => x.toJson())),
  };
}






