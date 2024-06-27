import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/view/reports/goalsReport/chart/PersonalGoals.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class GoalsReportTabBar extends StatefulWidget {
  const GoalsReportTabBar({super.key});

  @override
  State<GoalsReportTabBar> createState() => _GoalsReportTabBarState();
}

class _GoalsReportTabBarState extends State<GoalsReportTabBar> {
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      body: DefaultTabController(
        initialIndex: 0,
        length: 1,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(sizeWidth(context).height*0.12),
            child: AppBar(
              elevation: 0,
              backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
              leading: BackButton(
                  color: ColorUtil().getColor(context, ColorEnums.textTitleLight)
              ),
              title: Text("goalsReport".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              bottom: TabBar(
                
                dividerColor: Colors.transparent,
                labelStyle: CustomTextStyle().semiBold12(AppColors.wizzColor),
                unselectedLabelStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                indicatorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                labelColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                unselectedLabelColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                tabs:  [
                  //Tab(child: Text("minimumGoals".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab(child: Text("personalGoals".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                ],
              ),
            ),
          ),
          body: Container(
            color: ColorUtil().getColor(context, ColorEnums.background),
            child: const TabBarView(
              children: [
                //MinimumGoals(),
                PersonalGoals(),
              ],
            ),
          ),

        ),
      ),
    );
  }

}
