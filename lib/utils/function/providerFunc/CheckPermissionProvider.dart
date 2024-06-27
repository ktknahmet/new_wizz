import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermissionProvider extends ChangeNotifier{
  PermissionStatus? status;


  checkExternalStorage()async{
    if(Platform.isAndroid){
      await Permission.manageExternalStorage.request().then((value) => {
        status = value,
      });
    }else{
      await Permission.storage.request().then((value) => {
        status = value,
      });
    }
    print("permission durum $status");
    notifyListeners();
  }
}