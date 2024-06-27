
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/customerEventModel/Data.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class CEventDataGrid extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  CEventDataGrid({required List<Data?> data, required this.context}) {
    cData = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'details'.tr(), value: "details".tr()),
      DataGridCell<String>(columnName: "eventAction".tr(), value:e!.rewardEvent !=null ? e.rewardEvent!.eventViewName !=null ? e.rewardEvent!.eventViewName! :"" : "none"),
      DataGridCell<String>(columnName: "video".tr(), value:e.rewardEventActivityDetailDocuments !=null ? e.rewardEventActivityDetailDocuments![0].documentPath!.isNotEmpty ? "video".tr() :"not video" : "none"),
      DataGridCell<String>(columnName: 'profile'.tr(), value: e.customer!.avatar ?? ""),
      DataGridCell<String>(columnName: 'status'.tr(), value: e.eventState!),
      DataGridCell<String>(columnName: 'eventPoint'.tr(), value: e.eventPoint!.toString()),
      DataGridCell<String>(columnName: 'firstName'.tr(), value: "${e.customer!.firstName!} ${e.customer!.middleName ?? ""}"),
      DataGridCell<String>(columnName: 'lastName'.tr(), value: e.customer!.lastName!),
      DataGridCell<String>(columnName: 'email'.tr(), value: e.customer!.loginEmail!),
      DataGridCell<String>(columnName: 'phone'.tr(), value: e.customer!.loginPhone!),
      DataGridCell<String>(columnName: 'birthDay'.tr(), value: e.customer!.dateOfBirth!),
      DataGridCell<String>(columnName: 'date'.tr(), value: mmDDYDate(e.issueDate!)),
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
        } else if(e.columnName=='details'.tr()){

          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value.toString(),
              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.error)),

            ),

          );
        }else{
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value.toString(),
              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),

            ),

          );
        }
      }).toList(),
    );
  }
}
