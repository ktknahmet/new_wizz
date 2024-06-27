import 'package:flutter/material.dart';
import 'package:wizzsales/model/OLD/SalePagination.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';

import '../model/OLD/Sale.dart';

class MySaleVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  SalePagination? approvedMySale;
  SalePagination? pendingMySale;
  List<int> pageCount=[];
  int page =1;
  String query="";

  setQuery(String value){
    query = value;
    notifyListeners();
  }
  List<Sale> searchSale(List<Sale> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<Sale> filteredList = list.where((resource) =>
    (resource.serialid != null && resource.serialid!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.cname != null && resource.cname!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.date != null && resource.date!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.cphone != null && resource.cphone!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.caddress != null && resource.caddress!.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    return filteredList;
  }
  setPage(int value){
    page = value;
    notifyListeners();
  }
  Future<void>getApprovedMySale(BuildContext context,int? page) async{
    int orgId = await pref.getInt(context, SharedUtils.orgId);

    approvedMySale = await SaleVM.getMySaleList(context,orgId.toString(),1,page!);
    notifyListeners();
    print("orgid :$orgId");
  }
  Future<void>getPendingMySale(BuildContext context,int? page) async{
    int orgId = await pref.getInt(context, SharedUtils.orgId);
    pendingMySale = await SaleVM.getMySaleList(context,orgId.toString(),0,page!);
    notifyListeners();
  }
  updateStatus(BuildContext context,int id,String serialId,String status) async{
    await SaleVM().updateSaleStatus(context, id, serialId, status);
    notifyListeners();
  }
}