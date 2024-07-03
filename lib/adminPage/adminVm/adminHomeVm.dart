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

import '../../model/OLD/User.dart';
import '../adminModel/overrideModel/overrideUserList.dart';

class AdminHomeVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<OverrideUserList>? overrideUserList;
  DetailReportModel? detailsReportModel;
  String currentDay=day[2];
  dynamic totalSales=0;
  dynamic totalDemos=0;
  dynamic totalLeads=0;
  bool check = false;
  String? userType;



  checkOverrideUser(BuildContext context,List<int> userId)async{

    if(overrideUserList !=null){
      if(overrideUserList!.isNotEmpty){
        for(int i=0;i<overrideUserList!.length;i++){
          for(int j=0;j<userId.length;j++){

            if(overrideUserList![i].id == userId[j]){
              print("talha can ${overrideUserList![i].id} -- ${userId[j]}");
              check = true;
            }
          }

        }
      }
    }
    notifyListeners();
  }
  updateMode(String mode) async {
    await pref.setString(SharedUtils.admin, mode);
    userType = mode;
    notifyListeners();
  }
  reportValues(int value,DetailReportModel reportModel){
      currentDay = day[value];
      totalSales=0;
      totalLeads=0;
      totalDemos=0;
      if (value == 0) {
        for (int i = 0; i < reportModel.salesReport!.lastMonthlyDayCount!.length; i++) {
          totalSales += reportModel.salesReport!.lastMonthlyDayCount![i].count ?? 0;
        }
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalDemos = totalDemos + (reportModel.leadsReport!.leadReports![i].lastMonthAppointmentSet ?? 0);
        }
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].lastMonthAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].lastMonthNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].lastMonthSaleSold ?? 0;


        }
        totalLeads = appointment + notContacted + sold;
      }
      if (value == 1) {
        for (int i = 0; i < reportModel.salesReport!.yesterdayHourlyCount!.length; i++) {
          totalSales += reportModel.salesReport!.yesterdayHourlyCount![i].count ?? 0;
        }
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalDemos = totalDemos + (reportModel.leadsReport!.leadReports![i].yesterdayAppointmentSet ?? 0);
        }
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].yesterdayAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].yesterdayNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].daliySold ?? 0;

        }
        totalLeads = appointment + notContacted + sold;
      }
      if (value == 2) {
        for (int i = 0; i < reportModel.salesReport!.todayHourlyCount!.length; i++) {
          totalSales += reportModel.salesReport!.todayHourlyCount![i].count ?? 0;
        }
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalDemos = totalDemos + (reportModel.leadsReport!.leadReports![i].daliyAppointmentSet ?? 0);
        }
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].daliyAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].daliyNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].daliySold ?? 0;
        }

        totalLeads = appointment + notContacted + sold;
      }
      if (value == 3) {
        for (int i = 0; i < reportModel.salesReport!.weeklyDayCount!.length; i++) {
          totalSales += reportModel.salesReport!.weeklyDayCount![i].count ?? 0;
        }
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalDemos = totalDemos + (reportModel.leadsReport!.leadReports![i].weeklyAppointmentSet ?? 0);
        }
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].weeklyAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].weeklyNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].weeklySold ?? 0;

        }
        totalLeads = appointment + notContacted + sold;
      }
      if (value == 4) {
        for (int i = 0; i < reportModel.salesReport!.monthlyDayCount!.length; i++) {
          totalSales += reportModel.salesReport!.monthlyDayCount![i].count ?? 0;
        }
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalDemos = totalDemos + (reportModel.leadsReport!.leadReports![i].monthlyAppointmentSet ?? 0);
        }
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].monthlyAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].monthlyNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].monthlySaleSold ?? 0;


        }
        totalLeads = appointment + notContacted + sold;
      }
      if (value == 5) {
        for (int i = 0; i < reportModel.salesReport!.annualMonthCount!.length; i++) {
          totalSales += reportModel.salesReport!.annualMonthCount![i].count ?? 0;
        }
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalDemos = totalDemos + (reportModel.leadsReport!.leadReports![i].annualyAppointmentSet ?? 0);
        }
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].annualyAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].annualyNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].annualySold ?? 0;


        }
        totalLeads = appointment + notContacted + sold;
      }

     notifyListeners();
  }

  Future<void>detailReport(BuildContext context,int userId,int orgId) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      detailsReportModel = await apiService.detailReport(userId,orgId);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data!);
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
  Future<void>getOverrideUser(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      overrideUserList = await apiService.allOverrideUser();

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