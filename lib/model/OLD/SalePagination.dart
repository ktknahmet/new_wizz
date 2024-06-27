// ignore_for_file: non_constant_identifier_names



import 'package:wizzsales/model/OLD/Sale.dart';

class SalePagination {
  int? current_page;
  int? last_page;
  int? total;
  List<Sale>? data = [];


  SalePagination(
      {
        this.current_page,
        this.last_page,
        this.total,
        this.data
      });

  factory SalePagination.fromJson(Map<String, dynamic> json) {
    return SalePagination(
      current_page: json['current_page'],
      last_page: json['last_page'],
      total: json['total'],
      data: json["data"] != null
          ? List<Sale>.from(
          json["data"].map((x) => Sale.fromJson(x)))
          : null,
    );
  }
}
