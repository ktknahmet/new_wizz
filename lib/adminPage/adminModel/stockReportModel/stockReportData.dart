class StockReportDataDetails {
  int? poolDetailId;
  int? stockPoolId;
  int? productId;
  DateTime? stockDate;
  int? quantity;
  String? serialNumber;
  int? distributorId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? assignedToDistributor;
  String? productName;
  String? distName;

  StockReportDataDetails({
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
    this.productName,
    this.distName
  });

  factory StockReportDataDetails.fromJson(Map<String, dynamic> json) => StockReportDataDetails(
    poolDetailId: json["pool_detail_id"],
    stockPoolId: json["stock_pool_id"],
    productId: json["product_id"],
    stockDate: DateTime.parse(json["stock_date"]),
    quantity: json["quantity"],
    serialNumber: json["serial_number"],
    distributorId: json["distributor_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    assignedToDistributor: json["assigned_to_distributor"],
    productName: json["product_name"],
    distName: json["distributor_name"],
  );

  Map<String, dynamic> toJson() => {
    "pool_detail_id": poolDetailId,
    "stock_pool_id": stockPoolId,
    "product_id": productId,
    "stock_date": "${stockDate!.year.toString().padLeft(4, '0')}-${stockDate!.month.toString().padLeft(2, '0')}-${stockDate!.day.toString().padLeft(2, '0')}",
    "quantity": quantity,
    "serial_number": serialNumber,
    "distributor_id": distributorId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "assigned_to_distributor": assignedToDistributor,
    "product_name": productName,
    "distributor_name": distName,
  };
}
