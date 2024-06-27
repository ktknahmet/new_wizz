import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/OLD/Notifications.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';

class NotifyVm extends ChangeNotifier{
  List<Notifications?>? notify;



  getNotifyList(BuildContext context) async{
    notify = await UserVM.getNotifications(context);
    notifyListeners();
  }
}