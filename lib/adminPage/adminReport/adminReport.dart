import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';

import '../../utils/style/CustomTextStyle.dart';

class AdminReport extends BaseStatefulPage {
  const AdminReport(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AdminReportState();
}

class _AdminReportState extends BaseStatefulPageState<AdminReport> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget design() {
    return Column(
      children: [
        SizedBox(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${PageName.adminCList}');
            },
            child: Card(
              color: ColorUtil().getColor(context, ColorEnums.background),
              elevation: 2,
              shape: cardShape(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("customerList".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward,color:ColorUtil().getColor(context, ColorEnums.textTitleLight),)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${PageName.adminReferralList}');
            },
            child: Card(
              elevation: 2,
              color: ColorUtil().getColor(context, ColorEnums.background),
              shape: cardShape(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("referralList".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward,color:ColorUtil().getColor(context, ColorEnums.textTitleLight),)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${PageName.adminSerialNumberEnter}');
            },
            child: Card(
              elevation: 2,
              color: ColorUtil().getColor(context, ColorEnums.background),
              shape: cardShape(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("serialNumberEnter".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward,color:ColorUtil().getColor(context, ColorEnums.textTitleLight),)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${PageName.adminCustomerEvent}');
            },
            child: Card(
              elevation: 2,
              color: ColorUtil().getColor(context, ColorEnums.background),
              shape: cardShape(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("customerEvent".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward,color:ColorUtil().getColor(context, ColorEnums.textTitleLight),)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),

        SizedBox(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/${PageName.adminRewardOrder}');
            },
            child: Card(
              elevation: 2,
              color: ColorUtil().getColor(context, ColorEnums.background),
              shape: cardShape(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("rewardOrders".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward,color:ColorUtil().getColor(context, ColorEnums.textTitleLight),)
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
