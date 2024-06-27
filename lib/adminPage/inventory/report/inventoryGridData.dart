
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/customerEventModel/Data.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/distStockList/DistStockList.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class InventoryGridData extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  InventoryGridData({required List<DistStockList?> data, required this.context}) {
    cData = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'details'.tr(), value: "details".tr()),
      DataGridCell<String>(columnName: "enterSerialNumber".tr(), value:e!.serialNumber ?? ""),
      DataGridCell<String>(columnName: "quantity".tr(), value:"${e.quantity ?? 0}"),
      DataGridCell<String>(columnName: 'date'.tr(), value: mmDDYDate(e.stockDate ?? "")),
      DataGridCell<String>(columnName: 'isPaid?'.tr(), value: e.isPaid == true ? "Paid" :"No"),
      DataGridCell<String>(columnName: 'payDate'.tr(), value: e.payDate !=null ? mmDDYDate(e.payDate ?? "") : ""),

    ]))
        .toList();
  }

  List<DataGridRow> cData = [];

  @override
  List<DataGridRow> get rows => cData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
       if(e.columnName=='details'.tr()){

          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value.toString(),
              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.error)),

            ),

          );
        }else{
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value.toString(),
              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),

            ),

          );
        }
      }).toList(),
    );
  }
}
