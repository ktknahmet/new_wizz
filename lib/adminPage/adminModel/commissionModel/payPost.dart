// To parse this JSON data, do
//
//     final payPost = payPostFromJson(jsonString);

import 'dart:convert';

PayPost payPostFromJson(String str) => PayPost.fromJson(json.decode(str));

String payPostToJson(PayPost data) => json.encode(data.toJson());

class PayPost {
  int? calcPoolSaleId;

  PayPost({
    this.calcPoolSaleId,
  });

  factory PayPost.fromJson(Map<String, dynamic> json) => PayPost(
    calcPoolSaleId: json["calc_pool_sale_id"],
  );

  Map<String, dynamic> toJson() => {
    "calc_pool_sale_id": calcPoolSaleId,
  };
}
