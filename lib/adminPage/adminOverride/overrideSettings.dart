import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';

import '../../constants/colorsUtil.dart';

class OverrideSettings extends BaseStatefulPage {
  const OverrideSettings(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _OverrideSettingsState();
}

class _OverrideSettingsState extends BaseStatefulPageState<OverrideSettings> {
  @override
  Widget design() {
    return Column(
      children: [
        GestureDetector(
          onTap: (){

            Navigator.pushNamed(context, '/${PageName.addOverrideScreen}');
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
                  Text("addOverride".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){

            Navigator.pushNamed(context, '/${PageName.overrideScreen}');
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
                  Text("overrideConfig".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),

        GestureDetector(
          onTap: (){

            Navigator.pushNamed(context, '/${PageName.productCost}');
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
                  Text("overrideProductCost".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){

            Navigator.pushNamed(context, '/${PageName.setOverrideUserPage}');
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
                  Text("setOverrideUser".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),

      ],
    );
  }
}
