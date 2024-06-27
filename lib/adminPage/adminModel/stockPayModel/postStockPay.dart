// To parse this JSON data, do
//
//     final postStockPay = postStockPayFromJson(jsonString);

import 'dart:convert';

PostStockPay postStockPayFromJson(String str) => PostStockPay.fromJson(json.decode(str));

String postStockPayToJson(PostStockPay data) => json.encode(data.toJson());

class PostStockPay {
  int? poolDetailId;

  PostStockPay({
    this.poolDetailId,
  });

  factory PostStockPay.fromJson(Map<String, dynamic> json) => PostStockPay(
    poolDetailId: json["pool_detail_id"],
  );

  Map<String, dynamic> toJson() => {
    "pool_detail_id": poolDetailId,
  };
}
