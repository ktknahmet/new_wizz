import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionWinner.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPost.dart';
import 'package:wizzsales/adminPage/adminVm/commissionVm.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/SettingsAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../constants/colorsUtil.dart';

class CommissionPage extends StatefulWidget {
  const CommissionPage({super.key});

  @override
  State<StatefulWidget> createState() => _CommissionPageState();
}

class _CommissionPageState extends State<CommissionPage> {
  CommissionVm viewModel = CommissionVm();
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
     backgroundColor: ColorUtil().getColor(context,ColorEnums.background),
     appBar: SettingsAppBar(
       name: "commission".tr(),
       func: () {
         Navigator.pushNamed(context, '/${PageName.commissionSettings}');
       },
     ),
     body: ChangeNotifierProvider.value(
       value: viewModel,
       child: Consumer<CommissionVm>(
         builder: (context,value,_){
           if(viewModel.comDetails == null || viewModel.loginUser == null || viewModel.getPayPeriod == null){
             return spinKit(context);
           }else{
             return  SizedBox(
                 width: sizeWidth(context).width,
                 height: sizeWidth(context).height,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: SingleChildScrollView(
                     child: Column(
                       children: [
                         Text(viewModel.loginUser!.profiles![viewModel.index].orgname!, style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                         Text("commissionSummary".tr(), style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                    
                         Align(
                               alignment: Alignment.centerRight,
                               child: GestureDetector(
                                 onTap: ()async{
                                   showProgress(context, true);
                                   await getList();
                                   showProgress(context, false);
                                 },
                                 child: Icon(Icons.refresh,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                               ),
                             ),
                         Container(
                           decoration: BoxDecoration(
                               color: Colors.black87,
                               border: Border.all(color: ColorUtil().getColor(context,ColorEnums.wizzColor), width: 1),
                               borderRadius: BorderRadius.circular(15)),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     GestureDetector(
                                       onTap: (){
                                         viewModel.setPaidUnPaidCom(0);
                                       },
                                       child:  Container(
                                         color:viewModel.currentDay=="daily".tr() ? AppColors.grey :Colors.transparent,
                                         height: 30,
                                         child: Padding(
                                           padding: const EdgeInsets.only(left: 2,right: 2),
                                           child: Align(
                                             alignment: Alignment.center,
                                             child: Text("daily".tr(), style: CustomTextStyle().bold10(AppColors.white)
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                     GestureDetector(
                                       onTap: (){
                                         viewModel.setPaidUnPaidCom(1);
                                       },
                                       child:  Container(
                                         color:viewModel.currentDay=="payWeek".tr() ? AppColors.grey :Colors.transparent,
                                         height: 30,
                                         child: Padding(
                                           padding: const EdgeInsets.only(left: 2,right: 2),
                                           child: Align(
                                             alignment: Alignment.center,
                                             child: Text("payWeek".tr(), style:
                                             CustomTextStyle().bold10(AppColors.white)
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                     GestureDetector(
                                       onTap: (){
                                         viewModel.setPaidUnPaidCom(2);
                                       },
                                       child:  Container(
                                         color:viewModel.currentDay=="monthly".tr() ? AppColors.grey :Colors.transparent,
                                         height: 30,
                                         child: Padding(
                                           padding: const EdgeInsets.only(left: 2,right: 2),
                                           child: Align(
                                             alignment: Alignment.center,
                                             child: Text("monthly".tr(), style:
                                             CustomTextStyle().bold10(AppColors.white)
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                     GestureDetector(
                                       onTap: (){
                                         viewModel.setPaidUnPaidCom(3);
                                       },
                                       child:  Container(
                                         color:viewModel.currentDay=="annual".tr() ? AppColors.grey :Colors.transparent,
                                         height: 30,
                                         child: Padding(
                                           padding: const EdgeInsets.only(left: 2,right: 2),
                                           child: Align(
                                             alignment: Alignment.center,
                                             child: Text("annual".tr(), style:
                                             CustomTextStyle().bold10(AppColors.white)
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                                 const SizedBox(height: 8,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     SizedBox(
                                       width: sizeWidth(context).width*0.45,
                                       child: Column(
                                         children: [
                                           Text("totalPaidCom".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                           Text("\$${moneyFormat(viewModel.totalPaid)}",style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                         ],
                                       ),
                                     ),
                                     SizedBox(
                                       width: sizeWidth(context).width*0.45,
                                       child: Column(
                                         children: [
                                           Text("totalUnPaidCom".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                           Text("\$${moneyFormat(viewModel.totalUnPaid)}",style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                         ],
                                       ),
                                     ),
                                   ],
                                 )
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(height: 4,),
                         GestureDetector(
                           onTap: (){
                             Navigator.pushNamed(context, '/${PageName.adminCommissionWinner}',arguments: {"id":null});
                           },
                           child: Card(
                             shape: cardShape(context),
                             color: ColorUtil().getColor(context, ColorEnums.background),
                             elevation: 2,
                             child: Padding(
                               padding: const EdgeInsets.all(12),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("${"comDetails".tr()} (${"payPeriodBase".tr()})", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                   Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                 ],
                               ),
                             ),
                           ),
                         ),
                         const SizedBox(height: 4,),
                         GestureDetector(
                           onTap: (){
                             Navigator.pushNamed(context, '/${PageName.searchComPage}');
                           },
                           child: Card(
                             shape: cardShape(context),
                             color: ColorUtil().getColor(context, ColorEnums.background),
                             elevation: 2,
                             child: Padding(
                               padding: const EdgeInsets.all(12),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("comDetailsNamePosition".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                   Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                 ],
                               ),
                             ),
                           ),
                         ),
                         const SizedBox(height: 4,),
                         Card(
                           shape: cardShape(context),
                           color: ColorUtil().getColor(context, ColorEnums.background),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 viewModel.getPayPeriod!.payPeriod == null ?
                                 SizedBox(
                                   height:40,
                                   width:sizeWidth(context).width*0.5,
                                   child: ElevatedButton(
                                     onPressed: (){
                                       Navigator.pushNamed(context, '/${PageName.payPeriodPage}');
                                     },
                                     style: elevatedButtonStyle(context),
                                     child: Text("addPayPeriod".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                   ),
                                 ):
                                 Row(
                                   children: [
                                     Text("Search By Pay Period",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                    
                                   ],
                                 ),
                                 if(viewModel.getPayPeriod!.payPeriod !=null)
                                   SizedBox(
                                     width:sizeWidth(context).width*0.3,
                                     child: TextField(
                                       style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                       cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                       decoration: dateInputDecoration(context,"payDate"),
                                       controller: viewModel.payDate,
                                       readOnly: true,
                                       onTap: () async{
                                         String dateCheck = await DatePickerHelper.getDatePicker(context);
                                    
                                    
                                         if(viewModel.getPayPeriod!.payDate !=null){
                                           if(getDayOfWeek(dateCheck) == viewModel.getPayPeriod!.payDate){
                                             viewModel.setPayDate(dateCheck);
                                           }else{
                                             snackBarDesign(context, StringUtil.error, "Your commission pay date is ${viewModel.getPayPeriod!.payDate}.Please check commission pay period settings screen.");
                                           }
                                         }else{
                                           viewModel.setPayDate(dateCheck);
                                         }
                                         if(viewModel.payDate.text.isNotEmpty){
                                           viewModel.periodDate = await getPreviousWeeksDates(viewModel.payDate.text,viewModel.getPayPeriod!.payPeriod!,viewModel.getPayPeriod!.payDate!);
                                    
                                           await getListWithDate();
                                         }
                                       },
                                     ),
                                   ),
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(height: 8,),
                         if(viewModel.periodDate.isNotEmpty && viewModel.commissionWinner !=null)
                           Card(
                             shape: cardShape(context),
                             color: ColorUtil().getColor(context, ColorEnums.background),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   SizedBox(
                                       width:sizeWidth(context).width*0.6,
                                       child: Text("${context.tr("payPeriod")} ${viewModel.periodDate["startDate"]} / ${viewModel.periodDate["endDate"]}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)))),
                                   Container(
                                     width: sizeWidth(context).width*0.27,
                                     decoration: containerDecoration(context),
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("saleTotal".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                           Text(viewModel.searchComWinner(viewModel.commissionWinner!, viewModel.query).length.toString(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                         ],
                                       ),
                                     ),
                                   )
                                    
                                 ],
                               ),
                             ),
                           ),
                         const SizedBox(height: 8,),
                         if(viewModel.commissionWinner != null)
                           Column(
                             children: [
                               SizedBox(
                                 width: sizeWidth(context).width,
                                 height: 40,
                                 child: TextField(
                                   onChanged: (value){
                                     viewModel.setQuery(value);
                                     viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query);
                                     viewModel.addComDetail(viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query).length);
                                   },
                                   decoration: searchTextDesign(context, "searchByNamePosition"),
                                   cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                                   style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
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
                                         Text(viewModel.paidUnPaid,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                       ],
                                     ),
                                     value: viewModel.paidUnPaid,
                                     onChanged: (newValue) async{
                                       viewModel.setPaidUnpaid(newValue!);
                                       viewModel.setQuery(newValue);
                                       viewModel.searchComWinner(viewModel.commissionWinner!, newValue);
                                       viewModel.addComDetail(viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query).length);
                                    
                                     },
                                     items: viewModel.paidUnPaidList.map((value) {
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
                               const SizedBox(height: 4,),
                               RefreshIndicator(
                                 onRefresh:getList,
                                 color:ColorUtil().getColor(context, ColorEnums.wizzColor),
                                 child: RawScrollbar(
                                   thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                   thumbVisibility: true,
                                   thickness: 1,
                                   trackVisibility: true,
                                   controller: controller,
                                   child: SizedBox(
                                     height: justList(context, sizeWidth(context).height),
                                     child: ListView.builder(
                                       controller: controller,
                                       itemCount: viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query).length,
                                       itemBuilder: (context,index){
                                         int startIndex = (viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query).length == 1) ? 1 : viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query).length;
                                         List<int> indices = List.generate(viewModel.commissionWinner!.length, (index) => startIndex - index);
                                         CommissionWinner model = viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query)[index];
                                         return Card(
                                           shape: cardShape(context),
                                           color: ColorUtil().getColor(context, ColorEnums.background),
                                           child: Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Column(
                                               children: [
                                                 Text(indices[index].toString(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     SizedBox(
                                                       width: sizeWidth(context).width*0.3,
                                                       child: Text("repName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                     ),
                                                     Text(model.userName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                   ],
                                                 ),
                                                 const SizedBox(height: 4,),

                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     SizedBox(
                                                       width: sizeWidth(context).width*0.3,
                                                       child: Text("role".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                     ),
                                                     Text(model.eligibleRoleName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                   ],
                                                 ),
                                                 const SizedBox(height: 4,),
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     SizedBox(
                                                       width: sizeWidth(context).width*0.3,
                                                       child: Text(model.comType ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                     ),
                                                     model.comType =="AMOUNT" ?

                                                     Text("\$${model.commAdjustAmount ?? model.commAmount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                         :
                                                     Text("${model.comPercentage}%  (\$${model.commAdjustAmount ?? model.commAmount})",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                                   ],
                                                 ),
                                                 Visibility(
                                                   visible: viewModel.comDetail[index] == true ? false : true,
                                                   child: Column(
                                                     children: [
                                                       const Divider(),
                                                       GestureDetector(
                                                         onTap: (){
                                                            viewModel.setComDetail(index);
                                                         },
                                                         child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.end,
                                                           children: [
                                                             Text("seeDetails".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                             Icon(Icons.keyboard_arrow_right_outlined,color: ColorUtil().getColor(context, ColorEnums.wizzColor),)
                                                           ],
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                                 Visibility(
                                                   visible: viewModel.comDetail[index] == true ? true : false,
                                                   child: Column(
                                                     children: [
                                                       const SizedBox(height: 4),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           SizedBox(
                                                             width: sizeWidth(context).width*0.3,
                                                             child: Text("commCalcDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                           ),
                                                           Text(mmDDYDateTime(model.commCalculatedAt),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                         ],
                                                       ),



                                                       const SizedBox(height: 4,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           SizedBox(
                                                             width: sizeWidth(context).width*0.6,
                                                             child: Text("enterSerialNumber".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                           ),
                                                           GestureDetector(
                                                             onTap:()async{
                                                               await getSaleDetails(model.saleSerialNumber!);
                                                             },
                                                             child:Column(
                                                               crossAxisAlignment: CrossAxisAlignment.end,
                                                               children: [
                                                                 SizedBox(
                                                                     child: Text(model.saleSerialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                                                 SizedBox(
                                                                   width: sizeWidth(context).width*0.12,
                                                                   child: Divider(
                                                                     thickness: 2,
                                                                     color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                                   ),
                                                                 )
                                                               ],
                                                             ),
                                                           ),

                                                         ],
                                                       ),
                                                       const SizedBox(height: 4,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           SizedBox(
                                                             width: sizeWidth(context).width*0.3,
                                                             child: Text("salesPrice".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                           ),
                                                           Text("\$${model.salePrice ?? "0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                         ],
                                                       ),

                                                       const SizedBox(height: 4,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           SizedBox(
                                                             width: sizeWidth(context).width*0.3,
                                                             child: Text("isPaid?".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                           ),
                                                           Text(model.isCommPaid == true ? "Paid" :"UnPaid",style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                                         ],
                                                       ),
                                                       const SizedBox(height: 4),
                                                       if(model.isCommPaid ==true)
                                                         Column(
                                                           children: [
                                                             Row(
                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                               children: [
                                                                 SizedBox(
                                                                   width: sizeWidth(context).width*0.3,
                                                                   child: Text("payDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                                 ),
                                                                 Text(mmDDYDate(model.payAt ?? ""),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                               ],
                                                             ),

                                                             SizedBox(
                                                               width:sizeWidth(context).width*0.80,
                                                               child: ElevatedButton(
                                                                   onPressed: ()async{
                                                                     bool check = await returnPaidQuestion(context);
                                                                     if(check){
                                                                       await returnPost(model.comSaleId!);
                                                                     }
                                                                   },
                                                                   style: elevatedButtonStyle(context),
                                                                   child: Text("returnPay".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                                               ),
                                                             ),
                                                           ],
                                                         ),
                                                       const SizedBox(height: 4),
                                                       const Divider(
                                                         thickness: 0.5,
                                                       ),
                                                       const SizedBox(height: 4,),
                                                       if(model.isCommPaid !=true)
                                                         SizedBox(
                                                           width:sizeWidth(context).width*0.80,
                                                           child: ElevatedButton(
                                                               onPressed: (){

                                                                 showAdjust(context,viewModel,model.comSaleId!);
                                                               },
                                                               style: elevatedButtonStyle(context),
                                                               child: Text("adjust".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                                           ),
                                                         ),
                                                       if(model.isCommPaid ==false)
                                                         SizedBox(
                                                           width:sizeWidth(context).width*0.80,
                                                           child: ElevatedButton(
                                                               onPressed: ()async{
                                                                 bool check = await paidQuestion(context);
                                                                 if(check){
                                                                   await post(model.comSaleId!);
                                                                 }
                                                               },
                                                               style: elevatedButtonStyle(context),
                                                               child: Text("approve".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                           ),
                                                         ),
                                                       const SizedBox(height: 4,),
                                                       GestureDetector(
                                                         onTap: (){
                                                           viewModel.setComDetail(index);
                                                         },
                                                         child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.end,
                                                           children: [
                                                             Text("closeDetail".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                             Icon(Icons.keyboard_arrow_right_outlined,color: ColorUtil().getColor(context, ColorEnums.wizzColor),)
                                                           ],
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 )
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

                       ],
                     ),
                   ),
                 ),
               
             );
           }
         }
       ),
     )
   );
  }
  Future<void> getList()async{
    await viewModel.getComReport(context);
    await viewModel.getOrgName(context);
    await viewModel.listPayPeriod(context);
    if(viewModel.getPayPeriod!.payPeriod !=null){
      await getListWithDate();
    }
  }

  Future<void> getListWithDate()async{
    if(viewModel.payDate.text.isNotEmpty){
      dynamic x = formatDateString(viewModel.payDate.text,"MM-dd-yyyy","yyyy-MM-dd");
      await showProgress(context, true);
      await viewModel.getComWinner(context,null,viewModel.getPayPeriod!.payPeriod,x);
      await showProgress(context, false);
      viewModel.addComDetail(viewModel.commissionWinner!.length);
      dynamic y=0.0;
      dynamic z=0.0;

      for(int i=0;i<viewModel.commissionWinner!.length;i++){
        if(viewModel.commissionWinner![i].isCommPaid == true){
          y +=double.parse(viewModel.commissionWinner![i].commAdjustAmount ?? viewModel.commissionWinner![i].commAmount ?? "0.0");
        }
        else{
          z +=double.parse(viewModel.commissionWinner![i].commAdjustAmount ?? viewModel.commissionWinner![i].commAmount ?? "0.0");
        }
      }
      viewModel.totalPaid = y;
      viewModel.totalUnPaid = z;
    }

  }
  Future<void> getSaleDetails(String serial)async{
    await viewModel.getSaleDetails(context, serial);

    if (viewModel.saleDetails!.isNotEmpty){
      showComSaleDetails(context,viewModel.saleDetails!);
    }else{
      snackBarDesign(context, StringUtil.error, "cannotFindDetail".tr());
    }
  }
  post(int id) async{
    //eğer adjust edilen varsa adjust olacak yoksa com amount pay edilecek
    PayPost post = PayPost(calcPoolSaleId: id);
    await viewModel.postComPay(context,post,getList);

  }
  returnPost(int id) async{
    PayPost post = PayPost(calcPoolSaleId: id);
    await viewModel.postComPay(context,post,getList);

  }
}
