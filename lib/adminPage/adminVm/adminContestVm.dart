import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminModel/adminContestModel/AdminContestModel.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/widgets/Extension.dart';
import '../../utils/res/SharedUtils.dart';

class AdminContestVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  int currentPage =1;
  AdminContestModel? adminContestModel;


  setCurrentPage(int page){
    currentPage = page;
    notifyListeners();
  }


  allContestList(BuildContext context,int page) async{
    String token = await pref.getString(context, SharedUtils.userToken);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getAllContest(page).then((value) {
        adminContestModel = value;
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