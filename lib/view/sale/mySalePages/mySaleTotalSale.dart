import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Sale.dart';
import 'package:wizzsales/model/salesChart/totalSale.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SalelistMobx.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../document/saleDocument.dart';

class MySaleTotalSale extends StatefulWidget {
  final List<Sale> sale;
  const MySaleTotalSale(this.sale,{super.key});

  @override
  State<MySaleTotalSale> createState() => _MySaleTotalSaleState();
}

class _MySaleTotalSaleState extends State<MySaleTotalSale> {
  SaleOfficeMobx saleOfficeMobx = SaleOfficeMobx();
  List<TotalSale> chartData =[];
  ScrollController controller = ScrollController();
  @override
  void initState() {
    getTotalSale();
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Observer(
            builder: (_){
              if(saleOfficeMobx.myOfficeTotal ==null){
                return spinKit(context);
              }else{
                return Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(seconds:2),
                      delay:const Duration(seconds:1),
                      child: SizedBox(
                        height: sizeWidth(context).height*0.30,
                        child:SfCartesianChart(
                              plotAreaBorderColor: ColorUtil().getColor(context, ColorEnums.transparant),
                                isTransposed: true,
                                tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                    textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                    color: ColorUtil().getColor(context, ColorEnums.background)
                                ),
                                legend: Legend(
                                    textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textTitleLight)),
                                    isVisible: true,
                                    iconWidth: 8,
                                    isResponsive:true,
                                    alignment: ChartAlignment.near
                                ),
                              series : [
                                BarSeries<TotalSale, String>(
                                  color: ColorUtil().getColor(context,ColorEnums.wizzColor),
                                  enableTooltip: true,
                                  width: 0.3,
                                  name: "mySales".tr(),
                                  borderRadius:const BorderRadius.only(
                                      topRight: Radius.circular(4),bottomRight: Radius.circular(4)),
                                  dataSource:  chartData,
                                  xValueMapper: (TotalSale data,_) => data.key.tr(),
                                  yValueMapper: (TotalSale data,_) => data.value,
                                  dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight))
                                  ),
                                ),
                              ],
                              primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                                labelStyle:CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)) ,
                              ),
                              primaryYAxis: NumericAxis(
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                labelStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                majorGridLines: const MajorGridLines(width: 0),
                                interval: 1,
                              ),

                            )

                      ),
                    ),
                    const SizedBox(height: 8,),
                    if(widget.sale.isNotEmpty )
                    Column(
                      children: [
                        RawScrollbar(
                          controller: controller,
                          thumbVisibility: true,
                          thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          thickness: 1,
                          child: SizedBox(
                            height: sizeWidth(context).height*0.40,
                            child: ListView.builder(
                                controller: controller,
                                itemCount: widget.sale.length >5 ? 5 : widget.sale.length,
                                itemBuilder: (context,index) {
                                  Sale item = widget.sale[index];


                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          shape: cardShape(context),
                                          color: ColorUtil().getColor(context, ColorEnums.background),
                                          elevation: 2,
                                          child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("# ${item.serialid}",
                                                        style: CustomTextStyle().bold18(
                                                            ColorUtil().getColor(
                                                                context, ColorEnums.textTitleLight)),),

                                                    ],
                                                  ),
                                                  const SizedBox(height: 4,),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.location_on_outlined,
                                                        color: ColorUtil().getColor(
                                                            context, ColorEnums.wizzColor),),
                                                      const SizedBox(width: 4,),
                                                      Text(item.caddress!,
                                                        style: CustomTextStyle().semiBold12(
                                                            ColorUtil().getColor(
                                                                context, ColorEnums.textTitleLight)),),
                                                      Text(item.office ?? "",
                                                        style: CustomTextStyle().semiBold12(
                                                            ColorUtil().getColor(
                                                                context, ColorEnums.textTitleLight)),),

                                                    ],
                                                  ),
                                                  const SizedBox(height: 8,),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.date_range, color: ColorUtil().getColor(
                                                          context, ColorEnums.wizzColor),),
                                                      const SizedBox(width: 4,),
                                                      Text(DateFormat('yMMMd').format(
                                                          DateTime.parse(item.date!)),
                                                        style: CustomTextStyle().semiBold12(
                                                            ColorUtil().getColor(
                                                                context, ColorEnums.textTitleLight)),),
                                                      Text(item.office ?? "",
                                                        style: CustomTextStyle().semiBold12(
                                                            ColorUtil().getColor(
                                                                context, ColorEnums.textTitleLight)),),
                                                      const SizedBox(width: 8,),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.person, color: ColorUtil().getColor(
                                                              context, ColorEnums.wizzColor),),
                                                          const SizedBox(width: 4,),
                                                          Text(item.cname!,
                                                            style: CustomTextStyle().semiBold12(
                                                                ColorUtil().getColor(
                                                                    context, ColorEnums.textTitleLight)),),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: ColorUtil().getColor(
                                                        context, ColorEnums.wizzColor),
                                                  ),
                                                  const SizedBox(height: 8,),
                                                  Wrap(
                                                      children: [
                                                        Wrap(
                                                          children: [
                                                            if(item.distributor != null && item.distributor!.name !=null)
                                                              Column(
                                                                children: [
                                                                  Text("DST",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                  const SizedBox(height: 4,),
                                                                  Text(item.distributor!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                                ],
                                                              ),

                                                            const SizedBox(width: 8,),
                                                            if(item.sm != null && item.sm!.name !=null)
                                                              Column(
                                                                children: [
                                                                  Text("SM",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                  const SizedBox(height: 4,),
                                                                  Text(item.sm!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                                ],
                                                              ),

                                                            const SizedBox(width: 8,),
                                                            if(item.dps != null && item.dps!.name !=null)
                                                              Column(
                                                                children: [
                                                                  Text("DPS",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                  const SizedBox(height: 4,),
                                                                  Text(item.dps!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                                ],
                                                              ),

                                                            const SizedBox(width: 8,),
                                                            if(item.leader != null && item.leader!.name !=null)
                                                              Column(
                                                                children: [
                                                                  Text("TL",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                  const SizedBox(height: 4,),
                                                                  Text(item.leader!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                                ],
                                                              ),

                                                            const SizedBox(width: 8,),
                                                            if(item.dealer != null && item.dealer!.name !=null)
                                                              Column(
                                                                children: [
                                                                  Text("DL",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                  const SizedBox(height: 4,),
                                                                  Text(item.dealer!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                                ],
                                                              ),
                                                            const SizedBox(width: 8,),
                                                            if(item.da != null && item.da!.name !=null)
                                                              Column(
                                                                children: [
                                                                  Text("DA",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                  const SizedBox(height: 4,),
                                                                  Text(item.da!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                                ],
                                                              ),

                                                          ],
                                                        ),
                                                      ]
                                                  ),
                                                  if(item.status==1)
                                                    const SizedBox(height: 8,),
                                                  Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap:(){

                                                          Navigator.pushNamed(context, '/${PageName.saleDetails}',arguments: {"sale":item});

                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text("seeDocuments".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                            Icon(Icons.arrow_right,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (_) => SaleDocument(item.id!)));

                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text("addDocuments".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                            Icon(Icons.arrow_right,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              )
                                          ),
                                        ),
                                      ),


                                    ],

                                  );
                                }
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            selectMySaleType(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("seeMore".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              const SizedBox(width: 4,),
                              Icon(Icons.arrow_right,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
            },
          ),
    );
  }
  Future<void>getTotalSale() async{
    await saleOfficeMobx.myTotalSale(context);
    if(saleOfficeMobx.myOfficeTotal !=null){
      TotalSale totalSale = TotalSale("today",saleOfficeMobx.myOfficeTotal![0]!.dasales!);
      TotalSale totalSale1 = TotalSale("weekly",saleOfficeMobx.myOfficeTotal![0]!.wasales!);
      TotalSale totalSale2 = TotalSale("monthly",saleOfficeMobx.myOfficeTotal![0]!.masales!);
      TotalSale totalSale3 = TotalSale("annual",saleOfficeMobx.myOfficeTotal![0]!.yasales!);

      print("veriler :${saleOfficeMobx.myOfficeTotal![0]!.masales!}");
      chartData.add(totalSale);
      chartData.add(totalSale1);
      chartData.add(totalSale2);
      chartData.add(totalSale3);
    }

  }
}