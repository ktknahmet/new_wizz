
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/leadReport/LeadReport.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';

class MyLeadGrid extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  MyLeadGrid({required List<LeadReport?> data, required this.context}) {
    cData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [

      DataGridCell<String>(columnName: 'leadType'.tr(), value: e!.leadTypeName ?? ""),
      DataGridCell<int>(columnName: 'total'.tr(), value: (e.aptSetCount ?? 0)+(e.notContacted ?? 0)
          +(e.soldCount ?? 0)+(e.notInterested ?? 0)+(e.aptCanceled ?? 0)+(e.aptRescheduled ?? 0)+(e.notHomeCount ?? 0)+(e.dns ?? 0)),
      DataGridCell<int>(columnName: 'appointmentSet'.tr(), value: e.aptSetCount ?? 0),
      DataGridCell<int>(columnName: 'notContacted'.tr(), value: e.notContacted ?? 0),
      DataGridCell<int>(columnName: 'sold'.tr(), value: e.soldCount ?? 0),
      DataGridCell<int>(columnName: 'notInterested'.tr(), value: e.notInterested ?? 0),
      DataGridCell<int>(columnName: 'aptCanceled'.tr(), value: e.aptCanceled ?? 0),
      DataGridCell<int>(columnName: 'aptRescheduled'.tr(), value: e.aptRescheduled ?? 0),
      DataGridCell<int>(columnName: 'notHome'.tr(), value: e.notHomeCount ?? 0),
      DataGridCell<int>(columnName: 'dns'.tr(), value: e.dns ?? 0),

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

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(e.value.toString(), style :CustomTextStyle().semiBold12(
              ColorUtil().getColor(context, ColorEnums.textTitleLight))),
        );

      }).toList(),
    );
  }

}
