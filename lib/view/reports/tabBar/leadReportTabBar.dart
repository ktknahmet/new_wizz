import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/view/reports/leadReport/chart/lastMontlyLeadReport.dart';
import 'package:wizzsales/view/reports/leadReport/chart/leadsDetails.dart';
import 'package:wizzsales/view/reports/leadReport/chart/monthlyLeadReport.dart';
import 'package:wizzsales/view/reports/leadReport/chart/todayLeadReport.dart';
import 'package:wizzsales/view/reports/leadReport/chart/annualLeadReport.dart';
import 'package:wizzsales/view/reports/leadReport/chart/weeklyLeadChart.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class LeadReportTabBar extends StatefulWidget {
  const LeadReportTabBar({super.key});

  @override
  State<LeadReportTabBar> createState() => _LeadReportTabBarState();
}

class _LeadReportTabBarState extends State<LeadReportTabBar> {
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
        length: 6,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(sizeWidth(context).height*0.12),
            child: AppBar(
              elevation: 0,
              backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
              leading: BackButton(
                  color: ColorUtil().getColor(context, ColorEnums.textTitleLight)
              ),
              title: Text("leadReport".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              bottom: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                labelStyle: CustomTextStyle().semiBold12(AppColors.wizzColor),
                unselectedLabelStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                indicatorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                labelColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                unselectedLabelColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                tabs:  [
                  Tab(child: Text("lastMonth".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab(child: Text("today".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab(child: Text("weekly".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab(child: Text("monthly".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab(child: Text("annual".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab( child: Text("total".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),

                ],
              ),
            ),
          ),
          body: Container(
            color: ColorUtil().getColor(context, ColorEnums.background),
            child: const TabBarView(
              children: [
                LastMonthlyLeadChart(),
                TodayLeadReport(),
                WeeklyLeadChart(),
                MonthlyLeadChart(),
                AnnualLeadChart(),
                LeadsDetails(),
              ],
            ),
          ),

        ),
      ),
    );
  }

}
