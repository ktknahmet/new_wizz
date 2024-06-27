// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class DatePickerHelper{
  static Future<String> getDatePicker(BuildContext context) async{
    SharedPref pref = SharedPref();
    bool theme = await pref.getBool(context, SharedUtils.theme);

    String date="";
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050),
        builder: (BuildContext context ,Widget? child){
          return Theme(
            data:getTheme(context,theme),
            child: child!,
          );
        }
    );
    if(pickedDate !=null){
      date = mmDDYDate(pickedDate.toString());
    }
    return date;
  }
  static Future<String> getDatePicker2(BuildContext context) async{
    SharedPref pref = SharedPref();
    bool theme = await pref.getBool(context, SharedUtils.theme);

    String date="";
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050),
        builder: (BuildContext context ,Widget? child){
          return Theme(
            data:getTheme(context,theme),
            child: child!,
          );
        }
    );
    if(pickedDate !=null){
      date = formatDate(pickedDate.toString());
    }
    return date;
  }
  static Future<TimeOfDay> getTimePicker(BuildContext context) async{

    SharedPref pref = SharedPref();
    bool theme = await pref.getBool(context, SharedUtils.theme);
    TimeOfDay selectedTime = TimeOfDay.now();
    var pickedTime = await showTimePicker(

        context: context,
         initialTime: const TimeOfDay(hour: 12,minute: 00),

        initialEntryMode:TimePickerEntryMode.dial,
        builder: (BuildContext context ,Widget? child){
          return  MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: Theme(
                data:getTheme(context,theme),
                child: child! ,
            ),
          );
        }
    );
    if (pickedTime != null) {

      selectedTime = TimeOfDay(hour: pickedTime.hour, minute: 00);
      print("ahmet : $selectedTime");
    }
    return selectedTime;
  }
  
}