import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/checkComAdd.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comAmount.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comDetails.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comExist.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comInactive.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comRateExtendDate.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comReportModel.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comSaleDetails/ComSaleDetails.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionList.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionPost.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionTypes.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionWinner.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPeriod/getPayPeriod.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPeriod/postPayPeriod.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPost.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/postAdjust.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/updateComRate.dart';
import 'package:wizzsales/adminPage/adminModel/roles/allRoles.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/stockDealer/stockDealer.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class CommissionVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  LoginUser? loginUser;
  int index=0;
  List<CommisionList>? commission;
  GetPayPeriod? getPayPeriod;
  ComDetails? comDetails;
  List<AllRoles>? allRoles;
  String? responseExist;
  int? addCom;
  List<CommissionWinner>? commissionWinner;
  List<ComSaleDetails>? saleDetails;
  List<ComReportModel>? commissionReport;
  List<CommisionTypes>? commissionTypes;
  List<StockDealer>? stockDealer;
  String? commissionResponse;
  int? profileId;
  int? roleId;
  String query="";
  String profileQuery="";
  int? type;
  String? periodType;
  String? periodDay;
  int? comtype;
  TextEditingController typeInfo = TextEditingController();
  TextEditingController payDate = TextEditingController();
  List<Amount> amounts=[];
  List<Map<String, bool>> gridMap = [];
  dynamic paidCom=0;
  dynamic unPaidCom=0;
  dynamic totalPaid=0;
  dynamic totalUnPaid =0;
  Map<String,dynamic> periodDate={};
  String currentDay=comSummary[1];
  List<bool> comDetail=[];


  addComDetail(int v){
    comDetail.clear();
    for(int i=0;i<v;i++){
      comDetail.add(false);
    }
    notifyListeners();
  }
  setComDetail(int index){
    comDetail[index] =!comDetail[index];
    notifyListeners();
  }

  String paidUnPaid="All";
  List<String> paidUnPaidList=["All","Paid","UnPaid","Da","Dealer","Team-Leader","Leader","Sales-Manager","Dps","Distributor"];

  getOrgName(BuildContext context)async{
    SharedPref pref = SharedPref();
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    notifyListeners();
  }
  setPaidUnpaid(String value){
    paidUnPaid = value;
    notifyListeners();
  }
  setPaidCom(dynamic totalPaid,dynamic unPaid){
    paidCom = totalPaid;
    unPaidCom = unPaid;
    notifyListeners();
  }
  setPayDate(String date){
    payDate.text = date;
    notifyListeners();
  }
  setPeriodDay(String day){
    periodDay = day;
    notifyListeners();
  }
  setPeriodType(String type){
    periodType = type;
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
  setType(int value){
    type = value;
    notifyListeners();
  }
  setComType(int value){
    comtype = value;
    notifyListeners();
  }
  setList(BuildContext context,Amount model){
    bool check=false;
    if(amounts.isEmpty){
      amounts.add(model);
    }else{
      for(int i=0;i<amounts.length;i++){
        if(amounts[i].amountLevel1! <= model.amountLevel2! && amounts[i].amountLevel2! >= model.amountLevel1!){
          check = true;
        }
      }
      if(check){
        snackBarDesign(context, StringUtil.error, "canNotAddSameValue".tr());
      }else{
        amounts.add(model);
      }
    }

    notifyListeners();
  }
  deleteList(int index){
    amounts.removeAt(index);
    notifyListeners();
  }

  setQuery(String value){
    query = value;
    notifyListeners();
  }

  setProfileQuery(String value){
    profileQuery = value;
    notifyListeners();
  }
  setRoleId(int id,String value){
    typeInfo.text = value;
    profileId=null;
    roleId = id;
    notifyListeners();
  }
  setProfileId(int id,String value){
    typeInfo.text = value;
    roleId = null;
    profileId = id;
    notifyListeners();
  }

  setPaidUnPaidCom(int type){
    if(type==0){
      currentDay = comSummary[0];
      totalPaid = comDetails!.paidComDaily ?? 0;
      totalUnPaid = comDetails!.notPaidComDaily ?? 0;

    }
    if(type==1){
      currentDay = comSummary[1];
      totalPaid = comDetails!.paidComWeekly ?? 0;
      totalUnPaid = comDetails!.notPaidComWeekly ?? 0;

    }
    if(type==2){
      currentDay = comSummary[2];
      totalPaid = comDetails!.paidComMonthly ?? 0;
      totalUnPaid = comDetails!.notPaidComMonthly ?? 0;

    }
    if(type==3){
      currentDay = comSummary[3];
      totalPaid = comDetails!.paidComAnnual ?? 0;
      totalUnPaid = comDetails!.notPaidComAnnual ?? 0;

    }
    notifyListeners();
  }

  List<CommissionWinner> searchAllCom(List<CommissionWinner> list, String query) {
    if (query.isEmpty) {
      return list;
    }

    print("Initial list length: ${list.length}");
    print("Query: $query");

    List<CommissionWinner> filteredList = [];

    if (query == "Paid") {
      filteredList = list.where((resource) => resource.isCommPaid == true).toList();
    } else if (query == "UnPaid") {
      filteredList = list.where((resource) => resource.isCommPaid == false).toList();
    } else if (query == "Da") {
      filteredList = list.where((resource) => resource.eligibleRoleName?.toLowerCase() == "da").toList();
    } else if (query == "Dealer") {
      filteredList = list.where((resource) => resource.eligibleRoleName?.toLowerCase() == "dealer").toList();
    } /*else if (query == "Team-Leader") {
      filteredList = list.where((resource) => resource.eligibleRoleName!.toLowerCase() == "team-leader").toList();
    } */else if (query == "Leader") {
      filteredList = list.where((resource) => resource.eligibleRoleName?.toLowerCase() == "leader").toList();
    } else if (query == "Sales-Manager") {
      filteredList = list.where((resource) => resource.eligibleRoleName?.toLowerCase() == "sales-manager").toList();
    } else if (query == "Dps") {
      filteredList = list.where((resource) => resource.eligibleRoleName?.toLowerCase() == "dps").toList();
    } else if (query == "Distributor") {
      filteredList = list.where((resource) => resource.eligibleRoleName?.toLowerCase() == "distributor").toList();
    } else if (query == "All") {
      return list;
    } else {
      filteredList = list.where((resource) =>
      (resource.userName?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (resource.comType?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (resource.profileMenurole?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (resource.saleSerialNumber?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (resource.eligibleRoleName?.toLowerCase().contains(query.toLowerCase()) ?? false)
      ).toList();
    }

    print("Filtered list length: ${filteredList.length}");
    return filteredList;
  }
  List<CommissionWinner> searchComWinner(List<CommissionWinner> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    if(query =="Paid"){
      List<CommissionWinner> filteredList = list.where((resource) =>
      (resource.isCommPaid != null && resource.isCommPaid == true)).toList();
      print("query :$query -- ${filteredList.length}");
      return filteredList;
    }
    if(query =="UnPaid"){
      List<CommissionWinner> filteredList = list.where((resource) =>
      (resource.isCommPaid != null && resource.isCommPaid == false)).toList();

      return filteredList;
    }
    if(query =="Da"){
      List<CommissionWinner> filteredList = list.where((resource) =>
      (resource.eligibleRoleName != null && resource.eligibleRoleName == "da")).toList();

      return filteredList;
    }
    if(query =="Dealer"){
      List<CommissionWinner> filteredList = list.where((resource) =>
      (resource.eligibleRoleName != null && resource.eligibleRoleName == "dealer")).toList();

      return filteredList;
    }
    if(query =="Team-Leader"){
      List<CommissionWinner> filteredList = list.where((resource) =>
      (resource.eligibleRoleName != null && resource.eligibleRoleName!.contains("team"))).toList();

      return filteredList;
    }
    if(query =="Leader"){
      List<CommissionWinner> filteredList = list.where((resource) =>
      (resource.eligibleRoleName != null && resource.eligibleRoleName == "leader")).toList();

      return filteredList;
    }
    if(query =="Sales-Manager"){
      List<CommissionWinner> filteredList = list.where((resource) =>
      (resource.eligibleRoleName != null && resource.eligibleRoleName == "sales-manager")).toList();

      return filteredList;
    }
    if(query =="Dst"){
      List<CommissionWinner> filteredList = list.where((resource) =>
      (resource.eligibleRoleName != null && resource.eligibleRoleName == "dst")).toList();

      return filteredList;
    }
    if(query =="Distributor"){
      List<CommissionWinner> filteredList = list.where((resource) =>
      (resource.eligibleRoleName != null && resource.eligibleRoleName == "distributor")).toList();

      return filteredList;
    }

     if(query =="All"){
      return list;
     }else{
       List<CommissionWinner> filteredList = list.where((resource) =>
       (resource.userName != null && resource.userName!.toLowerCase().contains(query.toLowerCase())) ||
       (resource.comType != null && resource.comType!.toLowerCase().contains(query.toLowerCase())) ||
       (resource.profileMenurole != null && resource.profileMenurole!.toLowerCase().contains(query.toLowerCase())) ||
       (resource.saleSerialNumber != null && resource.saleSerialNumber!.toLowerCase().contains(query.toLowerCase())) ||
       (resource.eligibleRoleName != null && resource.eligibleRoleName!.toLowerCase().contains(query.toLowerCase()))
       ).toList();
       print("query :$query -- ${filteredList.length}");
       return filteredList;
     }

  }

  List<CommisionList> searchRate(List<CommisionList> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<CommisionList> filteredList = list.where((resource) =>
        (resource.roleViewName != null && resource.roleViewName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.dealerName != null && resource.dealerName!.toLowerCase().contains(query.toLowerCase()))
    ).toList();
    return filteredList;
  }
  List<StockDealer> searchDealer(List<StockDealer> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<StockDealer> filteredList = list.where((resource) =>
     (resource.name != null && resource.name!.toLowerCase().contains(query.toLowerCase())) ||
     (resource.email != null && resource.email!.toLowerCase().contains(query.toLowerCase())) ||
     (resource.phone != null && resource.phone!.toLowerCase().contains(query.toLowerCase()))
    ).toList();
    return filteredList;
  }

  Future<void>getCommissionList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      commission = await apiService.getCommission();

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
  //kazananlar
  Future<void>getComWinner(BuildContext context,int? id,String? payPeriod,String? date) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      commissionWinner = await apiService.getCommissionWinner(id,payPeriod,date);

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
  //komisyon raporları
  Future<void>getComReport(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      comDetails = await apiService.getCommReport();
      setPaidUnPaidCom(1);

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
  //komisyon tipleri
  Future<void>getCommissionTypes(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      commissionTypes = await apiService.getCommissionTypes();

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
  //exist kontrol
  postComExist(BuildContext context,ComExist exist,int valuee,String name,int type) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.checkComExist(exist).then((value) => {
        responseExist = value,
        if(type==0){
          setRoleId(valuee, name)
        }else{
          setProfileId(valuee,name),
        },

         Navigator.pop(context),
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
          snackBarDesign(context, StringUtil.error, res!.data!);

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
  //açık komisyonu inactive etme 
  updateInactive(BuildContext context,ComInactive inactive) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.updateInactive(inactive).then((value) => {
       
        snackBarDesign(context, StringUtil.success, "changeDStatus".tr()),
        getCommissionList(context)
      });

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
      showProgress(context, false);
      notifyListeners();

    }

  }
  updateActive(BuildContext context,ComInactive inactive) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.updateActive(inactive).then((value) => {

        snackBarDesign(context, StringUtil.success, "changeDStatus".tr()),
        getCommissionList(context)
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
  //active rate tarih güncelleme
  updateExtendDate(BuildContext context,ComRateExtendDate extendDate) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.updateExtendDate(extendDate).then((value) => {
        snackBarDesign(context, StringUtil.success, "extendDateUpdated".tr()),
        getCommissionList(context)
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
  //amount kaydetme
  postComAmount(BuildContext context,ComAmount comAmount) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postComAmount(comAmount).then((value) => {
        Navigator.pop(context),
        snackBarDesign(context, StringUtil.success, "addedCom".tr()),
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
  //kazananları onaylama
  postComAdjust(BuildContext context,PostAdjust postAdjust) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postComAdjust(postAdjust).then((value) => {
        Navigator.pop(context),
        snackBarDesign(context, StringUtil.success, "updatedCom".tr()),
        if(payDate.text.isEmpty){
          getComWinner(context,null,getPayPeriod!.payPeriod,payDate.text)
        }else{
          getComWinner(context,null,getPayPeriod!.payPeriod,formatDateString(payDate.text,"MM-dd-yyyy","yyyy-MM-dd"))
        }
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
  //komisyon kaydetme
  postCommission(BuildContext context,CommisionPost commisionPost) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postCommission(commisionPost).then((value) => {
        addCom =value,


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
  checkCommissionAdd(BuildContext context,CheckComAdd post,Amount amount) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.checkComAdd(post).then((value) => {
        setList(context, amount),
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

  postComPay(BuildContext context,PayPost post,Function() function) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postPay(post).then((value) => {
        snackBarDesign(context, StringUtil.success, "Paid success"),
        function()

      });

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
      showProgress(context, false);
      notifyListeners();

    }

  }
  returnComPay(BuildContext context,PayPost post,Function() function) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.returnPostPay(post).then((value) => {
        snackBarDesign(context, StringUtil.success, "Paid success"),
        function()

      });

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
      showProgress(context, false);
      notifyListeners();

    }

  }
  //dealerlar  gelir profiller için
  Future<void>getDealerList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      stockDealer = await apiService.getStockDealer();

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
  //tüm roller
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

  //komisyonu update etme
   updateCom(BuildContext context,UpdateComRate update) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.updateRate(update).then((value) => {
        snackBarDesign(context, StringUtil.success, "Paid success"),
        Navigator.pop(context)

      });

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
      showProgress(context, false);
      notifyListeners();

    }

  }

  //commission report
  Future<void>getCommissionReport(BuildContext context,String beginDate,String endDate) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      commissionReport = await apiService.getComReport(beginDate,endDate);

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

  Future<void>getSaleDetails(BuildContext context,String serialNumber) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      saleDetails = await apiService.getSaleDetails(serialNumber);

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
  //pay period post etme
  postPayPeriod(BuildContext context,PostPayPeriod period) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postPayPeriod(period).then((value) => {
         snackBarDesign(context, StringUtil.success, "payPeriodAdded".tr()),
         listPayPeriod(context),
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
          snackBarDesign(context, StringUtil.error, res!.data!);

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
  //pay period getirme
  Future<void>listPayPeriod(BuildContext context,) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      getPayPeriod= await apiService.getPayPeriod();

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