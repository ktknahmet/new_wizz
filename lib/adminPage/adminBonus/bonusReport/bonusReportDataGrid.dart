
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusWinnerList.dart';
import 'package:wizzsales/adminPage/adminModel/customerEventModel/Data.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class BonusReportDataGrid extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  BonusReportDataGrid({required List<BonusWinnerList?> data, required this.context}) {
    cData = data.map<DataGridRow>((e) => DataGridRow(cells: [
    DataGridCell<String>(columnName: 'date'.tr(), value: mmDDYDate(e!.vestingDate!)),
      DataGridCell<String>(columnName: 'role'.tr(), value: e.roleName ?? ""),
      DataGridCell<String>(columnName: 'user'.tr(), value: e.userName ?? ""),
      DataGridCell<String>(columnName: 'bonusType'.tr(), value: e.bonusType ?? ""),
      DataGridCell<String>(columnName: 'totalQuantity'.tr(), value: "${e.totalQuantity ?? 0}"),
      DataGridCell<String>(columnName: 'bonusAmount'.tr(), value: "\$${e.bonusAmount ?? "0.0"}")

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
