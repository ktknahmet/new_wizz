import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/organisations/allOrganisations.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseDelete.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseList.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehousePost.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseUpdate.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../model/OLD/User.dart';
import '../adminModel/stockReportModel/stockReportData.dart';
// ignore_for_file: use_build_context_synchronously
class WarehouseVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<WarehouseList>? warehouseList;
  LoginUser? loginUser;
  User? user;
  int index =0;
  int? distId;
  String? distName;
  String? postResponse;
  String? cCountryCode;
  String query ="";
  TextEditingController distInfo = TextEditingController(text:"selectDist".tr());
  List<AllOrganisations>? organisations;
  int type=1;
  int totalAssign=0;
  int totalNotAssign=0;
  List<StockReportDataDetails>? dataDetails;
  List<Map<String, bool>> gridMap = [];

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

  setType(int value){
    type = value;
    notifyListeners();
  }
  setDistIdForReport(String name,int id){
    distInfo.text = name;
    distName = name;
    if(id ==0){
      distId =null;
    }else{
      distId = id;
    }

    notifyListeners();
  }
  setDistId(String name,int id){
    distInfo.text = name;
    distName = name;
    distId = id;
    notifyListeners();
  }
  changeCode(String code){
    cCountryCode = code;
    notifyListeners();
  }
  setQuery(String value){
    query = value;
    notifyListeners();
  }
  getUserInfo(BuildContext context)async{
    SharedPref pref = SharedPref();
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    user ??= await getUserUser(context);
    notifyListeners();
  }


  List<AllOrganisations> searchDist(List<AllOrganisations> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<AllOrganisations> filteredList = list.where((resource) =>
    (resource.name != null && resource.name!.toLowerCase().contains(query.toLowerCase()))).toList();

    return filteredList;
  }

  List<WarehouseList> searchWarehouse(List<WarehouseList> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<WarehouseList> filteredList = list.where((resource) =>
    (resource.warehouseName != null && resource.warehouseName!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.warehouseAdress != null && resource.warehouseAdress!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.warehousePhone != null && resource.warehousePhone!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.warehouseEmail != null && resource.warehouseEmail!.toLowerCase().contains(query.toLowerCase())) ||
    (resource.orgName != null && resource.orgName!.toLowerCase().contains(query.toLowerCase()))).toList();

    return filteredList;
  }
  Future<void>getWarehouse(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    int? distId;
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    user ??= await getUserUser(context);
    if(user!.roleType !="SUPERADMIN"){
      distId = loginUser!.profiles![index].organisation_id;
    }
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      warehouseList = await apiService.getWarehouses(distId);

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

  postWarehouse(BuildContext context,WarehousePost warehousePost) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postWarehouse(warehousePost).then((value) => {
        postResponse =value,
        snackBarDesign(context, StringUtil.success,"warehouseAdded".tr()),
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
  deleteWarehouse(BuildContext context,WarehouseDelete delete) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.deleteWarehouse(delete).then((value) => {
        postResponse =value,
        snackBarDesign(context, StringUtil.success,"deletedWarehouse".tr()),
        getWarehouse(context),

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
  updateWarehouse(BuildContext context,WarehouseUpdate update) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.updateWarehouse(update).then((value) => {
        postResponse =value,
        snackBarDesign(context, StringUtil.success,"warehouseUpdated".tr()),
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

  Future<void>getOrganisations(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      organisations = await apiService.allOrganisations();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        }
      }
    } finally {
      notifyListeners();

    }
  }
  Future<void>stockReportAllData(BuildContext context,String? begin,String? end,int? distId,String? export) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    showProgress(context, true);
    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      dataDetails = await apiService.getStockReportListAllData(begin,end,distId,export);

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