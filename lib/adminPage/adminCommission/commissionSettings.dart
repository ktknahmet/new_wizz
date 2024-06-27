import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';

import '../../constants/colorsUtil.dart';
import '../../utils/style/WidgetStyle.dart';

class CommissionSettings extends BaseStatefulPage {
  const CommissionSettings(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _CommissionSettingsState();
}

class _CommissionSettingsState extends BaseStatefulPageState<CommissionSettings> {
  @override
  Widget design() {

    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.adminCommission}');
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
                  Text("commissionRate".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.payPeriodPage}');
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
                  Text("comPayPeriodSettings".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.commReport}');
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
                  Text("comReport".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
