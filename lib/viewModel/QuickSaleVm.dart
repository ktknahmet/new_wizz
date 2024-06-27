import 'dart:io';

import 'package:flutter/cupertino.dart';

class QuickSaleVm extends ChangeNotifier{
  String? cCountryCode;
  String? lastName;
  String? email;
  String? phone;
  File? selectedImage;
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  changeCode(String code){
    cCountryCode = code;
    notifyListeners();
  }
  setPhone(String code){
    phone = code;
    notifyListeners();
  }
  setLastName(String code){
    lastName = code;
    notifyListeners();
  }
  setEmail(String code){
    email = code;
    notifyListeners();
  }
}