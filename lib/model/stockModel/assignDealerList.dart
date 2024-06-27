// To parse this JSON data, do
//
//     final assignDealerList = assignDealerListFromJson(jsonString);

import 'dart:convert';

List<AssignDealerList> assignDealerListFromJson(String str) => List<AssignDealerList>.from(json.decode(str).map((x) => AssignDealerList.fromJson(x)));

String assignDealerListToJson(List<AssignDealerList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignDealerList {
  String? serialNumber;
  int? quantity;
  String? stockDate;
  int? poolDetailId;
  String? assignedToDealerAt;

  AssignDealerList({
    this.serialNumber,
    this.quantity,
    this.stockDate,
    this.poolDetailId,
    this.assignedToDealerAt,
  });

  factory AssignDealerList.fromJson(Map<String, dynamic> json) => AssignDealerList(
    serialNumber: json["serial_number"],
    quantity: json["quantity"],
    stockDate: json["stock_date"],
    poolDetailId: json["pool_detail_id"],
    assignedToDealerAt: json["assigned_to_dealer_at"],
  );

  Map<String, dynamic> toJson() => {
    "serial_number": serialNumber,
    "quantity": quantity,
    "stock_date": stockDate,
    "pool_detail_id": poolDetailId,
    "assigned_to_dealer_at": assignedToDealerAt,
  };
}
