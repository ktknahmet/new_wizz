
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/referralListModel/Data.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class ReferralGridSource extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  ReferralGridSource({required List<Data?> data, required this.context}) {
    cData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [

      DataGridCell<String>(columnName: 'firstName'.tr(), value: e!.firstName!),
      DataGridCell<String>(columnName: 'lastName'.tr(), value: e.lastName ?? ""),
      DataGridCell<String>(columnName: 'email'.tr(), value: e.email ?? ""),
      DataGridCell<String>(columnName: 'phone'.tr(), value: e.phone ?? ""),
      DataGridCell<String>(columnName: 'createdDate'.tr(), value: mmDDY(e.createdAt!) ?? ""),
      DataGridCell<String>(columnName: 'referralCode'.tr(), value: e.customerReferralCode ?? ""),
      DataGridCell<String>(columnName: 'details'.tr(), value: "details".tr()),
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
        if (e.columnName == 'details'.tr()) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("details".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.error))),

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
