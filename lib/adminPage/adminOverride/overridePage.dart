import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideWinner.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
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

class OverridePage extends StatefulWidget {
  const OverridePage({super.key});

  @override
  State<StatefulWidget> createState() => _OverridePageState();
}

class _OverridePageState extends State<OverridePage> {
  AdminOverrideVm viewModel = AdminOverrideVm();
  ScrollController controller = ScrollController();
  dynamic x;
  @override
  void initState() {
    getReport();
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
      appBar: SettingsAppBar(
        name: "override".tr(),
        func: ()  {
          Navigator.pushNamed(context, '/${PageName.overrideSettingsPage}');
        },
      ),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminOverrideVm>(
            builder: (context,value,_){
               if(viewModel.overrideReports == null){
                 return spinKit(context);
               }else{
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: SingleChildScrollView(
                     child: Column(
                       children: [
                         Align(
                           alignment: Alignment.centerRight,
                           child: GestureDetector(
                             onTap: ()async{
                               showProgress(context, true);
                               await getReport();
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
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     GestureDetector(
                                       onTap: (){
                                         viewModel.setPaidUnPaid(0);
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
                                         viewModel.setPaidUnPaid(1);
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
                                           Text("totalApprovedOverride".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                           Text("\$${moneyFormat(viewModel.totalPaid)}",style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                         ],
                                       ),
                                     ),
                                     SizedBox(
                                       width: sizeWidth(context).width*0.45,
                                       child: Column(
                                         children: [
                                           Text("totalPendingOverride".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
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
                             Navigator.pushNamed(context, '/${PageName.searchOverridePage}');
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
                                   Text("overrideDetailsNamePosition".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                   Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                 ],
                               ),
                             ),
                           ),
                         ),
                         const SizedBox(height: 4,),
                         GestureDetector(
                           onTap: (){

                             Navigator.pushNamed(context, '/${PageName.overrideWinner}');
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
                                   Text("overrideReport".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
                                 Text("Search By Pay Period",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                 SizedBox(
                                   width:sizeWidth(context).width*0.3,
                                   child: TextField(
                                     style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                     cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                     decoration: dateInputDecoration(context,"payDate"),
                                     controller: viewModel.payDate,
                                     readOnly: true,
                                     onTap: () async{
                                       viewModel.payDate.text = await DatePickerHelper.getDatePicker(context);

                                       if(viewModel.payDate.text.isNotEmpty){
                                         x = formatDateString(viewModel.payDate.text,"MM-dd-yyyy","yyyy-MM-dd");
                                         await getList(x);
                                       }else{
                                         viewModel.setOverrideWinner();
                                         snackBarDesign(context, StringUtil.error, "dateRequired".tr());
                                       }
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         if(viewModel.payDate.text.isNotEmpty && viewModel.overrideWinner !=null)
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
                                       child: Text("${context.tr("payPeriod")} ${getPreviousMonthFirstAndLastDate(viewModel.payDate.text)}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)))),
                                   Container(
                                     width: sizeWidth(context).width*0.27,
                                     decoration: containerDecoration(context),
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("total".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                           Text(viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length.toString(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                         ],
                                       ),
                                     ),
                                   )

                                 ],
                               ),
                             ),
                           ),
                         const SizedBox(height: 8,),
                         if(viewModel.overrideWinner !=null)
                           Column(
                             children: [
                               SizedBox(
                                 width: sizeWidth(context).width,
                                 height: 40,
                                 child: TextField(
                                   onChanged: (value){
                                     viewModel.setQuery(value);
                                     viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query);
                                   },
                                   decoration: searchTextDesign(context, "search"),
                                   cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                                   style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                                 ),
                               ),
                               const SizedBox(height: 8,),
                               RefreshIndicator(
                                 onRefresh: ()=>getList(x),
                                 color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                 child: RawScrollbar(
                                   controller: controller,
                                   thumbVisibility: true,
                                   thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                   thickness: 1,
                                   child: SizedBox(
                                     height: justList(context, sizeWidth(context).height),
                                     child: ListView.builder(
                                       itemCount: viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length,
                                       controller: controller,
                                       itemBuilder: (context,index){
                                         int startIndex = (viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length == 1) ? 1 : viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length;
                                         List<int> indices = List.generate(viewModel.overrideWinner!.length, (index) => startIndex - index);
                                         AdminOverrideWinner model = viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query)[index];
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
                                                       width: sizeWidth(context).width*0.5,
                                                       child: Text("overrideReceiveBy".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
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
                                                       child: Text("overrideType".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                     ),
                                                     Text(model.overrideType ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                   ],
                                                 ),
                                                 const SizedBox(height: 4,),
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     SizedBox(
                                                       width: sizeWidth(context).width*0.3,
                                                       child: Text("product".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                     ),
                                                     Text(model.productName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                   ],
                                                 ),
                                                 const SizedBox(height: 4,),
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     SizedBox(
                                                       width: sizeWidth(context).width*0.6,
                                                       child: Text("enterSerialNumber".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                     ),
                                                     Text(model.serialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                                   ],
                                                 ),
                                                 const SizedBox(height: 4,),
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     SizedBox(
                                                       width: sizeWidth(context).width*0.3,
                                                       child: Text("overrideAmount".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                     ),
                                                     Text("\$${model.overrideAmount ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                   ],
                                                 ),
                                                 const SizedBox(height: 4,),
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     SizedBox(
                                                       width: sizeWidth(context).width*0.3,
                                                       child: Text("puchases".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                     ),
                                                     Text(model.organisationName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                   ],
                                                 ),
                                                 const SizedBox(height: 4,),
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     SizedBox(
                                                       width: sizeWidth(context).width*0.3,
                                                       child: Text("overrideCalDate".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                     ),
                                                     Text(mmDDYDate(model.calculatedDate),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                   ],
                                                 ),
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
                           )
                       ],
                     ),

                   ),
                 );
               }

            },
          ),
        )
      ),
    );
  }

  getReport()async{
      await viewModel.getOverrideReports(context);

  }
  Future<void> getList(String? payDate)async{
    await showProgress(context, true);
    await viewModel.getOverrideWinnerDetail(context,payDate);
    await showProgress(context, false);
}


}
