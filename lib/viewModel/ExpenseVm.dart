import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:retrofit/dio.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/model/expenseModel/allExpenseModel.dart';
import 'package:wizzsales/model/expenseModel/expenseSale.dart';
import 'package:wizzsales/model/expenseModel/expenseTypes.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../widgets/Constant.dart';
// ignore_for_file: use_build_context_synchronously
class ExpenseVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<AllExpenseModel>? allExpense;
  List<AllExpenseModel>? expenseReport;
  List<ExpenseType>? expenseType;
  List<ExpenseSale>? expenseSale;
  HttpResponse? response;
  int? eType;
  String? eName;
  String expenses="All";
  String query="";
  int? id;
  int total =0;
  TextEditingController saleId=TextEditingController();
  File? selectImage;


  setTotal(List<AllExpenseModel> list ,String name){
    total=0;
    if(name =="all".tr()){

      for(int i=0;i<list.length;i++){
          double a = double.parse(list[i].expenseNetPrice ?? "0");
          int b = a.toInt();
          total = total + b;

      }
    }else{
      for(int i=0;i<list.length;i++){
        if(list[i].expenseName == name){
          double a = double.parse(list[i].expenseNetPrice ?? "0");
          int b = a.toInt();
          total = total + b;
        }
      }
    }

    notifyListeners();
  }
  setExpenseType(int? type){
    eType = type;
    notifyListeners();
  }
  setExpenseName(String name){
    eName = name;
    notifyListeners();
  }
  setExpenses(String name){
    expenses = name;
    notifyListeners();
  }
  setImage(File value){
    selectImage = value;
  }
  deleteImage(){
    selectImage =null;
  }
  setQuery(String value){
    query = value;
    notifyListeners();
  }
  setSaleId(String name,String sale){
    saleId.text = "$name / $sale";
    notifyListeners();
  }
  setId(int idd){
    id = idd;
    notifyListeners();
  }
  List<AllExpenseModel> expenseDetails(List<AllExpenseModel> list, String type) {

    if (type.isEmpty || type=="All") {
      return list;
    }
    List<AllExpenseModel> filteredList = list.where((resource) =>
    resource.expenseName!.toLowerCase().contains(type.toLowerCase())).toList();

    return filteredList;
  }

  List<ExpenseSale> searchSaleList(List<ExpenseSale> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<ExpenseSale> filteredList = list.where((resource) =>
        resource.cname!.toLowerCase().contains(query.toLowerCase()) || resource.serialid!.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }

  Future<void>getExpense(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);


    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      allExpense = await apiService.getAllExpense();

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
      notifyListeners();

    }

  }
  Future<void>allExpenseReport(BuildContext context,String startDate,String endDate) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      expenseReport = await apiService.getAllExpenseReport(startDate,endDate);

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
  getExpenseSale(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      expenseSale = await apiService.saleList();

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
  getExpenseType(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      expenseType = await apiService.expenseTypes();

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
  postExpense(BuildContext context,int typeId,int userId,int? saleId,double netPrice,double taxPrice,String date,File photo,int? startMil,int? endMil) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    int orgId = await pref.getInt(context, SharedUtils.orgId);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    showProgress(context, true);
    notifyListeners();
    try {
      await apiService.postExpensesData(typeId, userId, saleId, orgId, netPrice,taxPrice,date, photo,startMil,endMil).then((value) {
        response = value;
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
      showProgress(context, false);
      notifyListeners();

    }
  }
}