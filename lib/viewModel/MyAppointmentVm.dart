import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/appointmentModel/AppointmentModel.dart';
import 'package:wizzsales/model/appointmentModel/Data.dart';
import 'package:wizzsales/model/appointmentModel/appointmentValues/AppintmentValues.dart';
import 'package:wizzsales/model/appointmentModel/editAppointmentModel/editAppointment.dart';
import 'package:wizzsales/model/appointmentModel/response/responseAppointment.dart';
import 'package:wizzsales/model/demoModel/postLiveDemo.dart';
import 'package:wizzsales/model/detailsReportModel/DetailReportModel.dart';
import 'package:wizzsales/model/leadReportModel/demoLeadReportModel.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously
class MyAppointmentVm extends ChangeNotifier{
  int currentPage=1;
  String? demoResponse;
  SharedPref pref = SharedPref();
  AppointmentModel? appointmentModel;
  List<Data>? allAppointment;
  AppointmentValues? values;
  ResponseAppointment? response;
  DetailReportModel? detailsReportModel;
  TextEditingController daySelect = TextEditingController(text: "daily".tr());
  String type ="daily".tr();
  String leadType="all".tr();
  Map<String,int> chooseLead={};
  int reportIndex=1;
  String query ="";
  dynamic appointmentSetTotal;
  dynamic soldTotal;
  dynamic notContactedTotal;
  List<Map<String, bool>> gridMap = [];
  int aptSet=0;
  int notContacted=0;
  int sold=0;
  int notInterested=0;
  int aptCanceled=0;
  int aptRescheduled=0;
  int notHome=0;
  int dns=0;
  String currentDay=withoutYesterday[1];

  addGridMap(Map<String,bool> map){
    gridMap.add(map);
    notifyListeners();
  }

  setGridMap(String key,bool value) {

    for (int i = 0; i < gridMap.length; i++) {
      if (gridMap[i].containsKey(key)) { // Belirtilen anahtarı içerip içermediğini kontrol et
        gridMap[i][key] = value; // Değerini tersine çevir
      }
    }
    notifyListeners();
  }
  setQuery(String value){
    query = value;
    notifyListeners();
  }
  setLeadType(String type){
    leadType = type;
    notifyListeners();
  }

  List<Data> searchAppointment(List<Data> list, dynamic query) {

    if (query.isEmpty || query=="All") {
      return list;
    }
    List<Data> filteredList = list.where((resource) =>
    (resource.cname != null && resource.cname!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.cphone != null && resource.cphone!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.adate != null && resource.adate!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.orgname != null && resource.orgname!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.cstate != null && resource.cstate!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.czipcode != null && resource.czipcode!.toLowerCase().contains(query.toLowerCase())) ||
    statusCase(resource.astatus!).toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }
  setReportIndex(String value){
    daySelect.text=value;
    type = value;
    if(value=="yesterday".tr()){
      reportIndex=0;
    }
    if(value=="daily".tr()){
      reportIndex=1;
    }
    if(value=="weekly".tr()){
      reportIndex=2;
    }
    if(value=="monthly".tr()){
      reportIndex=3;
    }
    if(value=="annual".tr()){
      reportIndex=4;
    }
    notifyListeners();
  }

 setCurrentPage(int page){
   currentPage = page;
   notifyListeners();
 }


  appointmentTotalValue(int value,DetailReportModel reportModel){
    currentDay = withoutYesterday[value];
    aptSet=0;
    notContacted=0;
    sold=0;
    notInterested=0;
    aptCanceled=0;
    aptRescheduled=0;
    notHome=0;
    dns=0;

    if(value==0){
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        aptSet =aptSet+ (reportModel.leadsReport!.leadReports![i].lastMonthAppointmentSet ?? 0);
        notContacted =notContacted+ (reportModel.leadsReport!.leadReports![i].lastMonthNotContacted ?? 0);
        sold =sold+ (reportModel.leadsReport!.leadReports![i].lastMonthSold ?? 0);
        notInterested =notInterested+ (reportModel.leadsReport!.leadReports![i].lastMonthNotInterested ?? 0);
        aptCanceled =aptCanceled+ (reportModel.leadsReport!.leadReports![i].lastMonthAptCanceled ?? 0);
        aptRescheduled =aptRescheduled+ (reportModel.leadsReport!.leadReports![i].lastMonthAptRescheduled ?? 0);
        notHome =notHome+ (reportModel.leadsReport!.leadReports![i].lastMonthNotHome ?? 0);
        dns =dns+ (reportModel.leadsReport!.leadReports![i].lastMonthDns ?? 0);
      }
    }

    if(value==1){
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        aptSet =aptSet+ (reportModel.leadsReport!.leadReports![i].daliyAppointmentSet ?? 0);
        notContacted =notContacted+ (reportModel.leadsReport!.leadReports![i].daliyNotContacted ?? 0);
        sold =sold+ (reportModel.leadsReport!.leadReports![i].daliySold ?? 0);
        notInterested =notInterested+ (reportModel.leadsReport!.leadReports![i].daliyNotInterested ?? 0);
        aptCanceled =aptCanceled+ (reportModel.leadsReport!.leadReports![i].daliyAptCanceled ?? 0);
        aptRescheduled =aptRescheduled+ (reportModel.leadsReport!.leadReports![i].daliyAptRescheduled ?? 0);
        notHome =notHome+ (reportModel.leadsReport!.leadReports![i].daliyNotHome ?? 0);
        dns =dns+ (reportModel.leadsReport!.leadReports![i].daliyDns ?? 0);
      }
    }

    if(value==2){
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        aptSet =aptSet+ (reportModel.leadsReport!.leadReports![i].weeklyAppointmentSet ?? 0);
        notContacted =notContacted+ (reportModel.leadsReport!.leadReports![i].weeklyNotContacted ?? 0);
        sold =sold+ (reportModel.leadsReport!.leadReports![i].weeklySold ?? 0);
        notInterested =notInterested+ (reportModel.leadsReport!.leadReports![i].weeklyNotInterested ?? 0);
        aptCanceled =aptCanceled+ (reportModel.leadsReport!.leadReports![i].weeklyAptCanceled ?? 0);
        aptRescheduled =aptRescheduled+ (reportModel.leadsReport!.leadReports![i].weeklyAptRescheduled ?? 0);
        notHome =notHome+ (reportModel.leadsReport!.leadReports![i].weeklyNotHome ?? 0);
        dns =dns+ (reportModel.leadsReport!.leadReports![i].weeklyDns ?? 0);
      }
    }
    if(value==3){
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        aptSet =aptSet+ (reportModel.leadsReport!.leadReports![i].monthlyAppointmentSet ?? 0);
        notContacted =notContacted+ (reportModel.leadsReport!.leadReports![i].monthlyNotContacted ?? 0);
        sold =sold+ (reportModel.leadsReport!.leadReports![i].monthlySaleSold ?? 0);
        notInterested =notInterested+ (reportModel.leadsReport!.leadReports![i].monthlyNotInterested ?? 0);
        aptCanceled =aptCanceled+ (reportModel.leadsReport!.leadReports![i].monthlyNotAptCanceled ?? 0);
        aptRescheduled =aptRescheduled+ (reportModel.leadsReport!.leadReports![i].monthlyNotAptRescheduled ?? 0);
        notHome =notHome+ (reportModel.leadsReport!.leadReports![i].monthlyNotHome ?? 0);
        dns =dns+ (reportModel.leadsReport!.leadReports![i].monthlyDns ?? 0);
      }
    }

    if(value==4){
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        aptSet =aptSet+ (reportModel.leadsReport!.leadReports![i].annualyAppointmentSet ?? 0);
        notContacted =notContacted+ (reportModel.leadsReport!.leadReports![i].annualyNotContacted ?? 0);
        sold =sold+ (reportModel.leadsReport!.leadReports![i].annualySold ?? 0);
        notInterested =notInterested+ (reportModel.leadsReport!.leadReports![i].annualyNotInterested ?? 0);
        aptCanceled =aptCanceled+ (reportModel.leadsReport!.leadReports![i].annualyAptCanceled ?? 0);
        aptRescheduled =aptRescheduled+ (reportModel.leadsReport!.leadReports![i].annualyAptRescheduled ?? 0);
        notHome =notHome+ (reportModel.leadsReport!.leadReports![i].annualyNotHome ?? 0);
        dns =dns+ (reportModel.leadsReport!.leadReports![i].annualyDns ?? 0);
      }
    }

    notifyListeners();
  }

  List<DemoLeadReportModel> reportValues(int value,DetailReportModel reportModel){
    List<DemoLeadReportModel> reports = [];

    if (value == 0) {
      int appointment = 0;
      int notContacted = 0;
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        appointment = appointment + (reportModel.leadsReport!.leadReports![i].yesterdayAppointmentSet ?? 0);
        notContacted = notContacted + (reportModel.leadsReport!.leadReports![i].yesterdayNotContacted ?? 0);
      }


      reports.add(DemoLeadReportModel("appointmentSet", appointment));
      reports.add(DemoLeadReportModel("notContacted", notContacted));

    }
    if (value == 1) {

      int appointment = 0;
      int notContacted = 0;
      int sold = 0;
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        appointment = appointment + (reportModel.leadsReport!.leadReports![i].daliyAppointmentSet ?? 0);
        notContacted = notContacted + (reportModel.leadsReport!.leadReports![i].daliyNotContacted ?? 0);
        sold = sold + (reportModel.leadsReport!.leadReports![i].daliySold ?? 0);
      }

      reports.add(DemoLeadReportModel("appointmentSet", appointment));
      reports.add(DemoLeadReportModel("notContacted", notContacted));
      reports.add(DemoLeadReportModel("sold", sold));


    }
    if (value == 2) {

      int appointment = 0;
      int notContacted = 0;
      int sold = 0;
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        appointment = appointment + (reportModel.leadsReport!.leadReports![i].weeklyAppointmentSet ?? 0);
        notContacted = notContacted + (reportModel.leadsReport!.leadReports![i].weeklyNotContacted ?? 0);
        sold = sold + (reportModel.leadsReport!.leadReports![i].weeklySold ?? 0);
      }

      reports.add(DemoLeadReportModel("appointmentSet", appointment));
      reports.add(DemoLeadReportModel("notContacted", notContacted));
      reports.add(DemoLeadReportModel("sold", sold));


    }
    if (value == 3) {
      int appointment = 0;
      int notContacted = 0;
      int sold = 0;
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        appointment = appointment + (reportModel.leadsReport!.leadReports![i].monthlyAppointmentSet ?? 0);
        notContacted = notContacted + (reportModel.leadsReport!.leadReports![i].monthlyNotContacted ?? 0);
        sold = sold + (reportModel.leadsReport!.leadReports![i].monthlySaleSold ?? 0);
      }


      reports.add(DemoLeadReportModel("appointmentSet", appointment));
      reports.add(DemoLeadReportModel("notContacted", notContacted));
      reports.add(DemoLeadReportModel("sold", sold));


    }
    if (value == 4) {

      int appointment = 0;
      int notContacted = 0;
      int sold = 0;
      for (int i = 0; i < reportModel.leadsReport!.leadReports!.length; i++) {
        appointment = appointment + (reportModel.leadsReport!.leadReports![i].annualyAppointmentSet ?? 0);
        notContacted = notContacted + (reportModel.leadsReport!.leadReports![i].annualyNotContacted ?? 0);
        sold = sold + (reportModel.leadsReport!.leadReports![i].annualySold ?? 0);
      }


      reports.add(DemoLeadReportModel("appointmentSet", appointment));
      reports.add(DemoLeadReportModel("notContacted", notContacted));
      reports.add(DemoLeadReportModel("sold", sold));


    }
    notifyListeners();
    return reports;
  }



  Future<void>postAppointment(BuildContext context,EditAppointmentModel appointmentModel) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    await showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
     response = await apiService.postAppointment(appointmentModel);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
           snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {

        }
      } else {
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();

    }

  }

  Future<void>appointmentValue(BuildContext context,int id) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      values = await apiService.editAppointment(id);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

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
  getAllAppointment(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);


    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      allAppointment = await apiService.getAllAppointment();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

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

   getAppointment(BuildContext context,int page) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);


    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      appointmentModel = await apiService.getAppointment(page);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

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
  postStartDemo(BuildContext context,PostLiveDemo demo) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postStartDemo(demo).then((value) => {
        demoResponse =value,
        snackBarDesign(context, StringUtil.success, "demoAdded".tr()),
        Navigator.pop(context),

      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();

    }

  }

}