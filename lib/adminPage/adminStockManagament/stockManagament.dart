import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';

class StockManagement extends BaseStatefulPage {
  const StockManagement(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _StockManagementState();
}

class _StockManagementState extends BaseStatefulPageState<StockManagement> {

  @override
  Widget design() {

    return  Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.setWarehouses}');
          },
          child: Card(
            shape: cardShape(context),
            color: ColorUtil().getColor(context, ColorEnums.background),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("setWarehouses".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){

            Navigator.pushNamed(context, '/${PageName.adminStockPages}');
          },
          child: Card(
            shape: cardShape(context),
            color: ColorUtil().getColor(context, ColorEnums.background),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("importerInventory".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.importerInventoryReport}');
          },
          child: Card(
            shape: cardShape(context),
            color: ColorUtil().getColor(context, ColorEnums.background),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("inventoryReport".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.importerSummary}');
          },
          child: Card(
            shape: cardShape(context),
            color: ColorUtil().getColor(context, ColorEnums.background),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("importerInventorySummary".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
