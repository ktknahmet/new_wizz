
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/boardDemos.dart';
import 'package:wizzsales/adminPage/adminModel/referralListModel/Data.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class DemoBoardGridData extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  DemoBoardGridData({required List<BoardDemos?> data, required this.context}) {
    cData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'status'.tr(), value: e!.status ?? ""),
      DataGridCell<String>(columnName: 'name'.tr(), value: "${e.demoCustomerName ?? ""} ${e.demoCustomerSurname ?? ""}"),
      DataGridCell<String>(columnName: 'email'.tr(), value: e.demoCustomerEmail ?? ""),
      DataGridCell<String>(columnName: 'phone'.tr(), value: e.demoCustomerPhone ?? ""),
      DataGridCell<String>(columnName: 'demoStartDate'.tr(), value: mmDDYDateTime(e.demoStartTime ?? "")),
      DataGridCell<String>(columnName: 'demoEndTime'.tr(), value: calculateTimeDifference(e.demoStartTime ?? "",e.demoEndTime ?? "")),
      DataGridCell<String>(columnName: 'city'.tr(), value: e.demoCity ?? ""),
      DataGridCell<String>(columnName: 'address'.tr(), value: e.demoAddress ?? ""),
      DataGridCell<String>(columnName: 'zipCode'.tr(), value: e.demoZipcode ?? ""),

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
        if (e.columnName == 'status'.tr()) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value,
                style: e.value =="Sold/Registered" || e.value =="Demo Completed" ?
                CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)) :
                CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.error))),

          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString(), style: CustomTextStyle().semiBold12(
                ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
          );
        }

      }).toList(),
    );
  }
}
