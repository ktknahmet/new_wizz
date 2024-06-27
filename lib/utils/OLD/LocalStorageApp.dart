import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizzsales/model/OLD/Draw.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';

class LocalStorageApp {
  static String officeSalesTitle = 'Office Sales';
  static String officeSalesView = '0';
  static List<AllSizes> sizeList = [];
  static int myDocuments = 0;
  static int drawView = 0;
  static String drawTitle1 = 'Free Vacation Entry';
  static String drawTitle2 = 'Enter';
  static String drawTitle3 = 'Draw Code';
  static String drawTitle4 = 'Please take a note and share with customer';
  static int leadView = 0;
  static String leadTitle1 = 'Lead Entry';
  static String leadTitle2 = 'Lead';
  static String leadTitle3 = 'Entry Code';
  static String leadTitle4 = 'Leads added successfuly';
  static String leadTitle5 = 'Leads & Appointments';
  static List<Draw> drawList = [];
  static List<Draw> customerList = [];
  static String saleFotoMessage =
      'Please smile and take a picture\nwith customer and Hyla';
  static String profileFotoMessage = 'Please smile and take a profile picture';
  static String newsTitle = 'Latest news';
  static var resultvals = [
    'val0',
    'val1',
    'val2',
    'val3',
    'val4',
    'val5',
    'val6',
    'val7',
    'val8',
    'val9'
  ];
  static var reportsvals = [
    'name',
    'location',
    'total',
    'qualification'


  ];
  static String userKey = 'userKey';
  static User? user;
  static LoginUser? loginUser;
  static String loginUserKey = 'loginUserKey';
  static String token = '';
  static String dateKey = 'dateKey';
  static int distiribitorTypeId=0;
  static int? organisation;
  static int careerSale=0;
  static Widget? mainViewContainer;
  static String? activeprofile;
  static String? salesroleid;
  static int? organisation_id;
  static String? asssitboxUserToken;
  static int? currentIndex;
  static int ongoingIndex = 0;
  static bool sendMeetingInfo = false;
  static BuildContext? currentContext;
  static BuildContext? bottombarmenucontext;
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static getLoggedinUser() {
    getString(loginUserKey).then((value) {
      if (value != null) {
        try {
          loginUser = LoginUser.fromJson(jsonDecode(value));
        } catch (e) {
          //
        }
      }
    });
  }

  static saveString(id, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(id, value);
  }

  static Future<String?> getString(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(id);
  }
  static saveInt(id, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(id, value);
  }

  static Future<int?> getInt(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(id);
  }


  static saveBool(id, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(id, value);
  }

  static Future<bool?> getBool(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(id);
  }

  static removeKey(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (String key in prefs.getKeys()) {
      if (key == id) {
        prefs.remove(key);
      }
    }
  }
}


class AllSizes {
  String id;
  String name;

  AllSizes(
      this.id,
      this.name,
      );

  factory AllSizes.fromJson(Map<String, dynamic> json) {
    return AllSizes(json['id'].toString(), json['name']);
  }
}

