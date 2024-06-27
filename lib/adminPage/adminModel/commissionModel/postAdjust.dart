// To parse this JSON data, do
//
//     final postAdjust = postAdjustFromJson(jsonString);

import 'dart:convert';

PostAdjust postAdjustFromJson(String str) => PostAdjust.fromJson(json.decode(str));

String postAdjustToJson(PostAdjust data) => json.encode(data.toJson());

class PostAdjust {
  int? calcPoolSaleId;
  int? adjustAmount;
  String? note;

  PostAdjust({
    this.calcPoolSaleId,
    this.adjustAmount,
    this.note
  });

  factory PostAdjust.fromJson(Map<String, dynamic> json) => PostAdjust(
    calcPoolSaleId: json["calc_pool_sale_id"],
    adjustAmount: json["adjust_amount"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "calc_pool_sale_id": calcPoolSaleId,
    "adjust_amount": adjustAmount,
    "note": note,
  };
}
