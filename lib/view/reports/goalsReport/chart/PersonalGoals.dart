import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/leadReportModel/demoLeadReportModel.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/HomeVm.dart';
import 'package:wizzsales/widgets/Constant.dart';

import '../../../../constants/colorsUtil.dart';
import '../../../../widgets/WidgetExtension.dart';

class PersonalGoals extends StatefulWidget {
  const PersonalGoals({super.key});

  @override
  State<PersonalGoals> createState() => _PersonalGoalsState();
}

class _PersonalGoalsState extends State<PersonalGoals> {
  HomeVm viewModel = HomeVm();
  LoginUser? loginUser;
  List<DemoLeadReportModel> leadModel=[];

  @override
  void initState() {
    getList(viewModel.type);
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<HomeVm>(
        builder: (context,value,_){
          if(viewModel.detailsReportModel == null){
            return spinKit(context);
          }else{
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(

                    decoration: containerDecoration(context),
                    width: sizeWidth(context).width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                        underline: const SizedBox(),
                        hint: Row(
                          children: [
                            Text(viewModel.type,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ],
                        ),
                        value: viewModel.type,
                        onChanged: (newValue) async{
                          viewModel.setType(newValue!);
                          await getList(viewModel.type);
                        },
                        items: chooseType.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,

                            child: Row(
                              children: [
                                Text(value,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  if (leadModel.isEmpty) spinKit(context) else SizedBox(
                      height: sizeWidth(context).height*0.70,
                      child:  FadeInUp(
                        duration: const Duration(seconds:2),
                        delay:const Duration(seconds:1),
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child:SfCartesianChart(
                           plotAreaBorderColor: ColorUtil().getColor(context, ColorEnums.transparant),
                           isTransposed: true,
                                  tooltipBehavior: TooltipBehavior(
                                  enable: true,
                                  textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                  color: ColorUtil().getColor(context, ColorEnums.background)
                                  ),
                              legend:  Legend(
                                  textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                  isVisible: true,
                                  overflowMode: LegendItemOverflowMode.wrap
                              ),
                              series: [
                                BarSeries<DemoLeadReportModel,String>(
                                  width: 0.2,
                                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                  name: viewModel.type,
                                  enableTooltip: true,
                                  dataSource: leadModel,
                                  xValueMapper: (DemoLeadReportModel data,_) => data.name.tr(),
                                  yValueMapper: (DemoLeadReportModel data,_) => data.value,
                                  dataLabelSettings: DataLabelSettings(
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      isVisible: true,
                                      textStyle: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight))
                                  ),
                                )
                              ],
                                  primaryXAxis: CategoryAxis(
                                  labelRotation: -75,
                                  majorGridLines: const MajorGridLines(width: 0),
                                  labelStyle:CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                  ),
                                  primaryYAxis: NumericAxis(
                                  interval: 1,
                                  majorGridLines: const MajorGridLines(width: 0),
                                  labelStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                  ),
                            )
                        ),
                      ),

                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  Future<void> getList(String leadType)async{
    SharedPref pref = SharedPref();
    int index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    leadModel.clear();
    await viewModel.detailReport(context, loginUser!.profiles![index].id!, loginUser!.profiles![index].organisation_id!);
    if(viewModel.detailsReportModel !=null){
      if(viewModel.type =="daily".tr()){
        leadModel.add(DemoLeadReportModel("leads", viewModel.detailsReportModel!.userGoals![0].leads ?? 0));
        leadModel.add(DemoLeadReportModel("appointmentSet", viewModel.detailsReportModel!.userGoals![0].appointments ?? 0));
        leadModel.add(DemoLeadReportModel("demoRun",viewModel.detailsReportModel!.userGoals![0].demos ?? 0));
        leadModel.add(DemoLeadReportModel("estimated",viewModel.detailsReportModel!.userGoals![0].estimated ?? 0));

      }
      if(viewModel.type =="weekly".tr()){
        leadModel.add(DemoLeadReportModel("leads", viewModel.detailsReportModel!.userGoals![1].leads ?? 0));
        leadModel.add(DemoLeadReportModel("appointmentSet", viewModel.detailsReportModel!.userGoals![1].appointments ?? 0));
        leadModel.add(DemoLeadReportModel("demoRun",viewModel.detailsReportModel!.userGoals![1].demos ?? 0));
        leadModel.add(DemoLeadReportModel("estimated",viewModel.detailsReportModel!.userGoals![1].estimated ?? 0));

      }
      if(viewModel.type =="monthly".tr()){
        leadModel.add(DemoLeadReportModel("leads", viewModel.detailsReportModel!.userGoals![2].leads ?? 0));
        leadModel.add(DemoLeadReportModel("appointmentSet", viewModel.detailsReportModel!.userGoals![2].appointments ?? 0));
        leadModel.add(DemoLeadReportModel("demoRun",viewModel.detailsReportModel!.userGoals![2].demos ?? 0));
        leadModel.add(DemoLeadReportModel("estimated",viewModel.detailsReportModel!.userGoals![2].estimated ?? 0));

      }
    }
  }
}

