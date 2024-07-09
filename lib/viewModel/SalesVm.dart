import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionWinner.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPost.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/postAdjust.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/productCoastList.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/saleDocument/postReceiveAmount.dart';
import 'package:wizzsales/model/saleDocument/saleDeduction.dart';
import 'package:wizzsales/model/stockModel/assignDealerList.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../model/socialModel/SocialMedia.dart';
import '../utils/res/PageName.dart';
// ignore_for_file: use_build_context_synchronously

class SalesVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  String? cCountryCode;
  String? sCountryCode;
  Barcode? result;
  PermissionStatus? status;
  String? postResponse;
  List<AssignDealerList>? assignList;
  List<ProductCoastList>? productCoast;
  List<CommissionWinner>? commissionDetails;
  TextEditingController serialIdController = TextEditingController();
  String query="";
  bool openComDesign=false;
  List<SocialMedia>? socialMedia;

  LoginUser? loginUser;
  int index=0;

  setOpenComDesign(){
    openComDesign = !openComDesign;
    notifyListeners();
  }
  setQuery(String value){
    query = value;
    notifyListeners();
  }
  changeCode(String code){
    cCountryCode = code;
    notifyListeners();
  }
  changeSCode(String code){
    sCountryCode = code;
    notifyListeners();
  }
  setSerial(String text){
    serialIdController.text = text;
    notifyListeners();
  }
  List<AssignDealerList> searchAssign(List<AssignDealerList> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<AssignDealerList> filteredList = list.where((value) =>
        value.serialNumber!.toString().toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList;
  }

   onQRViewCreated(BuildContext context,QRViewController qrViewController,TextEditingController textEditingController) {
    qrViewController.scannedDataStream.listen((scanData) {
      result = scanData;
      textEditingController.text = result!.code.toString();
    });
    notifyListeners();
  }
   checkCamera()async{
    await Permission.camera.request().then((value) => {
      status = value,
    });
    notifyListeners();
  }
  Future<void>getAccountValue(BuildContext context,String facebook,String twitter,String instagram,String tiktok) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);


    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.getSocial(facebook,twitter,instagram,tiktok).then((value) =>{
        socialMedia = value,
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;

        if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }else if(res!.statusCode==400) {

        }else if (error.type == DioExceptionType.connectionError) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/${PageName.internetPage}',
                (Route<dynamic> route) => false,
          );
        }
      }
    } finally {

      notifyListeners();

    }

  }

  Future<void>getProductCoast(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    int distId = loginUser!.profiles![index].organisation_id!;
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      productCoast = await apiService.getProductCoast(distId);

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
  Future<void>getAssign(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      assignList = await apiService.getAssignList();

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
  Future<void>getComDetails(BuildContext context,int? id) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      commissionDetails = await apiService.getSaleComDetail(id);

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
  postDeduction(BuildContext context,SaleDeduction deduction,int id) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postSaleDeduction(deduction).then((value) => {
         snackBarDesign(context, StringUtil.success, "updatedSaleInfo".tr()),
         getComDetails(context, id)
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
  postReceive(BuildContext context,PostReceiveAmount amount) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postSaleAmount(amount).then((value) => {
        postResponse = value,
        snackBarDesign(context, StringUtil.success, "updatedCommissionInfo".tr()),
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
  //post adjust
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
  //komisyon pay etme
  postComPay(BuildContext context,PayPost post,int saleId) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postPay(post).then((value) => {
        snackBarDesign(context, StringUtil.success, "paidSuccess".tr()),
        getComDetails(context,saleId)

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
}