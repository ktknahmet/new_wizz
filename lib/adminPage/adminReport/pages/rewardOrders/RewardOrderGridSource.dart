
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/enterSerialModel/Data.dart';
import 'package:wizzsales/adminPage/adminModel/rewardOrderModel/rewardOrderModel.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class RewardOrderGridSource extends DataGridSource {
  final BuildContext context;
  DataGridController dataGridController = DataGridController();
  RewardOrderGridSource({required List<RewardData?> data, required this.context}) {
    cData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'details'.tr(), value: "details".tr()),
      DataGridCell<String>(columnName: 'usedDate'.tr(), value: e!.isUsedCodeByCustomer == true ? mmDDYDate(e.usedCodeByCustomerDate) : "notUsed".tr()),
      DataGridCell<String>(columnName: 'transactionCode'.tr(), value: e.transactionCode!),
      DataGridCell<String>(columnName: 'customerRewardOrderCode'.tr(), value: e.customerRewardOrderCode!),
      DataGridCell<String>(columnName: 'orderDate'.tr(), value: mmDDYDate(e.orderDate!.toString())),
      DataGridCell<String>(columnName: 'firstName'.tr(), value: "${e.customer!.firstName!} ${e.customer!.middleName ?? ""}"),
      DataGridCell<String>(columnName: 'lastName'.tr(), value: e.customer!.lastName!),
      DataGridCell<String>(columnName: 'email'.tr(), value: e.customer!.loginEmail!),
      DataGridCell<String>(columnName: 'phone'.tr(), value: e.customer!.loginPhone!),
      DataGridCell<String>(columnName: 'status'.tr(), value: e.isApproved == true  ? "approved".tr() : e.isCanceled == true ? "canceled".tr() :"noApproved".tr()),
      DataGridCell<String>(columnName: 'statusDate'.tr(), value: e.approvedDate !=null ? mmDDYDate(e.approvedDate) : e.canceledDate !=null ? mmDDYDate(e.canceledDate) : ""),

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
        }else if (e.columnName == 'status'.tr()) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.error))),

          );
        } else {
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
