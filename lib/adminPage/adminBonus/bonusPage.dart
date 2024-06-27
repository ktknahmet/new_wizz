import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';

import '../../constants/colorsUtil.dart';

class BonusPage extends BaseStatefulPage {
  const BonusPage(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _BonusPageState();
}

class _BonusPageState extends BaseStatefulPageState<BonusPage> {
  @override
  Widget design() {

    return  Column(
      children: [
        GestureDetector(
          onTap: (){

            Navigator.pushNamed(context, '/${PageName.bonusScreen}');
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
                  Text("bonusConfig".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){

            Navigator.pushNamed(context, '/${PageName.bonusWinner}');
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
                  Text("bonusWinner".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){

            Navigator.pushNamed(context, '/${PageName.addBonusScreen}');
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
                  Text("addBonus".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.add, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){

            Navigator.pushNamed(context, '/${PageName.bonusWinnerReport}');
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
                  Text("bonusWinnerReport".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
