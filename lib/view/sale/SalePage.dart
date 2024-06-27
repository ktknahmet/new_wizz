import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';

class SalePage extends BaseStatefulPage {
  const SalePage(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _SalePageState();
}

class _SalePageState extends BaseStatefulPageState<SalePage> {


  @override
  Widget design() {

    return  Column(
      children: [
        SizedBox(
          height: 50,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${PageName.addSale}',arguments: {'demoId':null});
            },
            child: Card(
              shape: cardShape(context),
              color: ColorUtil().getColor(context, ColorEnums.background),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("addSale".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.add, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          height: 50,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${PageName.mySaleTabBar}',arguments: {'index':0});

            },
            child: Card(
              shape: cardShape(context),
              color: ColorUtil().getColor(context, ColorEnums.background),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("mySale".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          height: 50,
          child: GestureDetector(
            onTap: () async{
              Navigator.pushNamed(context, '/${PageName.officeSaleTabBar}',arguments: {'index':0});

            },
            child: Card(
              shape: cardShape(context),
              color: ColorUtil().getColor(context, ColorEnums.background),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("officeSale".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          height: 50,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${PageName.startDemo}');
            },
            child: Card(
              shape: cardShape(context),
              color: ColorUtil().getColor(context, ColorEnums.background),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("startDemo".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          height: 50,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${PageName.completeDemo}');
            },
            child: Card(
              shape: cardShape(context),
              color: ColorUtil().getColor(context, ColorEnums.background),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("completeDemo".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }


}
