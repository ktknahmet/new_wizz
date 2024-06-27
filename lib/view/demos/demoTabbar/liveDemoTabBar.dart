
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/view/demos/liveDemoChart/demoAppointment.dart';
import 'package:wizzsales/view/demos/liveDemoChart/demoNotSale.dart';
import 'package:wizzsales/view/demos/liveDemoChart/demoSales.dart';
import 'package:wizzsales/view/demos/liveDemoChart/demosRightNow.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import '../../../utils/style/CustomTextStyle.dart';

class LiveDemoTabBar extends StatefulWidget {
  const LiveDemoTabBar( {super.key});

  @override
  State<StatefulWidget> createState() => _LiveDemoTabBarState();
}

class _LiveDemoTabBarState extends State<LiveDemoTabBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      body: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(sizeWidth(context).height*0.12),
            child: AppBar(
              elevation: 0,
              backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
              leading: BackButton(
                  color: ColorUtil().getColor(context, ColorEnums.textTitleLight)
              ),
              title: Text("liveDemo".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              actions: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/${PageName.startDemo}');
                  },
                  child: Icon(Icons.add,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),),
                )
              ],
              bottom: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                labelStyle: CustomTextStyle().semiBold12(AppColors.wizzColor),
                unselectedLabelStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                indicatorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                labelColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                unselectedLabelColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                tabs:  [
                  Tab(child: Text("liveDemos".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab(child: Text("myAppointments".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab( child: Text("demosSold".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab(child: Text("demoUnSuccess".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),

                ],
              ),
            ),
          ),
          body: Container(
            color: ColorUtil().getColor(context, ColorEnums.background),
            child: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                DemosRightNow(),
                DemoAppointment(),
                DemoSales(),
                DemoNotSale(),


              ],
            ),
          ),

        ),
      ),
    );
  }
  }

