
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/enterSerialModel/Data.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
class SerialNumberGridSource extends DataGridSource{
  final BuildContext context;
  SerialNumberGridSource({required List<Data?> data,required this.context}) {
    cData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [

      DataGridCell<String>(columnName: 'serialId'.tr(), value: e!.serialId!),
      DataGridCell<String>(columnName: 'firstName'.tr(), value: e.customerFirstname!),
      DataGridCell<String>(columnName: 'lastName'.tr(), value: e.customerLastname!),
      DataGridCell<String>(columnName: 'email'.tr(), value: e.customerEmail ?? ""),
      DataGridCell<String>(columnName: 'phone'.tr(), value: e.customerPhone ?? ""),
      DataGridCell<String>(columnName: 'organisation'.tr(), value:e.organisationName ?? ""),
      DataGridCell<String>(columnName: 'enterDate'.tr(), value: mmDDY(e.enteredDate!)),

    ])).toList();
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
          child: Text(e.value.toString(),
            style: e.value.toString().contains("No matching")
                ?CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.error))
            :CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),


        );
      }).toList(),
    );
  }
}
