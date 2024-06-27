// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminBonus/bonusModel.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusOverlapping.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusRuleList.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusTypes.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusWinnerList.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/postBonus.dart';
import 'package:wizzsales/adminPage/adminModel/roles/allRoles.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/organisations/allOrganisations.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/model/bonusWinnerModel/bonusWinnerDealer.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AdminBonusVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<AllRoles>? allRoles;
  List<BonusWinnerList>? bonusWinnerList;
  List<BonusWinnerDealerList>? bonusWinnerDealerList;
  List<BonusRuleList>? bonusRoleList;
  List<BonusTypes>? bonusTypes;
  String? selectedBonus;
  String? role;
  int? roleId;
  List<BonusModel> list=[];
  String query="";
  String? overlappingResponse;
  String? postBonusResponse;
  bool checkSave=true;
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

  setCheckSave(bool type){
    checkSave = type;
    notifyListeners();
  }
  setQuery(String value){
    query = value;
    notifyListeners();
  }
  addList(BonusModel model){
    list.add(model);
    print("liste boyutu :${list.length}");
    notifyListeners();
  }
  clearValues(){
    roleId=null;
    role=null;
    selectedBonus=null;
    notifyListeners();

    notifyListeners();
  }
  deleteList(int index){
    list.removeAt(index);
    notifyListeners();
  }
  setBonusType(String value){
    selectedBonus = value;
    notifyListeners();
  }

  setRole(String value){
    role = value;
    roleId = allRoles!
        .firstWhere((type) => type.viewName == value)
        .id;
    notifyListeners();
  }

  List<AllOrganisations> searchOrgList(List<AllOrganisations> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<AllOrganisations> filteredList = list.where((resource) =>
        resource.name!.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }

  List<BonusWinnerList> searchWinner(List<BonusWinnerList> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<BonusWinnerList> filteredList = list.where((resource) =>
    (resource.roleName != null && resource.roleName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.vestingDate != null && resource.vestingDate!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.userName != null && resource.userName!.toLowerCase().contains(query.toLowerCase()))

    ).toList();

    return filteredList;
  }

  List<BonusRuleList> searchRoleList(List<BonusRuleList> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<BonusRuleList> filteredList = list.where((resource) =>
    (resource.roleName != null && resource.roleName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.bonusType != null && resource.bonusType!.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    return filteredList;
  }

  List<BonusWinnerDealerList> searchBonusWinnerDealer(List<BonusWinnerDealerList> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<BonusWinnerDealerList> filteredList = list.where((resource) =>
    (resource.roleName != null && resource.roleName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.bonusType != null && resource.bonusType!.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    return filteredList;
  }

  Future<void>getRoleList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      allRoles = await apiService.getAllRoles();

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

  //dealerlar için winnerlar
  Future<void>getBonusWinnerDealer(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      bonusWinnerDealerList = await apiService.getBonusWinnerDealer();

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

  Future<void>getBonusWinner(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      bonusWinnerList = await apiService.getBonusWinner();

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

  //role list
  Future<void>getBonusRule(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      bonusRoleList = await apiService.getBonusRule();

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

  //bonus types
  Future<void>getBonusTypes(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      bonusTypes = await apiService.getBonusTypes();

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
  //post overlapping
  postOverlapping(BuildContext context,BonusOverlapping post,Function function) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postOverlapping(post).then((value) => {
        overlappingResponse = value,
        function()
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
  //post Bonus
  postBonus(BuildContext context,PostBonus post,Function function) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postBonus(post).then((value) => {
        postBonusResponse = value,
        snackBarDesign(context, StringUtil.success, "bonusAdded".tr()),
        function(),
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