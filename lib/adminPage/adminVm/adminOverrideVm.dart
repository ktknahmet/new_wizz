import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comSaleDetails/ComSaleDetails.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/allOverride.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/orgDetails.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideReports.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideType.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserDelete.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserList.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserPost.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideWinner.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/postOverride.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/postProductCoast.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/productCoastList.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/updateProductCoast.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/allUsers/allUser.dart';
import 'package:wizzsales/model/overrideModel/dealerOverrideWinner.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../model/OLD/register/LoginUser.dart';
import '../adminModel/overrideModel/deleteOverrideConfig.dart';
import '../adminModel/overrideModel/updateOverrideConfig.dart';
// ignore_for_file: use_build_context_synchronously

class AdminOverrideVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<OverrideType>? overrideType;
  List<AllOverride>? allOverride;
  int? selectedOverrideTypeId;
  String? selectedOverrideTypeName;
  List<AdminOverrideWinner>? overrideWinner;
  List<DealerOverrideWinner>? dealerOverrideWinner;
  List<OverrideUserList>? overrideUserList;
  String query="";
  List<OverrideTypes> overrideTypes=[];
  List<AllUsers>? allUsers;
  List<OrgDetails>? organisations;
  List<ProductCoastList>? productCoast;
  OverrideReports? overrideReports;
  TextEditingController userName = TextEditingController(text:"selectUser".tr());
  TextEditingController distName = TextEditingController(text:"selectDist".tr());
  TextEditingController payDate = TextEditingController();
  TextEditingController overrideUser = TextEditingController();
  dynamic totalOverrideDetails=0;
  int? distId;
  int? userId;
  User? user;
  LoginUser? loginUser;
  int index=0;
  dynamic totalPaid=0;
  dynamic totalUnPaid =0;
  String currentDay=overrideSummary[0];
  List<String> search =[];
  List<Map<String, bool>> gridMap = [];
  int? overrideUserId;

  checkOverrideUser(BuildContext context,List<int> userId)async{

    if(overrideUserList !=null){
      if(overrideUserList!.isNotEmpty){
        for(int i=0;i<overrideUserList!.length;i++){
          for(int j=0;j<userId.length;j++){

            if(overrideUserList![i].id == userId[j]){
              print("talha can ${overrideUserList![i].id} -- ${userId[j]}");
              overrideUserId = overrideUserList![i].id;
            }
          }

        }
      }
    }
   notifyListeners();

  }
  setOverrideWinner(){
    payDate.clear();
    overrideWinner = null;
    notifyListeners();
  }
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

  setPaidUnPaid(int type){
    if(type==0){
      currentDay = overrideSummary[0];
      totalPaid = overrideReports!.totalPaidPreviousMonth ?? 0;
      totalUnPaid = overrideReports!.totalUnpaidPreviousMonth ?? 0;

    }
    if(type==1){
      currentDay = overrideSummary[1];
      totalPaid = overrideReports!.totalPaidAnnual ?? 0;
      totalUnPaid = overrideReports!.totalUnpaidAnnual ?? 0;

    }

    notifyListeners();
  }

  setUser(String name,int id){
    userName.text = name;
    userId = id;
    notifyListeners();
  }
  setDist(String name,int id){
    distName.text = name;
    distId = id;
    notifyListeners();
  }


  addOverrideTypes(OverrideTypes types){
    overrideTypes.add(types);
    notifyListeners();
  }
  deleteList(int index){
    overrideTypes.removeAt(index);
    notifyListeners();
  }

  setQuery(String value){
    query = value;
    notifyListeners();
  }

  List<ProductCoastList> searchProductCoast(List<ProductCoastList> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<ProductCoastList> filteredList = list.where((resource) =>
    (resource.productName != null && resource.productName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.distName != null && resource.distName!.toLowerCase().contains(query.toLowerCase()))).toList();

    return filteredList;
  }

  List<OverrideUserList> searchUserList(List<OverrideUserList> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<OverrideUserList> filteredList = list.where((resource) =>
    (resource.name != null && resource.name!.toLowerCase().contains(query.toLowerCase()))).toList();

    return filteredList;
  }

  List<AllUsers> selectUserList(List<AllUsers> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<AllUsers> filteredList = list.where((resource) =>
    resource.name!.toLowerCase().contains(query.toLowerCase()) ||
        (resource.menuRoles != null && resource.menuRoles!.toLowerCase().contains(query.toLowerCase()))).toList();

    return filteredList;
  }
  List<OrgDetails> searchOrgList(List<OrgDetails> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<OrgDetails> filteredList = list.where((resource) =>
    (resource.userName != null && resource.userName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.organisationName != null && resource.organisationName!.toLowerCase().contains(query.toLowerCase()))).toList();

    return filteredList;
  }

  List<DealerOverrideWinner> searchDealerWinner(List<DealerOverrideWinner> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<DealerOverrideWinner> filteredList = list.where((resource) =>
    (resource.serialNumber != null && resource.serialNumber!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.organisationName != null && resource.organisationName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.organisationName != null && resource.organisationName!.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    return filteredList;
  }

  List<AllOverride> searchOverride(List<AllOverride> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<AllOverride> filteredList = list.where((resource) =>
    (resource.organisationName != null && resource.organisationName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.overrideType != null && resource.overrideType!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.userName != null && resource.userName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.productName != null && resource.productName!.toLowerCase().contains(query.toLowerCase()))).toList();

    return filteredList;
  }
  List<String> searchName(List<String> list, String query) {
    if ( query.isEmpty) {
      return list;
    }
      List<String> filteredList = list.where((resource) =>
      (resource.toLowerCase().contains(query.toLowerCase()))).toList();
    return filteredList;
  }

  List<AdminOverrideWinner> searchWinner(List<AdminOverrideWinner> list, String query) {
    if (query.isEmpty || query =="All") {
      return list;
    }
    List<AdminOverrideWinner> filteredList = list.where((resource) =>
    (resource.organisationName != null && resource.organisationName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.overrideType != null && resource.overrideType!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.userName != null && resource.userName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.productName != null && resource.productName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.serialNumber != null && resource.serialNumber!.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    return filteredList;
  }


   setSelectedOverrideType(String overrideTypeName) {
    selectedOverrideTypeId = overrideType!
        .firstWhere((type) => type.overrideTypeName == overrideTypeName)
        .overrideTypeId;

    selectedOverrideTypeName = overrideTypeName;
    notifyListeners();
  }

  //allUser
  Future<void>getAllUser(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      allUsers = await apiService.getAllUser();

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
  //override tipleri
  Future<void>getOverrideTypes(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      overrideType = await apiService.getOverrideTypes();

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


  Future<void>getOverrideReports(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      overrideReports =  await apiService.getOverrideReports();
      setPaidUnPaid(0);

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
  //dealerlar için override winner
  Future<void>getOverrideWinnerDealer(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.getDealerOverrideWinner().then((value) {
        dealerOverrideWinner = value;
      });

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
  //distributorler
  Future<void>getOrganisations(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.getOrgDetails().then((value) {
        organisations = value;
      });

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

  //overrideList
  Future<void>getOverrideList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      allOverride = await apiService.allOverride();

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

  //override winner
  Future<void>getOverrideWinner(BuildContext context,String? beginDate,String? endDate,int? userId) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);


    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      overrideWinner = await apiService.getOverrideWinner(beginDate,endDate,userId);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
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
  //override winnerDetail
  Future<void>getOverrideWinnerDetail(BuildContext context,String? payDate) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      overrideWinner = await apiService.getOverrideWinnerDetail(payDate);

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
  //override post etme
  postOverride(BuildContext context,PostOverride postOverride) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postOverride(postOverride).then((value) => {
        Navigator.pop(context),
        snackBarDesign(context, StringUtil.success,"overrideAdded".tr()),
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
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

  //product coastList
  Future<void>getProductCoast(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    user ??= await getUserUser(context);
    int? id;
    if(user!.roleType !="SUPERADMIN"){
      id= loginUser!.profiles![index].organisation_id;
    }
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      productCoast = await apiService.getProductCoast(id);

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
  //update productCoast
  updateProduct(BuildContext context,UpdateProductCoast update) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.updateProductCoast(update).then((value) => {
        getProductCoast(context),
        snackBarDesign(context, StringUtil.success,"updated".tr()),

      });
    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
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
  //post Product coast
  postProductCoast(BuildContext context,PostProductCoast post) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postProductCoast(post).then((value) => {
        Navigator.pop(context),
        snackBarDesign(context, StringUtil.success,"addedProductCoast".tr()),

      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
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
  //override userları
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
  //override userları silme
  deleteOverrideUser(BuildContext context,OverrideUserDelete delete) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.deleteOverrideUser(delete).then((value) => {

        snackBarDesign(context, StringUtil.success,"userDeleted".tr()),
        getOverrideUser(context),

      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
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
  //override user post
  postOverrideUser(BuildContext context,OverrideUserPost post) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postOverrideUser(post).then((value) => {
        Navigator.pop(context),
        snackBarDesign(context, StringUtil.success,"userAdded".tr()),
        getOverrideUser(context),
      });
    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
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
  deletedConfig(BuildContext context,DeleteOverrideConfig deleteConfig,Function() func) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.deleteOverrideConfig(deleteConfig).then((value) => {

        snackBarDesign(context, StringUtil.success,"deletedOverrideConfig".tr()),
        func()

      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
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
  updateConfig(BuildContext context,UpdateOverrideConfig updateConfig,Function() func) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.updateOverrideConfig(updateConfig).then((value) => {
        Navigator.pop(context),
        snackBarDesign(context, StringUtil.success,"updatedOverrideConfig".tr()),
        func()

      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
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