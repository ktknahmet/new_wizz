// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SalelistMobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SaleOfficeMobx on _SaleOfficeMobxBase, Store {
  late final _$approvedSaleAtom =
      Atom(name: '_SaleOfficeMobxBase.approvedSale', context: context);

  @override
  SalePagination? get approvedSale {
    _$approvedSaleAtom.reportRead();
    return super.approvedSale;
  }

  @override
  set approvedSale(SalePagination? value) {
    _$approvedSaleAtom.reportWrite(value, super.approvedSale, () {
      super.approvedSale = value;
    });
  }

  late final _$pendingSaleAtom =
      Atom(name: '_SaleOfficeMobxBase.pendingSale', context: context);

  @override
  SalePagination? get pendingSale {
    _$pendingSaleAtom.reportRead();
    return super.pendingSale;
  }

  @override
  set pendingSale(SalePagination? value) {
    _$pendingSaleAtom.reportWrite(value, super.pendingSale, () {
      super.pendingSale = value;
    });
  }

  late final _$approvedMySaleAtom =
      Atom(name: '_SaleOfficeMobxBase.approvedMySale', context: context);

  @override
  SalePagination? get approvedMySale {
    _$approvedMySaleAtom.reportRead();
    return super.approvedMySale;
  }

  @override
  set approvedMySale(SalePagination? value) {
    _$approvedMySaleAtom.reportWrite(value, super.approvedMySale, () {
      super.approvedMySale = value;
    });
  }

  late final _$pendingMySaleAtom =
      Atom(name: '_SaleOfficeMobxBase.pendingMySale', context: context);

  @override
  SalePagination? get pendingMySale {
    _$pendingMySaleAtom.reportRead();
    return super.pendingMySale;
  }

  @override
  set pendingMySale(SalePagination? value) {
    _$pendingMySaleAtom.reportWrite(value, super.pendingMySale, () {
      super.pendingMySale = value;
    });
  }

  late final _$officeTotalAtom =
      Atom(name: '_SaleOfficeMobxBase.officeTotal', context: context);

  @override
  List<MyOfficeSales?>? get officeTotal {
    _$officeTotalAtom.reportRead();
    return super.officeTotal;
  }

  @override
  set officeTotal(List<MyOfficeSales?>? value) {
    _$officeTotalAtom.reportWrite(value, super.officeTotal, () {
      super.officeTotal = value;
    });
  }

  late final _$myOfficeTotalAtom =
      Atom(name: '_SaleOfficeMobxBase.myOfficeTotal', context: context);

  @override
  List<MyOfficeSales?>? get myOfficeTotal {
    _$myOfficeTotalAtom.reportRead();
    return super.myOfficeTotal;
  }

  @override
  set myOfficeTotal(List<MyOfficeSales?>? value) {
    _$myOfficeTotalAtom.reportWrite(value, super.myOfficeTotal, () {
      super.myOfficeTotal = value;
    });
  }

  late final _$userAtom =
      Atom(name: '_SaleOfficeMobxBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$allContestAtom =
      Atom(name: '_SaleOfficeMobxBase.allContest', context: context);

  @override
  List<Active?>? get allContest {
    _$allContestAtom.reportRead();
    return super.allContest;
  }

  @override
  set allContest(List<Active?>? value) {
    _$allContestAtom.reportWrite(value, super.allContest, () {
      super.allContest = value;
    });
  }

  late final _$myContestAtom =
      Atom(name: '_SaleOfficeMobxBase.myContest', context: context);

  @override
  MyCont? get myContest {
    _$myContestAtom.reportRead();
    return super.myContest;
  }

  @override
  set myContest(MyCont? value) {
    _$myContestAtom.reportWrite(value, super.myContest, () {
      super.myContest = value;
    });
  }

  late final _$allContestReportAtom =
      Atom(name: '_SaleOfficeMobxBase.allContestReport', context: context);

  @override
  List<CompetitionsReports?>? get allContestReport {
    _$allContestReportAtom.reportRead();
    return super.allContestReport;
  }

  @override
  set allContestReport(List<CompetitionsReports?>? value) {
    _$allContestReportAtom.reportWrite(value, super.allContestReport, () {
      super.allContestReport = value;
    });
  }

  late final _$leadReportsAtom =
      Atom(name: '_SaleOfficeMobxBase.leadReports', context: context);

  @override
  List<LeadReport?>? get leadReports {
    _$leadReportsAtom.reportRead();
    return super.leadReports;
  }

  @override
  set leadReports(List<LeadReport?>? value) {
    _$leadReportsAtom.reportWrite(value, super.leadReports, () {
      super.leadReports = value;
    });
  }

  late final _$allLeadReportAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.allLeadReport', context: context);

  @override
  Future allLeadReport(BuildContext context) {
    return _$allLeadReportAsyncAction.run(() => super.allLeadReport(context));
  }

  late final _$getAllContestReportAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.getAllContestReport', context: context);

  @override
  Future getAllContestReport(BuildContext context, int id) {
    return _$getAllContestReportAsyncAction
        .run(() => super.getAllContestReport(context, id));
  }

  late final _$getMyContestAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.getMyContest', context: context);

  @override
  Future getMyContest(BuildContext context) {
    return _$getMyContestAsyncAction.run(() => super.getMyContest(context));
  }

  late final _$getAllContestAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.getAllContest', context: context);

  @override
  Future getAllContest(BuildContext context) {
    return _$getAllContestAsyncAction.run(() => super.getAllContest(context));
  }

  late final _$getUserInfoAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.getUserInfo', context: context);

  @override
  Future getUserInfo(BuildContext context) {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo(context));
  }

  late final _$getApprovedSaleAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.getApprovedSale', context: context);

  @override
  Future<void> getApprovedSale(BuildContext context, int page) {
    return _$getApprovedSaleAsyncAction
        .run(() => super.getApprovedSale(context, page));
  }

  late final _$getPendingSaleAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.getPendingSale', context: context);

  @override
  Future<void> getPendingSale(BuildContext context, int page) {
    return _$getPendingSaleAsyncAction
        .run(() => super.getPendingSale(context, page));
  }

  late final _$getApprovedMySaleAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.getApprovedMySale', context: context);

  @override
  Future<void> getApprovedMySale(BuildContext context, int? page) {
    return _$getApprovedMySaleAsyncAction
        .run(() => super.getApprovedMySale(context, page));
  }

  late final _$getPendingMySaleAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.getPendingMySale', context: context);

  @override
  Future<void> getPendingMySale(BuildContext context, int? page) {
    return _$getPendingMySaleAsyncAction
        .run(() => super.getPendingMySale(context, page));
  }

  late final _$updateStatusAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.updateStatus', context: context);

  @override
  Future updateStatus(
      BuildContext context, int id, String serialId, String status) {
    return _$updateStatusAsyncAction
        .run(() => super.updateStatus(context, id, serialId, status));
  }

  late final _$officeTotalSaleAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.officeTotalSale', context: context);

  @override
  Future officeTotalSale(BuildContext context) {
    return _$officeTotalSaleAsyncAction
        .run(() => super.officeTotalSale(context));
  }

  late final _$myTotalSaleAsyncAction =
      AsyncAction('_SaleOfficeMobxBase.myTotalSale', context: context);

  @override
  Future myTotalSale(BuildContext context) {
    return _$myTotalSaleAsyncAction.run(() => super.myTotalSale(context));
  }

  @override
  String toString() {
    return '''
approvedSale: ${approvedSale},
pendingSale: ${pendingSale},
approvedMySale: ${approvedMySale},
pendingMySale: ${pendingMySale},
officeTotal: ${officeTotal},
myOfficeTotal: ${myOfficeTotal},
user: ${user},
allContest: ${allContest},
myContest: ${myContest},
allContestReport: ${allContestReport},
leadReports: ${leadReports}
    ''';
  }
}
