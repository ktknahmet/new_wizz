import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminModel/carousel/SliderPayload.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/model/OLD/Resources.dart';
import 'package:wizzsales/model/detailsReportModel/DetailReportModel.dart';
import 'package:wizzsales/model/leadReportModel/demoLeadReportModel.dart';
import 'package:wizzsales/model/leadReportModel/leadReportModel.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../utils/res/SharedUtils.dart';
// ignore_for_file: use_build_context_synchronously

class HomeVm extends ChangeNotifier{
  String? resource;
  List<String> names = [];
  Map<String, List<Resource>> allResourcesLists = {};
  List<Resource> resourcesList=[];
  DetailReportModel? detailsReportModel;
  TextEditingController daySelect = TextEditingController(text: "daily".tr());
  SharedPref pref = SharedPref();
  int reportIndex=2;
  dynamic totalSales=0;
  dynamic totalAppointment=0;
  dynamic totalLeads=0;
  String reportName="totalSale".tr();
  String leadType="Door Card Registration";
  String type ="daily".tr();
  List<SliderPayload>? getSlider;
  int index=0;

  setLeadType(String type){
    leadType = type;
    notifyListeners();
  }
  setType(String value){
    type = value;
    notifyListeners();
  }

  setReportName(int index){
    reportName = reportType[index];
    notifyListeners();
  }


  setReportIndex(String value){
    daySelect.text = value;
    type = value;

    if(value=="lastMonth".tr()){
      reportIndex=0;
    }
    if(value=="yesterday".tr()){
      reportIndex=1;
    }
    if(value=="daily".tr()){
      reportIndex=2;
    }
    if(value=="weekly".tr()){
      reportIndex=3;
    }
    if(value=="monthly".tr()){
      reportIndex=4;
    }
    if(value=="annual".tr()){
      reportIndex=5;
    }
    notifyListeners();
  }

  allSlider(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getAllSlider().then((value) {
        getSlider = value;
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;

        if (res?.statusCode == 400) {
          String jsonString = json.encode(res!.data);
          showErrorMessage(context,jsonString);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        print("General error: $error");
      }
    } finally {
      notifyListeners();

    }
  }
  List<LeadReportModel> reportTotalSaleValue(int value,DetailReportModel reportModel){
    List<LeadReportModel> reports = [];
    totalSales=0;
    if (value == 0) {
      for (int i = 0; i < reportModel.salesReport!.lastMonthlyDayCount!.length; i++) {
        totalSales += reportModel.salesReport!.lastMonthlyDayCount![i].count ?? 0;

        if(reportModel.salesReport!.lastMonthlyDayCount![i].count!>0){
          reports.add(LeadReportModel(
              reportModel.salesReport!.lastMonthlyDayCount![i].totalNetPrice!,
              reportModel.salesReport!.lastMonthlyDayCount![i].count ?? 0,
              mmDDY(reportModel.salesReport!.lastMonthlyDayCount![i].day!)));
        }
      }
    }
    if (value == 1) {
      for (int i = 0; i < reportModel.salesReport!.yesterdayHourlyCount!.length; i++) {
        totalSales += reportModel.salesReport!.yesterdayHourlyCount![i].count ?? 0;
        if(reportModel.salesReport!.yesterdayHourlyCount![i].count!>0){
          reports.add(LeadReportModel(
              reportModel.salesReport!.yesterdayHourlyCount![i].totalNetPrice!,
              reportModel.salesReport!.yesterdayHourlyCount![i].count ?? 0,
              convertTo12HourFormat(int.parse(reportModel.salesReport!.yesterdayHourlyCount![i].hour!))));
        }
      }
    }
    if (value == 2) {
      for (int i = 0; i < reportModel.salesReport!.todayHourlyCount!.length; i++) {
        totalSales += reportModel.salesReport!.todayHourlyCount![i].count ?? 0;

        if(reportModel.salesReport!.todayHourlyCount![i].count!>0){

          reports.add(LeadReportModel(
              reportModel.salesReport!.todayHourlyCount![i].totalNetPrice!,
              reportModel.salesReport!.todayHourlyCount![i].count ?? 0,
              convertTo12HourFormat(int.parse(reportModel.salesReport!.todayHourlyCount![i].hour!))));
        }
      }
    }
    if (value == 3) {
      for (int i = 0; i < reportModel.salesReport!.weeklyDayCount!.length; i++) {
        totalSales += reportModel.salesReport!.weeklyDayCount![i].count ?? 0;

        if(reportModel.salesReport!.weeklyDayCount![i].count!>0){
          reports.add(LeadReportModel(
              reportModel.salesReport!.weeklyDayCount![i].totalNetPrice ?? 0,
              reportModel.salesReport!.weeklyDayCount![i].count ?? 0,
              mmDDY(reportModel.salesReport!.weeklyDayCount![i].day!)));
        }
      }
    }
    if (value == 4) {
      for (int i = 0; i < reportModel.salesReport!.monthlyDayCount!.length; i++) {
        totalSales += reportModel.salesReport!.monthlyDayCount![i].count ?? 0;

        if(reportModel.salesReport!.monthlyDayCount![i].count!>0){
          reports.add(LeadReportModel(
              reportModel.salesReport!.monthlyDayCount![i].totalNetPrice ?? 0,
              reportModel.salesReport!.monthlyDayCount![i].count ?? 0,
              mmDDY(reportModel.salesReport!.monthlyDayCount![i].day!)));
        }
      }
    }
    if (value == 5) {
      for (int i = 0; i < reportModel.salesReport!.annualMonthCount!.length; i++) {
        totalSales += reportModel.salesReport!.annualMonthCount![i].count ?? 0;

        if(reportModel.salesReport!.annualMonthCount![i].count!>0){
          reports.add(LeadReportModel(
              reportModel.salesReport!.annualMonthCount![i].totalNetPrice ?? 0,
              reportModel.salesReport!.annualMonthCount![i].count ?? 0,
              reportModel.salesReport!.annualMonthCount![i].month!));
        }
      }
    }
    return reports;
  }

  List<DemoLeadReportModel> reportTotalAppointmentValues(int value,DetailReportModel reportModel){
    List<DemoLeadReportModel> reports = [];
    totalAppointment=0;
    if (value == 0) {
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        totalAppointment = totalAppointment + (reportModel.leadsReport!.leadReports![i].lastMonthAppointmentSet ?? 0);
      }
      reports.add(DemoLeadReportModel("aptSet", totalAppointment));
    }
    if (value == 1) {
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalAppointment = totalAppointment + (reportModel.leadsReport!.leadReports![i].yesterdayAppointmentSet ?? 0);
        }
        reports.add(DemoLeadReportModel("aptSet", totalAppointment));
    }
    if (value == 2) {
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalAppointment = totalAppointment + (reportModel.leadsReport!.leadReports![i].daliyAppointmentSet ?? 0);
        }
        reports.add(DemoLeadReportModel("aptSet", totalAppointment));
    }
    if (value == 3) {
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalAppointment = totalAppointment + (reportModel.leadsReport!.leadReports![i].weeklyAppointmentSet ?? 0);
        }
        reports.add(DemoLeadReportModel("aptSet", totalAppointment));
    }
    if (value == 4) {
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalAppointment = totalAppointment + (reportModel.leadsReport!.leadReports![i].monthlyAppointmentSet ?? 0);
        }

        reports.add(DemoLeadReportModel("aptSet", totalAppointment));
    }
    if (value == 5) {
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          totalAppointment = totalAppointment + (reportModel.leadsReport!.leadReports![i].annualyAppointmentSet ?? 0);
        }

        reports.add(DemoLeadReportModel("aptSet", totalAppointment));
    }

    return reports;
  }


  List<DemoLeadReportModel> reportTotalLeadValues(int value,DetailReportModel reportModel) {
    List<DemoLeadReportModel> reports = [];
    totalLeads=0;

    if (value == 0) {
      totalLeads=0;
      int appointment = 0;
      int notContacted = 0;
      int sold = 0;
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        appointment += reportModel.leadsReport!.leadReports![i].lastMonthAppointmentSet ?? 0;
        notContacted += reportModel.leadsReport!.leadReports![i].lastMonthNotContacted ?? 0;
        sold += reportModel.leadsReport!.leadReports![i].lastMonthSaleSold ?? 0;


      }
      totalLeads = appointment + notContacted + sold;
      reports.add(DemoLeadReportModel("aptSet", appointment));
      reports.add(DemoLeadReportModel("notCont", notContacted));
      reports.add(DemoLeadReportModel("sold", sold));

    }

    if (value == 1) {
        totalLeads=0;
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].yesterdayAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].yesterdayNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].daliySold ?? 0;

        }
        totalLeads = appointment + notContacted + sold;
        reports.add(DemoLeadReportModel("aptSet", appointment));
        reports.add(DemoLeadReportModel("notCont", notContacted));
        reports.add(DemoLeadReportModel("sold", sold));

    }
    if (value == 2) {
      totalLeads=0;
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].daliyAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].daliyNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].daliySold ?? 0;
        }

        totalLeads = appointment + notContacted + sold;
        reports.add(DemoLeadReportModel("aptSet", appointment));
        reports.add(DemoLeadReportModel("notCont", notContacted));
        reports.add(DemoLeadReportModel("sold", sold));


    }
    if (value == 3) {
      totalLeads=0;
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].weeklyAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].weeklyNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].weeklySold ?? 0;

        }
        totalLeads = appointment + notContacted + sold;
        reports.add(DemoLeadReportModel("aptSet", appointment));
        reports.add(DemoLeadReportModel("notCont", notContacted));
        reports.add(DemoLeadReportModel("sold", sold));


    }
    if (value == 4) {
      totalLeads=0;
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].monthlyAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].monthlyNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].monthlySaleSold ?? 0;


        }
        totalLeads = appointment + notContacted + sold;
        reports.add(DemoLeadReportModel("aptSet", appointment));
        reports.add(DemoLeadReportModel("notCont", notContacted));
        reports.add(DemoLeadReportModel("sold", sold));

    }
    if (value == 5) {
      totalLeads=0;
        int appointment = 0;
        int notContacted = 0;
        int sold = 0;
        for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
          appointment += reportModel.leadsReport!.leadReports![i].annualyAppointmentSet ?? 0;
          notContacted += reportModel.leadsReport!.leadReports![i].annualyNotContacted ?? 0;
          sold += reportModel.leadsReport!.leadReports![i].annualySold ?? 0;


        }
        totalLeads = appointment + notContacted + sold;
        reports.add(DemoLeadReportModel("aptSet", appointment));
        reports.add(DemoLeadReportModel("notCont", notContacted));
        reports.add(DemoLeadReportModel("sold", sold));

    }
    return reports;
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
  getTypeResource(BuildContext context,String type) async {
    resource=null;
    names.clear();
    allResourcesLists.clear();
    resourcesList.clear();
    await showProgress(context, true);
    await UserVM.getResourcesNew(context).then((value) {
      resource = value;
    });
    if (resource!.isNotEmpty) {
      var json = jsonDecode(resource!);

      json.forEach((key, list) {
        if(key.toString()==type){
          names.add(key.toString());
        }


        var tagObjsJson = json[key] as List;
        resourcesList = tagObjsJson.map((tagJson) => Resource.fromJson(tagJson)).toList();
        allResourcesLists[key] = resourcesList;
      });
    }


    await showProgress(context, false);
    notifyListeners();
  }
}