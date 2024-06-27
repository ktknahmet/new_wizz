// To parse this JSON data, do
//
//     final postReceiveAmount = postReceiveAmountFromJson(jsonString);

import 'dart:convert';

PostReceiveAmount postReceiveAmountFromJson(String str) => PostReceiveAmount.fromJson(json.decode(str));

String postReceiveAmountToJson(PostReceiveAmount data) => json.encode(data.toJson());

class PostReceiveAmount {
  int? saleId;
  dynamic receiveAmount;

  PostReceiveAmount({
    this.saleId,
    this.receiveAmount,
  });

  factory PostReceiveAmount.fromJson(Map<String, dynamic> json) => PostReceiveAmount(
    saleId: json["sale_id"],
    receiveAmount: json["receive_amount"],
  );

  Map<String, dynamic> toJson() => {
    "sale_id": saleId,
    "receive_amount": receiveAmount,
  };
}
