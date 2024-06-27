import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/OLD/MyOfficeSales.dart';
import 'package:wizzsales/model/OLD/SalePagination.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/detailsReportModel/DetailReportModel.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

import '../../viewModel/OLD/SaleVm.dart';

class AdminSaleVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  SalePagination? pendingSale;
  List<MyOfficeSales?>? officeTotal;
  LoginUser? loginUser;
  User? user;
  int index=0;
  String currentDay=day[2];
  dynamic totalSales=0;
  dynamic totalApproved=0;
  dynamic totalPending=0;

  Future<void>getPendingSale(BuildContext context,int page) async{
    pendingSale = await SaleVM.getSaleList(context,0,page);
    notifyListeners();
  }

  officeTotalSale(BuildContext context) async{
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    int orgId = loginUser!.profiles![index].organisation_id!;
    officeTotal = await SaleVM.getOfficeSalesList(context, orgId);
    notifyListeners();
  }


}