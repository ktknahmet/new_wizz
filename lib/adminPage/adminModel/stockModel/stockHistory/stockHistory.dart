// To parse this JSON data, do
//
//     final stockHistory = stockHistoryFromJson(jsonString);

import 'dart:convert';

List<StockHistory> stockHistoryFromJson(String str) => List<StockHistory>.from(json.decode(str).map((x) => StockHistory.fromJson(x)));

String stockHistoryToJson(List<StockHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockHistory {
  int? historyId;
  int? poolDetailId;
  int? stockPoolId;
  int? productId;
  dynamic stockDate;
  int? quantity;
  String? serialNumber;
  int? distributorId;
  dynamic createdAt;
  dynamic updatedAt;
  bool? assignedToDistributor;
  dynamic assignedToDistributorAt;
  int? dealerId;
  bool? assignedToDealer;
  dynamic assignedToDealerAt;
  bool? returnDistributor;
  dynamic returnToDistributorAt;
  int? dealerWhoReturns;
  bool? isPaid;
  dynamic paidAt;
  String? changeType;
  dynamic changeTimestamp;
  String? distributorName;
  String? currentlyHoldingDealer;
  String? refunderDealer;

  StockHistory({
    this.historyId,
    this.poolDetailId,
    this.stockPoolId,
    this.productId,
    this.stockDate,
    this.quantity,
    this.serialNumber,
    this.distributorId,
    this.createdAt,
    this.updatedAt,
    this.assignedToDistributor,
    this.assignedToDistributorAt,
    this.dealerId,
    this.assignedToDealer,
    this.assignedToDealerAt,
    this.returnDistributor,
    this.returnToDistributorAt,
    this.dealerWhoReturns,
    this.isPaid,
    this.paidAt,
    this.changeType,
    this.changeTimestamp,
    this.distributorName,
    this.currentlyHoldingDealer,
    this.refunderDealer,
  });

  factory StockHistory.fromJson(Map<String, dynamic> json) => StockHistory(
    historyId: json["history_id"],
    poolDetailId: json["pool_detail_id"],
    stockPoolId: json["stock_pool_id"],
    productId: json["product_id"],
    stockDate: json["stock_date"],
    quantity: json["quantity"],
    serialNumber: json["serial_number"],
    distributorId: json["distributor_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    assignedToDistributor: json["assigned_to_distributor"],
    assignedToDistributorAt: json["assigned_to_distributor_at"],
    dealerId: json["dealer_id"],
    assignedToDealer: json["assigned_to_dealer"],
    assignedToDealerAt: json["assigned_to_dealer_at"],
    returnDistributor: json["return_distributor"],
    returnToDistributorAt: json["return_to_distributor_at"],
    dealerWhoReturns: json["dealer_who_returns"],
    isPaid: json["is_paid"],
    paidAt: json["paid_at"],
    changeType: json["change_type"],
    changeTimestamp: json["change_timestamp"],
    distributorName: json["distributor_name"],
    currentlyHoldingDealer: json["currently_holding_dealer"],
    refunderDealer: json["refunder_dealer"],
  );

  Map<String, dynamic> toJson() => {
    "history_id": historyId,
    "pool_detail_id": poolDetailId,
    "stock_pool_id": stockPoolId,
    "product_id": productId,
    "stock_date": stockDate,
    "quantity": quantity,
    "serial_number": serialNumber,
    "distributor_id": distributorId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "assigned_to_distributor": assignedToDistributor,
    "assigned_to_distributor_at": assignedToDistributorAt,
    "dealer_id": dealerId,
    "assigned_to_dealer": assignedToDealer,
    "assigned_to_dealer_at": assignedToDealerAt,
    "return_distributor": returnDistributor,
    "return_to_distributor_at": returnToDistributorAt,
    "dealer_who_returns": dealerWhoReturns,
    "is_paid": isPaid,
    "paid_at": paidAt,
    "change_type": changeType,
    "change_timestamp": changeTimestamp,
    "distributor_name": distributorName,
    "currently_holding_dealer": currentlyHoldingDealer,
    "refunder_dealer": refunderDealer,
  };
}
