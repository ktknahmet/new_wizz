// To parse this JSON data, do
//
//     final dealerList = dealerListFromJson(jsonString);

import 'dart:convert';

DealerList dealerListFromJson(String str) => DealerList.fromJson(json.decode(str));

String dealerListToJson(DealerList data) => json.encode(data.toJson());

class DealerList {
  int? id;
  String? name;

  DealerList({
    this.id,
    this.name,
  });

  factory DealerList.fromJson(Map<String, dynamic> json) => DealerList(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
