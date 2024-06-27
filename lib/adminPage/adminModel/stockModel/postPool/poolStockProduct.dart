class PoolStockProduct {
  int? productId;
  String? productSerialNumber;
  DateTime? stockDate;
  int? distributorId;
  int? importerWarehouseId;
  int? distWarehouseId;
  String? importerWarehouseName;
  String? distWarehouseName;

  PoolStockProduct({
    this.productId,
    this.productSerialNumber,
    this.stockDate,
    this.distributorId,
    this.importerWarehouseId,
    this.distWarehouseId,
    this.importerWarehouseName,
    this.distWarehouseName
  });

  factory PoolStockProduct.fromJson(Map<String, dynamic> json) => PoolStockProduct(
    productId: json["product_id"],
    productSerialNumber: json["product_serial_number"],
    stockDate: DateTime.parse(json["stock_date"]),
    distributorId: json["distributor_id"],
    importerWarehouseId: json["importer_warehouse_id"],
    distWarehouseId: json["distributor_warehouse_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_serial_number": productSerialNumber,
    "stock_date": "${stockDate!.year.toString().padLeft(4, '0')}-${stockDate!.month.toString().padLeft(2, '0')}-${stockDate!.day.toString().padLeft(2, '0')}",
    "distributor_id": distributorId,
    "importer_warehouse_id":importerWarehouseId,
    "distributor_warehouse_id":distWarehouseId
  };
}