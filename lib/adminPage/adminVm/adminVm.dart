import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminModel/customerEventModel/CustomerEventModel.dart';
import 'package:wizzsales/adminPage/adminModel/customerListModel/cListmodel.dart';
import 'package:wizzsales/adminPage/adminModel/customerListModel/postCList.dart';
import 'package:wizzsales/adminPage/adminModel/enterSerialModel/EnterSerial.dart';
import 'package:wizzsales/adminPage/adminModel/postModel/adminResponse.dart';
import 'package:wizzsales/adminPage/adminModel/referralListModel/ReferralModel.dart';
import 'package:wizzsales/adminPage/adminModel/rewardOrderModel/rewardOrderModel.dart';
import 'package:wizzsales/adminPage/adminModel/stockReportModel/stockReportData.dart';
import 'package:wizzsales/adminPage/adminModel/stockReportModel/stockReportModel.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../widgets/Constant.dart';

class AdminVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  CListModel? cListModel;
  EnterSerial? enterSerial;
  RewardOrderModel? rewardOrderModel;
  ReferralModel? referralModel;
  CustomerEventModel? customerEventModel;
  AdminResponse? response;
  List<StockReportDataDetails>? dataDetails;
  List<Map<String, bool>> gridMap = [];

  int stockReportSize=1;

  int currentNumber=1;
  int currentSize=30;

  int sNumCurrentNumber=1;
  int sNumCurrentSize=30;

  int rewardNumber=1;
  int rewardSize=30;

  int referralNumber=1;
  int referralSize=30;

  int eventNumber=1;
  int eventSize=30;

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

  setStockSize(int size){
    stockReportSize = size;
    notifyListeners();
  }

  setReferralNumber(int number){
    referralNumber = number;
    notifyListeners();
  }
  setReferralSize(int size){
    referralSize = size;
    notifyListeners();
  }

  setEventNumber(int number){
    eventNumber = number;
    notifyListeners();
  }
  setEventSize(int size){
    eventSize = size;
    notifyListeners();
  }

  setCurrentNumber(int number){
    currentNumber = number;
    notifyListeners();
  }
  setCurrentSize(int size){
    currentSize = size;
    notifyListeners();
  }
  setRewardNumber(int number){
    rewardNumber = number;
    notifyListeners();
  }
  setRewardSize(int size){
    rewardSize = size;
    notifyListeners();
  }
  setCurrentSerialNumber(int number){
    sNumCurrentNumber = number;
    notifyListeners();
  }
  setCurrentSerialSize(int size){
    sNumCurrentSize = size;
    notifyListeners();
  }

  Future<void>stockReportAllData(BuildContext context,String export) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    showProgress(context, true);
    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      dataDetails = await apiService.getStockReportListAllData(export);

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

  Future<void>usedOrderReward(BuildContext context,String code) async{
    String token = await pref.getString(context, SharedUtils.userToken);
 

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.usedReward(code).then((value) {
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
      notifyListeners();
    
    }

  }

  Future<void>cancelRewardApprove(BuildContext context,String code) async{
    String token = await pref.getString(context, SharedUtils.userToken);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.cancelApproveReward(code).then((value) {
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
      notifyListeners();
      
    }

  }

  Future<void>updateRewardApprove(BuildContext context,String code) async{
    String token = await pref.getString(context, SharedUtils.userToken);
   

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.updateApproveReward(code).then((value) {
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
      notifyListeners();
      
    }

  }

  Future<void>postCustomerEvent(BuildContext context,PostCList post) async{
    String token = await pref.getString(context, SharedUtils.userToken);
   

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.updateCEvent(post).then((value) {
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
      notifyListeners();
      
    }

  }

  Future<void>getEventList(BuildContext context,int number,int size) async{
    String token = await pref.getString(context, SharedUtils.userToken);
   

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getCustomerEvent(number,size).then((value) {
        customerEventModel = value;
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

  Future<void>getListReferral(BuildContext context,int number,int size) async{
    String token = await pref.getString(context, SharedUtils.userToken);
   

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getReferralList(number,size).then((value) {
        referralModel = value;
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


  Future<void>getListReward(BuildContext context,int number,int size) async{
    String token = await pref.getString(context, SharedUtils.userToken);
   

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getRewardOrder(number,size).then((value) {
        rewardOrderModel = value;
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


  Future<void>getListSerialNum(BuildContext context,int number,int size) async{
    String token = await pref.getString(context, SharedUtils.userToken);
   

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getSerialNum(number,size).then((value) {
        enterSerial = value;
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
  Future<void>getList(BuildContext context,int number,int size) async{
    String token = await pref.getString(context, SharedUtils.userToken);
   

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getCustomerList(number,size).then((value) {
        cListModel = value;
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
}