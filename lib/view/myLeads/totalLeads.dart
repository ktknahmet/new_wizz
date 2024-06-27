import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/leadReport/LeadReport.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/AddAppBar.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/MyLeadVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../utils/style/CustomTextStyle.dart';

class TotalLeads extends StatefulWidget {
  const TotalLeads({super.key});

  @override
  State<StatefulWidget> createState() => _TotalLeadsState();
}

class _TotalLeadsState extends State<TotalLeads> {
  MyLeadVm viewModel = MyLeadVm();
  ScrollController controller = ScrollController();
  @override
  void initState() {
    getList();
    super.initState();
  }

   @override
  void dispose() {
    deactivate();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: AddAppBar(
        name: "myLeads".tr(),
        func: ()  {
          Navigator.pushNamed(context, '/${PageName.leadsAppointment}');
        },
      ),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<MyLeadVm>(
            builder: (context, value, _) {
              if (viewModel.leadReports == null) {
                return spinKit(context);
              }else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: sizeWidth(context).height*0.08,
                          child:  ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context,index){
                              return SizedBox(
                                width: sizeWidth(context).width*0.32,
                                child: Card(
                                      elevation: 2,
                                      shape: cardShape(context),
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(viewModel.leadReportName(index),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                            Text(viewModel.leadReportValue(index,viewModel.leadReports!,viewModel.leadType).toString(),style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                          ],
                                        ),
                                      )

                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          height: 40,
                          decoration: containerDecoration(context),
                          width: sizeWidth(context).width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                               isExpanded: true,
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

                              },
                              items: viewModel.chooseLead.map((value) {
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
                        SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:40,
                                width: sizeWidth(context).width*0.60,
                                child: TextField(
                                  onChanged: (value) {
                                    viewModel.setQuery(value);
                                    viewModel.searchLead(viewModel.leadReports!, viewModel.query);
                                  },
                                  decoration: searchTextDesign(context, "search"),
                                  cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                                ),
                              ),
                              const SizedBox(width: 16,),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, '/${PageName.totalLeadsReport}');
                                    },
                                    style: elevatedButtonStyle(context),
                                    child: Text("report".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ),
                              ),


                            ],
                          ),
                        ),
                        RefreshIndicator(
                          onRefresh: getList,
                          color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          child: SizedBox(
                            height: justList(context, sizeWidth(context).height),
                            child: RawScrollbar(
                              thumbColor: ColorUtil().getColor(
                                  context, ColorEnums.wizzColor),
                              thumbVisibility: true,
                              thickness: 1,
                              trackVisibility: true,
                              controller: controller,
                              child: ListView.builder(
                                controller: controller,
                                itemCount: viewModel.searchLead(viewModel.leadReports!, viewModel.leadType).length,
                                itemBuilder: (context, index) {
                                  LeadReport item = viewModel.searchLead(viewModel.leadReports!, viewModel.leadType)[index];
                                  return Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(
                                        context, ColorEnums.background),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: sizeWidth(context).width * 0.30,
                                                  child: Text("leadType".tr(), style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.lead_type_name ?? "", style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: sizeWidth(context).width * 0.50,
                                                  child: Text("totalLeadCount".tr(),
                                                    style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text("${item.leads!.length}",
                                                        style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                    ],
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: sizeWidth(context).width * 0.50,
                                                  child: Text("appointmentSet".tr(),
                                                    style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text("${item.appointment_set_count ?? 0}",
                                                        style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                    ],
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: sizeWidth(context).width * 0.30,
                                                  child: Text("notContacted".tr(),
                                                    style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text("${item.not_contacted_lead_count ?? 0}",
                                                        style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                    ],
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: sizeWidth(context).width * 0.30,
                                                  child: Text("sold".tr(),
                                                    style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text("${item.sold_count ?? 0}",
                                                        style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                    ],
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(height: 4,),
                                          Divider(
                                            thickness: 1,
                                            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                          ),
                                          if(item.leads!.isNotEmpty)
                                            GestureDetector(
                                              onTap: (){
                                              Navigator.pushNamed(context, '/${PageName.leadDetails}', arguments: {'detail': item.leads!},);

                                               },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: sizeWidth(context).width * 0.50,
                                                child: Text("leadDetails".tr(),
                                                  style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.wizzColor)),)),
                                            Expanded(
                                              child: Column(

                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Icon(Icons.arrow_forward,color: ColorUtil().getColor(context, ColorEnums.wizzColor),)
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          const SizedBox(height: 4,),

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  Future<void>getList()async{
    await viewModel.allLeadReport(context);
    if(viewModel.leadReports !=null){
      viewModel.chooseLead.clear();
      viewModel.chooseLead.add("All");
      for(int i =0;i<viewModel.leadReports!.length;i++){
        viewModel.chooseLead.add(viewModel.leadReports![i].lead_type_name!);
      }

    }
  }
}
