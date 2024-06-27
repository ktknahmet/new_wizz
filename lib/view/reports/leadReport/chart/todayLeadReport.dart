import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/leadReportModel/demoLeadReportModel.dart';
import 'package:wizzsales/model/leadReportModel/leadReportModel.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/HomeVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class TodayLeadReport extends StatefulWidget {
  const TodayLeadReport({super.key});

  @override
  State<TodayLeadReport> createState() => _TodayLeadReportState();
}

class _TodayLeadReportState extends State<TodayLeadReport> {
  HomeVm viewModel = HomeVm();

  LoginUser? loginUser;

  List<DemoLeadReportModel> leadModel=[];
  List<String> chooseLead=[];
  dynamic total=0;
  @override
  void initState() {
    getList(viewModel.leadType);
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
                            Text(viewModel.leadType,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ],
                        ),
                        value: viewModel.leadType,
                        onChanged: (newValue) async{
                          viewModel.setLeadType(newValue!);
                          await getList(viewModel.leadType);
                        },
                        items: chooseLead.map((value) {
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
                  leadModel.isEmpty ? spinKit(context) :
                  SizedBox(
                      height: sizeWidth(context).height*0.70,
                      child:SfCartesianChart(
                        isTransposed: false,
                        tooltipBehavior: TooltipBehavior(
                            enable: true,
                            textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            color: ColorUtil().getColor(context, ColorEnums.background)
                        ),
                        legend: Legend(
                            textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textTitleLight)),
                            isVisible: true,
                            alignment: ChartAlignment.far
                        ),
                        series: [
                          BarSeries<DemoLeadReportModel,String>(
                            width: 0.3,
                            borderRadius:const BorderRadius.only(topRight: Radius.circular(4),bottomRight: Radius.circular(4)),
                            color: ColorUtil().getColor(context,ColorEnums.wizzColor),
                            enableTooltip: true,
                            name: viewModel.leadType,
                            dataSource: leadModel,
                            xValueMapper: (DemoLeadReportModel chart,_) => chart.name.tr(),
                            yValueMapper: (DemoLeadReportModel chart,_) => chart.value,
                            dataLabelSettings: DataLabelSettings(

                                isVisible: true,
                                textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))
                            ),
                          )
                        ],
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          labelStyle:CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)) ,
                        ),
                        primaryYAxis: NumericAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          labelStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                          maximum: 10,
                          majorGridLines: const MajorGridLines(width: 0),

                        ),
                      )
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
    chooseLead.clear();
    leadModel.clear();
    await viewModel.detailReport(context, loginUser!.profiles![index].id!, loginUser!.profiles![index].organisation_id!);
    if(viewModel.detailsReportModel !=null){
      for(int i =0;i<viewModel.detailsReportModel!.leadsReport!.leadReports!.length;i++){
        chooseLead.add(viewModel.detailsReportModel!.leadsReport!.leadReports![i].leadTypeName!);
      }
      for(int i =0;i<viewModel.detailsReportModel!.leadsReport!.leadReports!.length;i++){
        if(chooseLead[i]==leadType){
          dynamic sold = viewModel.detailsReportModel!.leadsReport!.leadReports![i].daliySold ?? 0;
          dynamic appointment = viewModel.detailsReportModel!.leadsReport!.leadReports![i].daliyAppointmentSet ?? 0;
          dynamic notContacted =viewModel.detailsReportModel!.leadsReport!.leadReports![i].daliyNotContacted ?? 0;
          total = appointment+sold+notContacted;
          leadModel.add(DemoLeadReportModel("appointmentSet", viewModel.detailsReportModel!.leadsReport!.leadReports![i].daliyAppointmentSet ?? 0));
          leadModel.add(DemoLeadReportModel("sold", viewModel.detailsReportModel!.leadsReport!.leadReports![i].daliySold ?? 0));
          leadModel.add(DemoLeadReportModel("notContacted",viewModel.detailsReportModel!.leadsReport!.leadReports![i].daliyNotContacted ?? 0));
          leadModel.add(DemoLeadReportModel("total", total));
        }
      }
    }
  }
}
