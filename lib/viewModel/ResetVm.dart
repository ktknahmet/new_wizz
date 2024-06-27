import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/reset/ResetModel.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class ResetVm extends ChangeNotifier{
  String? result;



  Future<void> reset(BuildContext context, ResetModel resetModel) async {
    showProgress(context, true);

    ApiService apiService = ApiService(ServiceModule().baseService("","",""));
    notifyListeners();
    try {
      result = await apiService.resetPassword(resetModel);
      snackBarDesign(context, StringUtil.success, "Password sent");
    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, "We can't find a user with that e-mail address");
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
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