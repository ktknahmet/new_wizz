import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/demoModel/liveDemoList.dart';
import 'package:wizzsales/model/quickSaleModel/quickSaleModel.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/LiveDemoVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class CompleteDemo extends BaseStatefulPage {
  const CompleteDemo(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _CompleteDemoState();
}

class _CompleteDemoState extends BaseStatefulPageState<CompleteDemo>{
  LiveDemoVm viewModel = LiveDemoVm();
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
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<LiveDemoVm>(
        builder: (context,value,_){
          if(viewModel.demoList == null){
            return spinKit(context);
          }else if(viewModel.demoList!.isNotEmpty){
            return  SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        onChanged: (value){
                          viewModel.setQuery(value);

                          viewModel.searchDemos(viewModel.demoList!,viewModel.query);
                        },
                        decoration: searchTextDesign(context, "search"),
                        cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                      ),
                    ),
                  ),
                  RawScrollbar(
                    thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                    thumbVisibility: true,
                    thickness: 1,
                    trackVisibility: true,
                    controller: controller,
                    child: RefreshIndicator(
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      onRefresh: getList,
                      child: SizedBox(
                        height: justList(context, sizeWidth(context).height),
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.searchDemos(viewModel.demoList!,viewModel.query).length,
                          itemBuilder: (context,index){
                            LiveDemoList item =viewModel.searchDemos(viewModel.demoList!,viewModel.query)[index];
                            return Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    if(item.sale !=null)
                                     Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("dealerName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          Text(item.sale!.cname ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],
                                      ),

                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("prospectCustomer".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text("${item.demoCustomerName ?? ""} ${item.demoCustomerSurname ?? ""}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    if(item.demoCustomerPhone !=null)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("phone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.demoCustomerPhone ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    if(item.demoCustomerEmail !=null)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("email".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.demoCustomerEmail ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("address".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.demoAddress ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("state".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.demoState ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("zipCode".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.demoZipcode ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("demoStartDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(mmDDYDateTime(item.demoStartTime.toString()),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    if(item.demoEndTime !=null)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("demoEndTime".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          Text(calculateTimeDifference(item.demoStartTime.toString(),item.demoEndTime),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],
                                      ),

                                    const SizedBox(height: 4,),
                                     if(item.saleId !=null)
                                     Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("enterSerialNumber".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                           Text(item.sale!.serialid ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                         ],
                                       ),


                                      Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text("demoStatus".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             Text(item.status!,style:demoStatusStyle(context,item.status!),)
                                           ],
                                      ),
                                    const SizedBox(height: 4,),
                                     Divider(
                                       thickness: 2,
                                       color: demoDivider(context,item.status!),
                                    ),

                                    if(item.questions!.isNotEmpty)
                                      Column(
                                        children: [
                                          Text("question".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: SizedBox(
                                              height: sizeWidth(context).height*0.08,
                                              child: ListView.builder(
                                                itemCount:item.questions!.length ,
                                                itemBuilder: (context,index){
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width:sizeWidth(context).width*0.70,
                                                            child:Text(item.questions![index].question![0].questionText!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Text(item.questions![index].answerText!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),

                                                      const SizedBox(height: 4,),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4,),
                                          if(item.reasons!.isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Column(
                                                children: [
                                                  Text("reasons".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                  Wrap(
                                                    direction: Axis.horizontal, // Yatay yönde wrap et
                                                    alignment: WrapAlignment.start, // Başlangıçtan başla
                                                    children: item.reasons!.asMap().entries.map((entry) {
                                                      int index = entry.key;
                                                      bool isLast = index == item.reasons!.length - 1; // Son elemanı belirle

                                                      return  Text(
                                                        "${entry.value.reasonType![0].reasonType!}${isLast ? '' : ' , '}", // Son elemandaysa virgül ekleme
                                                        style: CustomTextStyle().bold12(
                                                          ColorUtil().getColor(context, ColorEnums.textDefaultLight),
                                                        ),

                                                      );
                                                    }).toList(),
                                                  ),

                                                ],
                                              ),
                                            ),
                                        ],
                                      ),

                                    const SizedBox(height: 4,),
                                    Visibility(
                                      visible: item.status=="Demo Completed" ? true :false,
                                      child: SizedBox(
                                        width:sizeWidth(context).width*0.80,
                                        child: ElevatedButton(
                                            onPressed: ()async{
                                              await registerSale(item.demoLiveId!,index);

                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("registerAddSale".tr(),style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: item.isLive==true ? true :false,
                                      child: SizedBox(
                                        width:sizeWidth(context).width*0.80,
                                        child: ElevatedButton(
                                          onPressed: ()async{
                                            await completeDemo(item.demoLiveId!,index);
                                          },
                                            style: elevatedButtonStyle(context),
                                            child: Text("completeDemo".tr(),style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }else{
            return emptyView(context, "youDoNotHaveDemo");
          }
        },
      ),
    );
  }
  Future<void>getList() async{
   await viewModel.getDemoList(context);
  }
  registerSale(int id,int index)async{
    Map<String, dynamic> phoneType = {};
    phoneType = smashPhoneNumber(viewModel.demoList![index].demoCustomerPhone ?? "");
    QuickSaleModel model = QuickSaleModel(
      id,
      viewModel.demoList![index].demoCustomerName,
      viewModel.demoList![index].demoCustomerName,
      viewModel.demoList![index].demoCustomerSurname,
      "${phoneType["cCode"]}${phoneType["phone"]}",
      viewModel.demoList![index].demoCustomerEmail,
      phoneType["cCode"],
      viewModel.demoList![index].demoAddress,
      viewModel.demoList![index].demoCounty,
      viewModel.demoList![index].demoCountry,
      viewModel.demoList![index].demoState,
      viewModel.demoList![index].demoCity,
      viewModel.demoList![index].demoZipcode,
      viewModel.demoList![index].leadType!.leadtypeid

    );
    Navigator.pushNamed(context, '/${PageName.quickAddSale}',arguments: {'quick':model,'demoId':id});
  }
  completeDemo(int id,int index)async{
    //status 1 ise yes 0 ise no cevabı
     bool? check = await showQuestions(context);

     if(check !=null){
       int status = check ? 1 :0;
       await viewModel.finishDemo(context,status,id);
       await viewModel.getDemoList(context);

       if(viewModel.demoQuestions !=null){
         if(check){
           Map<String, dynamic> phoneType = {};
           phoneType = smashPhoneNumber(viewModel.demoList![index].demoCustomerPhone ?? "");
           QuickSaleModel model = QuickSaleModel(
               id,
               viewModel.demoList![index].demoCustomerName,
               viewModel.demoList![index].demoCustomerName,
               viewModel.demoList![index].demoCustomerSurname,
               "${phoneType["cCode"]}${phoneType["phone"]}",
               viewModel.demoList![index].demoCustomerEmail,
               phoneType["cCode"],
               viewModel.demoList![index].demoAddress,
               viewModel.demoList![index].demoCounty,
               viewModel.demoList![index].demoCountry,
               viewModel.demoList![index].demoState,
               viewModel.demoList![index].demoCity,
               viewModel.demoList![index].demoZipcode,
               viewModel.demoList![index].leadType!.leadtypeid

           );
           Navigator.pushNamed(context, '/${PageName.quickAddSale}',arguments: {'quick':model,'demoId':id});
           //Navigator.pushNamed(context, '/${PageName.addSale}',arguments: {'demoId':id});
         }else{
           Navigator.pushNamed(context, '/${PageName.demoDetails}',arguments:{'question': viewModel.demoQuestions,'demoId':id} );

         }
       }
     }

  }
}
