
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

import '../../../model/appointmentModel/Data.dart';


class AppointmentGrid extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  AppointmentGrid({required List<Data?> data, required this.context}) {
    cData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [

      DataGridCell<String>(columnName: 'date'.tr(), value: mmDDYDate(e!.appointmentdate!) ?? ""),
      DataGridCell<String>(columnName: 'time'.tr(), value: e.appointmenttime ?? ""),
      DataGridCell<String>(columnName: 'cName'.tr(), value: "${e.cfirstname ?? ""} ${e.clastname ?? ""}"),
      DataGridCell<String>(columnName: 'address'.tr(), value: e.caddress ?? ""),
      DataGridCell<String>(columnName: 'cPhone'.tr(), value: e.cphone ?? ""),
      DataGridCell<String>(columnName: 'email'.tr(), value: e.cemail ?? ""),
      DataGridCell<String>(columnName: 'referredBy'.tr(), value: e.referredby ?? ""),
      DataGridCell<String>(columnName: 'distributor'.tr(), value: e.orgname ?? ""),
      DataGridCell<String>(columnName: 'dealerRunBy'.tr(), value: e.dealername ?? ""),
      DataGridCell<String>(columnName: 'leadType'.tr(), value: e.leadtypename ?? ""),
      DataGridCell<String>(columnName: 'status'.tr(), value: statusCase(e.astatus!)),

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
                ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
          );

      }).toList(),
    );
  }

}
