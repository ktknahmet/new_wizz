import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/leadReportModel/demoLeadReportModel.dart';
import 'package:wizzsales/model/leadReportModel/leadReportModel.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SalelistMobx.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class LeadsDetails extends StatefulWidget {
  const LeadsDetails({super.key});

  @override
  State<LeadsDetails> createState() => _LeadsDetailsState();
}

class _LeadsDetailsState extends State<LeadsDetails> {
  SaleOfficeMobx mobx = SaleOfficeMobx();
  String leadType="Appointment Set";

  List<DemoLeadReportModel> leadModel=[];
  int total=0;
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  void initState() {
    getReport();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Observer(
        builder: (_){
          if(mobx.leadReports ==null){
            return spinKit(context);
          }else{
            return Column(
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
                          Text(leadType,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          const SizedBox(width: 8,),

                        ],
                      ),
                      value: leadType,
                      onChanged: (newValue) async{
                        setState(() {
                          leadType = newValue!;
                        });
                        await getReport();
                      },
                      items: leadDetails.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
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
                              name: leadType,
                              dataSource: leadModel,
                              xValueMapper: (DemoLeadReportModel chart,_) => chart.name,
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
            );
          }
        },
      ),
    );
  }
  getReport() async{
    await mobx.allLeadReport(context);
    if(mobx.leadReports !=null){
        total=0;
        leadModel.clear();
        for(int i=0;i<mobx.leadReports!.length;i++){
          switch(leadType){
            case "Sold":
              total = total+mobx.leadReports![i]!.soldCount!;
              leadModel.add(DemoLeadReportModel(mobx.leadReports![i]!.leadTypeName!, mobx.leadReports![i]!.soldCount!));
              break;
            case "Appointment Set":
              total = total+mobx.leadReports![i]!.aptSetCount!;
              leadModel.add(DemoLeadReportModel(mobx.leadReports![i]!.leadTypeName!, mobx.leadReports![i]!.aptSetCount!));
              break;
            case "Not Contacted":
              total = total+mobx.leadReports![i]!.notContacted!;
              leadModel.add(DemoLeadReportModel(mobx.leadReports![i]!.leadTypeName!, mobx.leadReports![i]!.notContacted!));
              break;
          }
        }
        leadModel.add(DemoLeadReportModel("Total", total));

        print("toplam :$total");


    }
  }
}
