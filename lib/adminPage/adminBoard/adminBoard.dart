import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';

import '../../utils/style/CustomTextStyle.dart';

class AdminBoard extends BaseStatefulPage {
  const AdminBoard(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AdminBoardState();
}

class _AdminBoardState extends BaseStatefulPageState<AdminBoard> {

  @override
  Widget design() {

    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.appointmentBoard}');
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
                  Text("appointmentBoard".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.weeklyApptBoard}');
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
                  Text("weeklyApptBoard".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.salesBoard}');
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
                  Text("salesBoard".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/${PageName.successBoard}');
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
                  Text("liveDemoReport".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
