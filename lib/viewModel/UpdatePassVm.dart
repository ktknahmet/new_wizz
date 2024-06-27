import 'package:flutter/material.dart';

class UpdatePassVm extends ChangeNotifier{
  bool oldPassView = true;
  bool newPassView = true;
  bool reNewPassView = true;


  void changeOldPass(){
    oldPassView  = !oldPassView;
    notifyListeners();
  }
  void changeNewPass(){
    newPassView = !newPassView;
    notifyListeners();
  }
  void changeReNewPass(){
    reNewPassView = !reNewPassView;
    notifyListeners();
  }
}