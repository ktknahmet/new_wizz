
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/adminContestModel/Data.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';

class AdminContestGrid extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  AdminContestGrid({required List<Data?> data, required this.context}) {
    cData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [

      DataGridCell<String>(columnName: 'profile'.tr(), value: e!.image ?? ""),
      DataGridCell<String>(columnName: 'contestName'.tr(), value: e.name ?? ""),
      DataGridCell<String>(columnName: 'startDate'.tr(), value: e.startdate ?? ""),
      DataGridCell<String>(columnName: 'endDate'.tr(), value: e.enddate ?? ""),
      DataGridCell<String>(columnName: 'organisation'.tr(), value: e.orgname ?? ""),
      DataGridCell<String>(columnName: 'status'.tr(), value: e.statusName ?? ""),
      DataGridCell<String>(columnName: 'edit'.tr(), value: "edit".tr()),
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
        if (e.columnName == 'profile'.tr()) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: e.value.toString().isNotEmpty
                ? FadeInImage.assetNetwork(
              placeholder: 'assets/loading.gif',
              image: e.value!,
              fit: BoxFit.contain,
            )
                : Image.asset(
              "assets/uploadPhoto.webp",
              fit: BoxFit.contain,
            ),

          );
        }else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString(), style :e.value.toString()=="edit".tr() ?
            CustomTextStyle().semiBold12(
                ColorUtil().getColor(context, ColorEnums.error))
              :CustomTextStyle().semiBold12(
                ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
          );
        }
      }).toList(),
    );
  }
}
