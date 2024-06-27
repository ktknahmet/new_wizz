// To parse this JSON data, do
//
//     final getSaleDocument = getSaleDocumentFromJson(jsonString);

import 'dart:convert';

List<GetSaleDocument> getSaleDocumentFromJson(String str) => List<GetSaleDocument>.from(json.decode(str).map((x) => GetSaleDocument.fromJson(x)));

String getSaleDocumentToJson(List<GetSaleDocument> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSaleDocument {
  String? documentPath;
  String? typeName;
  String? note;
  dynamic createdAt;
  dynamic updatedAt;

  GetSaleDocument({
    this.documentPath,
    this.typeName,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory GetSaleDocument.fromJson(Map<String, dynamic> json) => GetSaleDocument(
    documentPath: json["documentPath"],
    typeName: json["typeName"],
    note: json["note"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "documentPath": documentPath,
    "typeName": typeName,
    "note": note,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
