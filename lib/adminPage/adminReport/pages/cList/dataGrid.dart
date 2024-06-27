
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/customerListModel/cListmodel.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
class ClistGridSource extends DataGridSource {
  final BuildContext context;
  List<DataGridRow> dataGridRows = [];
  ClistGridSource({required List<Datum?> data, required this.context}) {

    cData = data
        .map<DataGridRow>((e) =>
        DataGridRow(cells: [
          DataGridCell<String>(columnName: 'profile'.tr(), value: e!.avatar ?? ""),
          DataGridCell<String>(columnName: 'firstName'.tr(), value: "${e.firstName!} ${e.middleName ?? ""}"),
          DataGridCell<String>(columnName: 'lastName'.tr(), value: e.lastName!),
          DataGridCell<String>(columnName: 'email'.tr(), value: e.loginEmail!),
          DataGridCell<String>(columnName: 'phone'.tr(), value: e.loginPhone!),
          DataGridCell<String>(columnName: 'birthDay'.tr(), value: e.dateOfBirth!),
          DataGridCell<String>(columnName: 'status'.tr(), value: e.isActive == true ? "Active" : "De Active"),
          DataGridCell<String>(columnName: 'product'.tr(), value: e.productSerialNumbers ?? ""),

        ])).toList();
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
            child: e.value
                .toString()
                .isNotEmpty
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
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
          );
        }
      }).toList(),
    );
  }

}
