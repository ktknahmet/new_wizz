// To parse this JSON data, do
//
//     final saleDocument = saleDocumentFromJson(jsonString);

import 'dart:convert';

List<SaleDocument> saleDocumentFromJson(String str) => List<SaleDocument>.from(json.decode(str).map((x) => SaleDocument.fromJson(x)));

String saleDocumentToJson(List<SaleDocument> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SaleDocument {
  int? id;
  String? typeName;
  String? typeDescription;

  SaleDocument({
     this.id,
     this.typeName,
     this.typeDescription,
  });

  factory SaleDocument.fromJson(Map<String, dynamic> json) => SaleDocument(
    id: json["id"],
    typeName: json["typeName"],
    typeDescription: json["typeDescription"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeName": typeName,
    "typeDescription": typeDescription,
  };
}
