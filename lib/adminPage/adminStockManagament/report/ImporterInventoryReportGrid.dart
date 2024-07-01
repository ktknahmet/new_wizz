
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/customerEventModel/Data.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/expenseModel/allExpenseModel.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

import '../../adminModel/stockReportModel/stockReportData.dart';

class ImporterInventoryReportGrid extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  ImporterInventoryReportGrid({required List<StockReportDataDetails?> data, required this.context}) {
    cData = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'stockDate'.tr(), value: mmDDYDate(e!.stockDate!.toString())),
      DataGridCell<String>(columnName: 'enterSerialNumber'.tr(), value: e.serialNumber ?? ""),
      DataGridCell<String>(columnName: 'assigned'.tr(), value: e.assignedToDistributor == true ? "Assign" :"Not Assign"),
      DataGridCell<String>(columnName: 'product'.tr(), value: e.productName ?? ""),
      DataGridCell<String>(columnName: 'distributor'.tr(), value: e.distName ?? ""),
    ])).toList();
  }

  List<DataGridRow> cData = [];

  @override
  List<DataGridRow> get rows => cData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            e.value.toString(),
            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
          ),

        );
      }).toList(),
    );
  }
}
