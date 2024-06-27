
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comReportModel.dart';
import 'package:wizzsales/adminPage/adminModel/customerEventModel/Data.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/expenseModel/allExpenseModel.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class ComReportGridData extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  ComReportGridData({required List<ComReportModel?> data, required this.context}) {
    cData = data.map<DataGridRow>((e) => DataGridRow(cells: [

      DataGridCell<String>(columnName: 'commissionType'.tr(), value: e!.commType ?? ""),
      DataGridCell<String>(columnName: 'poolStatus'.tr(), value: e.isActivePool == true ? "Active" :"InActive" ),
      DataGridCell<String>(columnName: 'user'.tr(), value: e.userName ?? ""),
      DataGridCell<String>(columnName: 'role'.tr(), value: e.profileMenurole!.toUpperCase()),
      DataGridCell<String>(columnName: 'salesRole'.tr(), value: e.eligibleRoleName ?? ""),
      DataGridCell<String>(columnName: 'salePrice'.tr(), value: "\$${e.salePrice ?? "0.00"}"),
      DataGridCell<String>(columnName: 'organisation'.tr(), value: e.organisationName ?? ""),
      DataGridCell<String>(columnName: 'minAmount'.tr(), value: "\$${e.minAmount ?? "0.00"}"),
      DataGridCell<String>(columnName: 'maxAmount'.tr(), value: "\$${e.maxAmount ?? "0.00"}"),
      DataGridCell<String>(columnName: 'comAmount'.tr(), value: "\$${e.commAmount ?? "0.00"}"),
      DataGridCell<String>(columnName: 'isPaid?'.tr(), value: e.isCommPaid == true ? "Paid" : "UnPaid"),
      DataGridCell<String>(columnName: 'beginDate'.tr(), value:mmDDYDate(e.beginDate)),
      DataGridCell<String>(columnName: 'expireDate'.tr(), value: mmDDYDate(e.expireDate)),
      DataGridCell<String>(columnName: 'payDate'.tr(), value: e.isCommPaid == true ? mmDDYDate(e.payAt) :"Did not pay yet" ),
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
