import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/OLD/SalePagination.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';

import '../model/OLD/Sale.dart';

class OfficeSaleVm extends ChangeNotifier{
  List<int> pageCount=[];
  SalePagination? approvedSale;
  SalePagination? pendingSale;
  SalePagination? cancelSale;
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

  Future<void>getApprovedSale(BuildContext context,int page) async{
    approvedSale = await SaleVM.getSaleList(context,1,page);
    notifyListeners();
  }
  Future<void>getPendingSale(BuildContext context,int page) async{
    pendingSale = await SaleVM.getSaleList(context,0,page);
    notifyListeners();
  }
  Future<void>getCancelSale(BuildContext context,int page) async{
    cancelSale = await SaleVM.getSaleList(context,2,page);
    notifyListeners();
  }

  updateStatus(BuildContext context,int id,String serialId) async{
    await SaleVM().updateSaleStatus(context, id, serialId, "1");
    //approve
    notifyListeners();
  }
  updatePendingStatus(BuildContext context,int id,String serialId) async{
    await SaleVM().updateSaleStatus(context, id, serialId, "0");
    //approve
    notifyListeners();
  }
  updateCancelStatus(BuildContext context,int id,String serialId,) async{
    await SaleVM().updateSaleStatus(context, id, serialId, "2");
    notifyListeners();
  }
}