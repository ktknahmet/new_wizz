// To parse this JSON data, do
//
//     final stockReportModel = stockReportModelFromJson(jsonString);

import 'dart:convert';

import 'package:wizzsales/adminPage/adminModel/stockReportModel/stockReportData.dart';

StockReportModel stockReportModelFromJson(String str) => StockReportModel.fromJson(json.decode(str));

String stockReportModelToJson(StockReportModel data) => json.encode(data.toJson());

class StockReportModel {
  int? currentPage;
  List<StockReportDataDetails>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  dynamic lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  dynamic path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  StockReportModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory StockReportModel.fromJson(Map<String, dynamic> json) => StockReportModel(
    currentPage: json["current_page"],
    data: List<StockReportDataDetails>.from(json["data"].map((x) => StockReportDataDetails.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}


class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
