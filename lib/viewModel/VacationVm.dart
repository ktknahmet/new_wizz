import 'package:flutter/cupertino.dart';

class VacationVm extends ChangeNotifier{
  String cCountryCode="+1";
  String sCountryCode="+1";



  changeCode(String code){
    cCountryCode = code;
    notifyListeners();
  }
  changeSCode(String code){
    sCountryCode = code;
    notifyListeners();
  }
}