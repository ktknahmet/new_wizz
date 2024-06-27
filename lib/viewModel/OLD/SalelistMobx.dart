import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wizzsales/model/OLD/MyOfficeSales.dart';
import 'package:wizzsales/model/OLD/SalePagination.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/OLD/contestModel/Active.dart';
import 'package:wizzsales/model/OLD/contestReportModel/CompetitionsReports.dart';
import 'package:wizzsales/model/OLD/leadReport/LeadReport.dart';
import 'package:wizzsales/model/OLD/myContestModel/myCont.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

part 'SalelistMobx.g.dart';
class SaleOfficeMobx = _SaleOfficeMobxBase with _$SaleOfficeMobx;
abstract class _SaleOfficeMobxBase with Store{
  SharedPref pref = SharedPref();
  @observable
  SalePagination? approvedSale;
  @observable
  SalePagination? pendingSale;
  @observable
  SalePagination? approvedMySale;
  @observable
  SalePagination? pendingMySale;
  @observable
  List<MyOfficeSales?>? officeTotal;
  @observable
  List<MyOfficeSales?>? myOfficeTotal;
  @observable
  User? user;
  @observable
  List<Active?>? allContest;
  @observable
  MyCont? myContest;
  @observable
  List<CompetitionsReports?>? allContestReport;
  @observable
  List<LeadReport?>? leadReports;

  @action allLeadReport(BuildContext context) async{
    leadReports = await UserVM.allLeadReport(context);
  }
  @action getAllContestReport(BuildContext context,int id) async{
    allContestReport = await SaleVM.getCompetitionsResult(context, id);
  }
  @action getMyContest(BuildContext context) async{
    myContest = await SaleVM.getDashBoard(context);
  }
  @action getAllContest(BuildContext context) async{
    allContest = await SaleVM.getAllContests(context);
  }
  @action
   getUserInfo(BuildContext context) async{
    user = await getUserUser(context);
  }
  @action
  Future<void>getApprovedSale(BuildContext context,int page) async{
    approvedSale = await SaleVM.getSaleList(context,1,page);
  }
  @action
  Future<void>getPendingSale(BuildContext context,int page) async{
    pendingSale = await SaleVM.getSaleList(context,0,page);
  }
  @action
  Future<void>getApprovedMySale(BuildContext context,int? page) async{
    int orgId = await pref.getInt(context, SharedUtils.orgId);

    approvedMySale = await SaleVM.getMySaleList(context,orgId.toString(),1,page!);
    print("orgid :$orgId");
  }
  @action
  Future<void>getPendingMySale(BuildContext context,int? page) async{
    int orgId = await pref.getInt(context, SharedUtils.orgId);
    pendingMySale = await SaleVM.getMySaleList(context,orgId.toString(),0,page!);
  }
  @action
  updateStatus(BuildContext context,int id,String serialId,String status) async{
    await SaleVM().updateSaleStatus(context, id, serialId, status);
  }
  @action
  officeTotalSale(BuildContext context) async{
    int index = await pref.getInt(context, SharedUtils.profileIndex);
    LoginUser user = await getUser(context);
    int orgId = user.profiles![index].organisation_id!;
    officeTotal = await SaleVM.getOfficeSalesList(context, orgId);
  }
  @action
  myTotalSale(BuildContext context) async{
    int index = await pref.getInt(context, SharedUtils.profileIndex);
    LoginUser user = await getUser(context);
    int orgId = user.profiles![index].organisation_id!;
    myOfficeTotal = await SaleVM.getMySalesList(context,user.userId!, orgId);
  }
}