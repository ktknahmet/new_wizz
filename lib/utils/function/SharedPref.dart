
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  String stringValue="";
  int intValue=0;
  double doubleValue=0.0;
  bool boolValue=false;


  Future<void> setString(String key, String value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  Future<String> getString(BuildContext context,String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    stringValue =sharedPreferences.getString(key) ?? "";
    return stringValue;
  }

  Future<int> getInt(BuildContext context,String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    intValue = sharedPreferences.getInt(key) ?? 0;
    return intValue;
  }

  Future<double> getDouble(BuildContext context,String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    doubleValue =sharedPreferences.getDouble(key) ?? 0.0;
    return doubleValue;
  }

  Future<bool> getBool(BuildContext context,String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    boolValue =sharedPreferences.getBool(key) ?? false;
    return boolValue;
  }


  deletePref(BuildContext context,String key) async{
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }
}