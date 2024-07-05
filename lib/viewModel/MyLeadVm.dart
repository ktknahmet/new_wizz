import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/OLD/leadReport/LeadReport.dart';
import 'package:wizzsales/model/leadModel/leadStatusList.dart';
import 'package:wizzsales/model/leadModel/leadStatusPost.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../model/OLD/leadReport/Lead.dart';
// ignore_for_file: use_build_context_synchronously
class MyLeadVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<LeadReport>? leadReports;
  List<String> chooseLead=[];
  List<LeadStatusList>? leadStatusList;
  String query ="";
  String leadType="All";
  List<Map<String, bool>> gridMap = [];
  int totalLead=0;
  int aptSet=0;
  int notContacted=0;
  int sold =0;
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
  List<LeadReport> searchLead(List<LeadReport> list, String query) {

    if (query.isEmpty || query=="All") {
      return list;
    }
    List<LeadReport> filteredList = list.where((value) =>
        value.lead_type_name!.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }

  List<LeadStatusList> searchLeadStatus(List<LeadStatusList> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<LeadStatusList> filteredList = list.where((resource) =>
    (resource.name != null && resource.name!.toLowerCase().contains(query.toLowerCase()))).toList();

    return filteredList;
  }
  List<Lead> searchLeadDetails(List<Lead> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<Lead> filteredList = list.where((resource) =>
    (resource.cphone != null && resource.cphone!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.cname != null && resource.cname!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.cname != null && resource.cname!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.cemail != null && resource.cemail!.toLowerCase().contains(query.toLowerCase()))  ||
        (resource.ccity != null && resource.ccity!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.date != null && resource.date!.toLowerCase().contains(query.toLowerCase()))).toList();

    return filteredList;
  }

  leadReportName(int type){
    String value="";
    switch(type){
      case 0:
        value= "totalLeadCount".tr();
        return value;
      case 1:
        value= "appointmentSet".tr();
        return value;
      case 2:
        value= "notContacted".tr();
        return value;
      case 3:
        value= "sold".tr();
        return value;


    }
  }

  leadReportValue(List<LeadReport> report,String name){
    totalLead =0;
    aptSet =0;
    notContacted =0;
    sold =0;
    if(name !="All"){

      for(int i=0;i<report.length;i++){
        if(report[i].lead_type_name == name){

          sold = sold+(report[i].sold_count ?? 0);
          aptSet = aptSet+(report[i].appointment_set_count ?? 0);
          totalLead = totalLead+(report[i].leads!.length);
          notContacted = notContacted+(report[i].not_contacted_lead_count ?? 0);
        }
      }

    }
    else{

      for(int i=0;i<report.length;i++){

        aptSet = aptSet+(report[i].appointment_set_count ?? 0);
        notContacted = notContacted+(report[i].not_contacted_lead_count ?? 0);
        sold = sold+(report[i].sold_count ?? 0);
        totalLead = totalLead+(report[i].leads!.length);
      }

    }
    notifyListeners();

  }

  Future<void>allLeadReport(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      leadReports = await apiService.getAllLeads();

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
  Future<void>getLeadStatus(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      leadStatusList = await apiService.getLeadStatus();

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
  updateLeadStatus(BuildContext context,LeadStatusPost post) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postLeadStatus(post).then((value) => {

        snackBarDesign(context, StringUtil.success, "updated".tr()),
        Navigator.pop(context),

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
      showProgress(context, false);
      notifyListeners();

    }

  }
}