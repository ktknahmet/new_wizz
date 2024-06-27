import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/postGoals/PostGoals.dart';
import 'package:wizzsales/adminPage/adminVm/adminGoalsVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AdminManageGoals extends BaseStatefulPage {
  const AdminManageGoals(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AdminManageGoalsState();
}

class _AdminManageGoalsState extends BaseStatefulPageState<AdminManageGoals> {
  AdminGoalsVm viewModel = AdminGoalsVm();
  TextEditingController dailyLeads = TextEditingController();
  TextEditingController dailyAppointment = TextEditingController();
  TextEditingController dailyDemo = TextEditingController();
  TextEditingController dailyEstimated = TextEditingController();
  TextEditingController weekLeads = TextEditingController();
  TextEditingController weekAppointment = TextEditingController();
  TextEditingController weekDemo = TextEditingController();
  TextEditingController weekEstimated = TextEditingController();
  TextEditingController monthLeads = TextEditingController();
  TextEditingController monthAppointment = TextEditingController();
  TextEditingController monthDemo = TextEditingController();
  TextEditingController monthEstimated = TextEditingController();

  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AdminGoalsVm>(
        builder: (context,value,_){
           if(viewModel.goalsReport == null){
             return spinKit(context);
           }else{
             return SingleChildScrollView(
               child: Column(
                 children: [
                   SizedBox(
                     height: sizeWidth(context).height*0.80,
                     child: SingleChildScrollView(
                       child: Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("${context.tr("daily")} ${context.tr("goals")} ",style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                               GestureDetector(
                                   onTap: (){
                                    viewModel.setOpenDaily(!viewModel.openDaily);
                                   },
                                   child: Icon(viewModel.openDaily == true ? Icons.arrow_circle_down_outlined :Icons.arrow_circle_up_rounded,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),))
                             ],
                           ),
                          Visibility(
                            visible: viewModel.openDaily == true ? true : false,
                            child: Column(
                              children: [
                                const SizedBox(height: 12,),
                                accountCreate(context, "leads", dailyLeads),
                                const SizedBox(height: 12,),
                                accountCreate(context, "appointmentSet", dailyAppointment),
                                const SizedBox(height: 12,),
                                accountCreate(context, "demoRun", dailyDemo),
                                const SizedBox(height: 12,),
                                accountCreate(context, "estimatedSale", dailyEstimated)
                              ],
                            ),
                          ),
                          const SizedBox(height: 12,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("${context.tr("weekly")} ${context.tr("goals")}",style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                               GestureDetector(
                                   onTap: (){
                                     viewModel.setOpenWeek(!viewModel.openWeek);
                                   },
                                   child: Icon(viewModel.openWeek == true ? Icons.arrow_circle_down_outlined :Icons.arrow_circle_up_rounded,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),))
                             ],
                           ),
                           Visibility(
                             visible: viewModel.openWeek == true ? true : false,
                             child: Column(
                               children: [
                                 const SizedBox(height: 12,),
                                 accountCreate(context, "leads", weekLeads),
                                 const SizedBox(height: 12,),
                                 accountCreate(context, "appointmentSet", weekAppointment),
                                 const SizedBox(height: 12,),
                                 accountCreate(context, "demoRun", weekDemo),
                                 const SizedBox(height: 12,),
                                 accountCreate(context, "estimatedSale", weekEstimated)
                               ],
                             ),
                           ),
                           const SizedBox(height: 12,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("${context.tr("monthly")} ${context.tr("goals")}",style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                               GestureDetector(
                                   onTap: (){
                                     viewModel.setOpenMonth(!viewModel.openMonth);
                                   },
                                   child: Icon(viewModel.openMonth == true ? Icons.arrow_circle_down_outlined :Icons.arrow_circle_up_rounded,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),))
                             ],
                           ),
                           Visibility(
                             visible: viewModel.openMonth == true ? true : false,
                             child: Column(
                               children: [
                                 const SizedBox(height: 12,),
                                 accountCreate(context, "leads", monthLeads),
                                 const SizedBox(height: 12,),
                                 accountCreate(context, "appointmentSet", monthAppointment),
                                 const SizedBox(height: 12,),
                                 accountCreate(context, "demoRun", monthDemo),
                                 const SizedBox(height: 12,),
                                 accountCreate(context, "estimatedSale", monthEstimated)
                               ],
                             ),
                           ),
                           const SizedBox(height: 12,),

                         ],
                       ),
                     ),
                   ),
                   SizedBox(
                     width: sizeWidth(context).width*0.75,
                     child: ElevatedButton(
                       onPressed: () async{
                          await save();
                       },
                       style: elevatedButtonStyle(context),
                       child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                     ),
                   )
                 ],
               ),
             );
           }
        },
      ),
    );
  }
  getList() async{
    await viewModel.getReport(context);
    if(viewModel.goalsReport !=null){


      dailyLeads.text = viewModel.goalsReport![0].leads.toString();
      dailyAppointment.text = viewModel.goalsReport![0].appointments.toString();
      dailyDemo.text = viewModel.goalsReport![0].demos.toString();
      dailyEstimated.text = viewModel.goalsReport![0].estimated.toString();

      weekLeads.text = viewModel.goalsReport![1].leads.toString();
      weekAppointment.text = viewModel.goalsReport![1].appointments.toString();
      weekDemo.text = viewModel.goalsReport![1].demos.toString();
      weekEstimated.text = viewModel.goalsReport![1].estimated.toString();

      monthLeads.text = viewModel.goalsReport![2].leads.toString();
      monthAppointment.text = viewModel.goalsReport![2].appointments.toString();
      monthDemo.text = viewModel.goalsReport![2].demos.toString();
      monthEstimated.text =viewModel.goalsReport![2].estimated.toString();


    }
  }
  save() async{

      PostGoalReport postGoalReport = PostGoalReport(
          dayLeads: dailyLeads.text.isNotEmpty ? dailyLeads.text : "0",
          dayAppointments: dailyAppointment.text.isNotEmpty ? dailyAppointment.text :"0",
          dayDemos: dailyDemo.text.isNotEmpty ? dailyDemo.text :"0",
          dayEstimated: dailyEstimated.text.isNotEmpty ? dailyEstimated.text :"0",
          weekLeads: weekLeads.text.isNotEmpty ? weekLeads.text :"0",
          weekAppointments: weekAppointment.text.isNotEmpty ? weekAppointment.text :"0",
          weekDemos: weekDemo.text.isNotEmpty ? weekDemo.text :"0",
          weekEstimated: weekEstimated.text.isNotEmpty ? weekEstimated.text :"0",
          monthLeads: monthLeads.text.isNotEmpty ? monthLeads.text :"0",
          monthAppointments: monthAppointment.text.isNotEmpty ? monthAppointment.text :"0",
          monthDemos: monthDemo.text.isNotEmpty ? monthDemo.text :"0",
          monthEstimated: monthEstimated.text.isNotEmpty ? monthEstimated.text :"0",
          dayActualLeads:"0",
          dayActualAppointments:"0",
          dayActualDemos:"0",
          dayActualEstimated:"0",
          weekActualLeads:"0",
          weekActualAppointments:"0",
          weekActualDemos:"0",
          weekActualEstimated:"0",
          monthActualLeads:"0",
          monthActualAppointments:"0",
          monthActualDemos:"0",
          monthActualEstimated:"0"
      );

      await viewModel.postGoals(context, postGoalReport);
      snackBarDesign(context, StringUtil.success, viewModel.response!);


  }

}
