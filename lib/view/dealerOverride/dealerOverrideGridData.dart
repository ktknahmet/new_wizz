
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideWinner.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/overrideModel/dealerOverrideWinner.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
class DealerOverrideGridData extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  DealerOverrideGridData({required List<DealerOverrideWinner> data, required this.context}) {
    cData = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'overrideAmount'.tr(), value: "\$${e!.overrideAmount ?? "0.0"}"),
      DataGridCell<String>(columnName: "puchases".tr(), value:e.organisationName ?? ""),
      DataGridCell<String>(columnName: "overrideType".tr(), value:e.overrideType ?? ""),
      DataGridCell<String>(columnName: 'overrideReceiveBy'.tr(), value: e.userName ?? ""),
      DataGridCell<String>(columnName: 'product'.tr(), value: e.productName ?? ""),
      DataGridCell<String>(columnName: 'enterSerialNumber'.tr(), value:e.serialNumber ?? ""),
      DataGridCell<String>(columnName: 'overrideCalDate'.tr(), value:mmDDYDate(e.calculatedDate)),


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
