import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/detailsReportModel/DetailReportModel.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
// ignore_for_file: use_build_context_synchronously

class MyProgressVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  DetailReportModel? detailsReportModel;
  int progressIndex=3;
  TextEditingController daySelect = TextEditingController(text: "annually".tr());
  int? sales;
  int estimatedSales=0;
  dynamic averageSalesPrice;
  dynamic closingRatio;
  int? totalDemos;
  dynamic successSold=0;
  dynamic totalLeads;
  dynamic totalRevenue;
  dynamic leadGoals=0;
  dynamic demosGoals=0;
  dynamic appointmentGoals=0;
  dynamic leadActual=0;
  dynamic demosActual=0;
  dynamic appointmentActual=0;
  dynamic paidCom=0;
  dynamic unPaidCom=0;

   setReportIndex(int value, DetailReportModel reportModel) {
    progressIndex = value;
    daySelect.text=progressList[progressIndex];
    getValues(reportModel);
    notifyListeners();
  }

  getValues(DetailReportModel reportModel){

    if(progressIndex ==1){
      totalLeads = 0;
      estimatedSales=0;
      sales = (reportModel.salesReport!.todayCount ?? 0);
      averageSalesPrice = getDecimalPlaces( reportModel.salesAvgReport!.dailyNetPriceAverage ?? "0",2);

      totalDemos = reportModel.demoReportV2!.totalDemos ?? 0;
      for(int i=0;i<reportModel.leadsReport!.leadReports!.length;i++){
        totalLeads +=
            (reportModel.leadsReport!.leadReports![i].daliySold ?? 0 )
                +(reportModel.leadsReport!.leadReports![i].daliyNotContacted ?? 0 )
                +(reportModel.leadsReport!.leadReports![i].daliyAppointmentSet ?? 0 );
      }
      totalRevenue = reportModel.salesReport!.totalPrice ?? 0;

      if(reportModel.demoReportV2!.successSoldWeekly! == 0 || reportModel.demoReportV2!.totalDemos! ==0){
        closingRatio = 0.0;
      }else{
        successSold = reportModel.demoReportV2!.successSoldWeekly ?? 0;
        dynamic ratio = ((reportModel.demoReportV2!.successSoldWeekly ?? 0) / (reportModel.demoReportV2!.totalDemos ?? 0));
        closingRatio = (ratio * 100).toString();
      }


      if(reportModel.userGoals!.isNotEmpty){
        leadGoals = reportModel.userGoals![0].leads ?? 0;
        appointmentGoals = reportModel.userGoals![0].appointments ?? 0;
        demosGoals = reportModel.userGoals![0].demos ?? 0;
        estimatedSales = reportModel.userGoals![0].estimated ?? 0;
        leadActual = reportModel.userGoals![0].actualLeads ?? 0;
        appointmentActual = reportModel.userGoals![0].actualAppointments ?? 0;
        demosActual = reportModel.userGoals![0].actualDemos ?? 0;
      }
      paidCom = reportModel.commission!.paidComDaily ?? 0;
      unPaidCom = reportModel.commission!.notPaidComDaily ?? 0;


    }

    if(progressIndex ==1){
      totalLeads = 0;
      sales = (reportModel.salesReport!.weeklyCount ?? 0);
      averageSalesPrice = getDecimalPlaces( reportModel.salesAvgReport!.weeklyNetPriceAverage ?? "0",2);

      totalDemos = reportModel.demoReportV2!.totalDemosAsWeekly ?? 0;
      for(int i=0;i<reportModel.leadsReport!.leadReports!.length;i++){
        totalLeads +=
            (reportModel.leadsReport!.leadReports![i].weeklySold ?? 0 )
                +(reportModel.leadsReport!.leadReports![i].weeklyNotContacted ?? 0 )
                +(reportModel.leadsReport!.leadReports![i].weeklyAppointmentSet ?? 0 );
      }
      totalRevenue = reportModel.salesReport!.totalPrice ?? 0;

      if(reportModel.demoReportV2!.successSoldWeekly! == 0 || reportModel.demoReportV2!.totalDemosAsWeekly! ==0){
        closingRatio = 0.0;
      }else{
        successSold = reportModel.demoReportV2!.successSoldWeekly ?? 0;
        dynamic ratio = ((reportModel.demoReportV2!.successSoldWeekly ?? 0) / (reportModel.demoReportV2!.totalDemoAsAnnual ?? 0));
        closingRatio = (ratio * 100).toString();
      }


     if(reportModel.userGoals!.isNotEmpty){
       leadGoals = reportModel.userGoals![1].leads ?? 0;
       appointmentGoals = reportModel.userGoals![1].appointments ?? 0;
       demosGoals = reportModel.userGoals![1].demos ?? 0;
       estimatedSales = reportModel.userGoals![1].estimated ?? 0;
       leadActual = reportModel.userGoals![1].actualLeads ?? 0;
       appointmentActual = reportModel.userGoals![1].actualAppointments ?? 0;
       demosActual = reportModel.userGoals![1].actualDemos ?? 0;
     }
      paidCom = reportModel.commission!.paidComWeekly ?? 0;
      unPaidCom = reportModel.commission!.notPaidComWeekly ?? 0;

    }
    if(progressIndex ==2){
      totalLeads = 0;
      sales = reportModel.salesReport!.monthlyCount ?? 0;
      averageSalesPrice = getDecimalPlaces(reportModel.salesAvgReport!.monthlyNetPriceAverage ?? "0",2);


      totalDemos = reportModel.demoReportV2!.totalDemosAsMonthly ?? 0;
      for(int i=0;i<reportModel.leadsReport!.leadReports!.length;i++){
        totalLeads =totalLeads+
            (reportModel.leadsReport!.leadReports![i].monthlySaleSold ?? 0 )
                +(reportModel.leadsReport!.leadReports![i].monthlyNotContacted ?? 0 )
                +(reportModel.leadsReport!.leadReports![i].monthlyAppointmentSet ?? 0 );
      }
      totalRevenue = reportModel.salesReport!.totalPrice ?? 0;

      if(reportModel.demoReportV2!.successSoldMonthly! == 0 || reportModel.demoReportV2!.totalDemosAsMonthly! ==0){
        closingRatio = 0.0;
      }else{
        successSold = reportModel.demoReportV2!.successSoldMonthly ?? 0;
        dynamic ratio = ((reportModel.demoReportV2!.successSoldMonthly ?? 0) / (reportModel.demoReportV2!.totalDemoAsAnnual ?? 0));
        closingRatio = (ratio * 100).toString();


      }


      if (reportModel.userGoals!.isNotEmpty) {
        leadGoals = reportModel.userGoals![2].leads ?? 0;
        appointmentGoals = reportModel.userGoals![2].appointments ?? 0;
        demosGoals = reportModel.userGoals![2].demos ?? 0;
        estimatedSales = reportModel.userGoals![2].estimated ?? 0;
        leadActual = reportModel.userGoals![2].actualLeads ?? 0;
        appointmentActual = reportModel.userGoals![2].actualAppointments ?? 0;
        demosActual = reportModel.userGoals![2].actualDemos ?? 0;
      }
      paidCom = reportModel.commission!.paidComMonthly ?? 0;
      unPaidCom = reportModel.commission!.notPaidComMonthly ?? 0;

    }

    if(progressIndex ==3){
      totalLeads = 0;
      sales = reportModel.salesReport!.annualCount ?? 0;

      averageSalesPrice =   getDecimalPlaces( reportModel.salesAvgReport!.annualNetPriceAverage ?? "0",2);

      totalDemos = reportModel.demoReportV2!.totalDemoAsAnnual ?? 0;
      for(int i=0;i<reportModel.leadsReport!.leadReports!.length;i++){
        totalLeads +=
            (reportModel.leadsReport!.leadReports![i].annualySold ?? 0 )
            +(reportModel.leadsReport!.leadReports![i].annualyNotContacted ?? 0 )
            +(reportModel.leadsReport!.leadReports![i].annualyAppointmentSet ?? 0 );
      }
      totalRevenue = reportModel.salesReport!.totalPrice ?? 0;

      if(reportModel.demoReportV2!.totalDemoAsAnnual! == 0 || reportModel.demoReportV2!.totalDemoAsAnnual! ==0){
        closingRatio = 0.00;
      }else{
        successSold = reportModel.demoReportV2!.successSold ?? 0;
        dynamic ratio = ((reportModel.demoReportV2!.successSold ?? 0) / (reportModel.demoReportV2!.totalDemoAsAnnual ?? 0));
        closingRatio = (ratio * 100).toString();


      }
      if(reportModel.userGoals!.isNotEmpty){

        leadGoals = (reportModel.userGoals![2].leads ?? 0)*12 ;
        appointmentGoals = (reportModel.userGoals![2].appointments ?? 0) *12;
        demosGoals = (reportModel.userGoals![2].demos ?? 0) *12 ;
        estimatedSales = (reportModel.userGoals![2].estimated ?? 0)*12;
        leadActual = (reportModel.userGoals![2].actualLeads ?? 0)*12;
        appointmentActual = (reportModel.userGoals![2].actualAppointments ?? 0)*12;
        demosActual = (reportModel.userGoals![2].actualDemos ?? 0)*12;
      }
      paidCom = reportModel.commission!.paidComAnnual ?? 0;
      unPaidCom = reportModel.commission!.notPaidComAnnual ?? 0;

    }

  }

  Future<void>detailReport(BuildContext context,int userId,int orgId) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.detailReport(userId,orgId).then((value) => {
        detailsReportModel = value,
        getValues(detailsReportModel!),
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      notifyListeners();

    }

  }
}