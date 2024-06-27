import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/MyLeadVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../model/OLD/leadReport/Lead.dart';

class LeadDetails extends StatefulWidget {
  final List<Lead> lead;
  const LeadDetails(this.lead,{super.key});

  @override
  State<LeadDetails> createState() => _LeadDetailsState();
}

class _LeadDetailsState extends State<LeadDetails> {
  ScrollController controller = ScrollController();
  MyLeadVm viewModel = MyLeadVm();
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(name: "leadDetails".tr(),),
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<MyLeadVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Total : ${widget.lead.length}",style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    SizedBox(
                      height:40,
                      width: sizeWidth(context).width*0.80,
                      child: TextField(
                        onChanged: (value) {
                          viewModel.setQuery(value);
                          viewModel.searchLeadDetails(widget.lead, viewModel.query);
                        },
                        decoration: searchTextDesign(context, "search"),
                        cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                      ),
                    ),
                    RawScrollbar(
                      thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      thumbVisibility: true,
                      thickness: 3,
                      trackVisibility: true,
                      controller: controller,
                      child: SizedBox(
                        height: sizeWidth(context).height*0.8,
                        child: ListView.builder(
                          itemCount: viewModel.searchLeadDetails(widget.lead, viewModel.query).length,
                          controller: controller,
                          itemBuilder: (context,index){
                            Lead item =viewModel.searchLeadDetails(widget.lead, viewModel.query)[index];
                            int startIndex = (viewModel.searchLeadDetails(widget.lead, viewModel.query).length == 1) ? 1 : viewModel.searchLeadDetails(widget.lead, viewModel.query).length;
                            List<int> indices = List.generate(viewModel.searchLeadDetails(widget.lead, viewModel.query).length, (index) => startIndex - index);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: cardShape(context),
                                color: ColorUtil().getColor(context,ColorEnums.background),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("${indices[index]}",style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width:sizeWidth(context).width*0.30,
                                              child: Text("cName".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.cname ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ))
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width:sizeWidth(context).width*0.30,
                                              child: Text("date".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(mmDDYDate(item.date ?? ""),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ))
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width:sizeWidth(context).width*0.30,
                                              child: Text("cPhone".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.cphone ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ))
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width:sizeWidth(context).width*0.30,
                                              child: Text("cEmail".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.cemail ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ))
                                        ],
                                      ),const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width:sizeWidth(context).width*0.30,
                                              child: Text("address".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.caddress ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ))
                                        ],
                                      ),

                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width:sizeWidth(context).width*0.30,
                                              child: Text("city".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.ccity ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ))
                                        ],
                                      ),

                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width:sizeWidth(context).width*0.30,
                                              child: Text("leadType".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.leadtypename!,style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ))
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width:sizeWidth(context).width*0.30,
                                              child: Text("status".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(statusCase(item.status!),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ))
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      if(item.gift !=null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.30,
                                                child: Text("gift".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(item.gift ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                              ],
                                            ))
                                          ],
                                        ),
                                      const SizedBox(height: 4,),
                                      if(item.referredby!.isNotEmpty)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.30,
                                                child: Text("referredBy".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(item.referredby ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                              ],
                                            ))
                                          ],
                                        ),
                                      const SizedBox(height: 4,),
                                      Divider(
                                        thickness: 1,
                                        color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                      ),
                                      const SizedBox(height: 4,),

                                      if (item.answers!.isNotEmpty)
                                        Column(
                                          children: [
                                            Text("questions".tr(),style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            const SizedBox(height: 8,),
                                            SizedBox(
                                              height: sizeWidth(context).height*0.20,
                                              child: ListView.builder(
                                                itemCount: item.answers!.length,
                                                itemBuilder: (context,index){
                                                  return  Column(
                                                    children: [
                                                      if (item.answers![index]?.question != null)
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                                width:sizeWidth(context).width*0.30,
                                                                child: Text("question".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                                            Expanded(child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Text(item.answers![index]!.question!.question ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                              ],
                                                            ))
                                                          ],
                                                        ),
                                                      const SizedBox(height: 2,),
                                                      if (item.answers![index]?.question != null)
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                                width:sizeWidth(context).width*0.30,
                                                                child: Text("answer".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                                            Expanded(child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Text(item.answers![index]!.answer ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                              ],
                                                            ))
                                                          ],
                                                        ),
                                                      const SizedBox(height: 2,),
                                                      Divider(
                                                        thickness: 1,
                                                        color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                      ),
                                                      const SizedBox(height: 2,),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      SizedBox(
                                        width:sizeWidth(context).width*0.9,
                                        child: ElevatedButton(
                                            onPressed: ()async{
                                               if(viewModel.leadStatusList == null){
                                                 showProgress(context, true);
                                                 await viewModel.getLeadStatus(context);
                                                 showProgress(context, false);
                                                 selectLeadStatus(context,viewModel,item.id!);
                                               }else{
                                                 selectLeadStatus(context,viewModel,item.id!);
                                               }
                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("updateStatus".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
        ),

    );
  }
}
