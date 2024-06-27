import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class RegisterVm extends ChangeNotifier{
   bool checkTerm = false;
   bool newPassView = true;

   String password = "";
   String distributorCode = "";
   String roles = "";
   File? userPp;
   String cCountryCode="US";

    changeNewPass(){
     newPassView = !newPassView;
     notifyListeners();
   }
   changeCode(String code){
     cCountryCode = code;
     notifyListeners();
   }
   setTerm(bool check){
      checkTerm =  check;
      notifyListeners();
   }
   
}