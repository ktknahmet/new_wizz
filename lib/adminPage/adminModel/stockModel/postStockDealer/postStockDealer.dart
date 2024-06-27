// To parse this JSON data, do
//
//     final postStockDealer = postStockDealerFromJson(jsonString);

import 'dart:convert';

List<PostStockDealer> postStockDealerFromJson(String str) => List<PostStockDealer>.from(json.decode(str).map((x) => PostStockDealer.fromJson(x)));

String postStockDealerToJson(List<PostStockDealer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostStockDealer {
  int? poolDetailId;
  int? dealerId;
  int? distributorId;
  int? serialNumber;

  PostStockDealer({
    this.poolDetailId,
    this.dealerId,
    this.distributorId,
    this.serialNumber,
  });

  factory PostStockDealer.fromJson(Map<String, dynamic> json) => PostStockDealer(
    poolDetailId: json["pool_detail_id"],
    dealerId: json["dealer_id"],
    distributorId: json["distributor_id"],
    serialNumber: json["serial_number"],
  );

  Map<String, dynamic> toJson() => {
    "pool_detail_id": poolDetailId,
    "dealer_id": dealerId,
    "distributor_id": distributorId,
    "serial_number": serialNumber,
  };
}
