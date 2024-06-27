
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

class ExpenseReportGrid extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  ExpenseReportGrid({required List<AllExpenseModel?> data, required this.context}) {
    cData = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'cName'.tr(), value: e!.customerName ?? ""),
      DataGridCell<String>(columnName: 'organisation'.tr(), value: e.organisationName ?? ""),
      DataGridCell<String>(columnName: 'expense'.tr(), value: e.expenseName ?? ""),
      DataGridCell<String>(columnName: 'expenseDate'.tr(), value: mmDDYDate(e.expenseDate)),
      DataGridCell<String>(columnName: 'expenseNetPrice'.tr(), value: e.expenseNetPrice ?? ""),
      //DataGridCell<String>(columnName: 'expenseTaxPrice'.tr(), value: e.expenseTaxPrice ?? ""),
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
