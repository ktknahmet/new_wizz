import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/loginModel/Login.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class LoginViewModel extends ChangeNotifier{
  bool? remember;
  String? email;
  String? password;
  LoginUser? loginUser;
  bool passObsecure = true;
  bool isSwitched = false;
  SharedPref pref = SharedPref();


  setPassObsecure(bool value){
    passObsecure = value;
    notifyListeners();
  }
  setSwitch(bool value){
    isSwitched = value;
    notifyListeners();
  }
  getInformation(BuildContext context) async{

    remember = await pref.getBool(context,SharedUtils.remember);
    email = await pref.getString(context,SharedUtils.email);
    password = await pref.getString(context, SharedUtils.password);

    notifyListeners();

  }
  Future<void>getLogin(BuildContext context,Login login) async{
    showProgress(context, true);

    ApiService apiService = ApiService(ServiceModule().baseService("","",""));
    notifyListeners();
    try {
      loginUser = await apiService.loginUser(login);
      await pref.setString(SharedUtils.salesRoleId, loginUser!.salesroleid.toString());
      await pref.setInt(SharedUtils.profileId, loginUser!.profiles![0].id!);
      await pref.setInt(SharedUtils.profileIndex, 0);
      await pref.setInt(SharedUtils.orgId, loginUser!.profiles![0].organisation_id!);
      await pref.setString(SharedUtils.activeProfile, loginUser!.userId!.toString());
      await pref.setString(SharedUtils.userModel,jsonEncode(loginUser!.toJson()));
    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, "We can't find a user with that e-mail address");
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          snackBarDesign(context, StringUtil.error, "We can't find a user with that e-mail address");
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      // İşlemin sonunda her durumda notifyListeners ve showProgress(false) yapılır
      notifyListeners();
      showProgress(context, false);
    }

  }
}