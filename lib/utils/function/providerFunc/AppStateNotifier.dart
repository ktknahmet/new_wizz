// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/OLD/myContestModel/myCont.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/salesChart/yearlyChartModel.dart';
import 'package:wizzsales/service/firebase/FirebaseApi.dart';
import 'package:wizzsales/utils/function/PermissionList.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class AppStateNotifier extends ChangeNotifier {
  SharedPref pref = SharedPref();
  bool darkMode = false;
  String? selectedLanguage;
  LoginUser? loginUser;
  User? user;
  int? index;
  String token = "";
  MyCont? myContest;
  String? userType;
  bool? checkInternet;
  String? state;
  bool check = false;
  List<YearlyChartModel> chartData = [];


  getToken(BuildContext context) async {
    token = await pref.getString(context, SharedUtils.userToken);
    notifyListeners();
  }



  updateMode(String mode) async {
    await pref.setString(SharedUtils.admin, mode);
    userType = mode;
    notifyListeners();
  }
  updateTheme(bool isDarkModeOn) async {
    await pref.setBool(SharedUtils.theme, isDarkModeOn);
    darkMode = isDarkModeOn;
    print("tema :$darkMode");

    notifyListeners();
  }

  setTheme(BuildContext context) async {
    darkMode = await pref.getBool(context, SharedUtils.theme);
    notifyListeners();
  }

  setLanguage(BuildContext context, String language) {
    selectedLanguage = language;
    List<String> codes = selectedLanguage!.split("-");
    EasyLocalization.of(context)?.setLocale(Locale(codes[0], codes[1]));
    notifyListeners();
  }

  getModel(BuildContext context) async {
    SharedPref pref = SharedPref();
    index = await pref.getInt(context, SharedUtils.profileIndex);
    print("index :$index");
    loginUser = await getUser(context);
    user = await getUserUser(context);

    notifyListeners();
  }

  connection(BuildContext context) async {
    // Initialize flag to false
    await InternetConnectionChecker().hasConnection.then((value) {
      checkInternet = value;
    });
    if(checkInternet==false){
      state = "notInternet";
    }else{
      await isLoggedIn(context);
    }
    print("internet durum :  $state   --   $checkInternet");
    notifyListeners();
  }


  isLoggedIn(BuildContext context) async {
    await PermissionList().checkAndRequestPermissions();
    Platform.isAndroid ?
    await Firebase.initializeApp(options:
    const FirebaseOptions(
        apiKey: "AIzaSyCbGXpGUkrpMMfDrRippv5LkIVUsEl9qdU",
        appId: "1:39403204971:android:657310f18edd2238685c2e",
        messagingSenderId: "39403204971",
        projectId: "wizz-sales"))
        : await Firebase.initializeApp();
    await FirebaseApi().initNotification();
    SharedPref pref = SharedPref();
    var isToken = await pref.getString(context, SharedUtils.userToken);

    if(isToken.isNotEmpty){
      String isAdmin = await pref.getString(context, SharedUtils.admin);
      if(isAdmin=="admin"){
        state = "admin";
      }else{
        state =  "main";
      }
    }else{
      state =  "login";
    }
    print("internet durum state:  $state   --   $checkInternet");

    notifyListeners();
  }

}
