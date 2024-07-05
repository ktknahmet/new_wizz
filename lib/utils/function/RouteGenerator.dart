import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/adminPage/adminAddCarousel/AddCarousel.dart';
import 'package:wizzsales/adminPage/adminAddCarousel/AllCarousel.dart';
import 'package:wizzsales/adminPage/adminBoard/adminBoard.dart';
import 'package:wizzsales/adminPage/adminBoard/appointment/appointmentBoard.dart';
import 'package:wizzsales/adminPage/adminBoard/demoBoard/demoBoard.dart';
import 'package:wizzsales/adminPage/adminBoard/sales/salesBoard.dart';
import 'package:wizzsales/adminPage/adminBoard/weeklyAppt/weeklyAppt.dart';
import 'package:wizzsales/adminPage/adminBonus/addBonus.dart';
import 'package:wizzsales/adminPage/adminBonus/adminBonus.dart';
import 'package:wizzsales/adminPage/adminBonus/bonusPage.dart';
import 'package:wizzsales/adminPage/adminBonus/bonusReport/bonusWinnerReport.dart';
import 'package:wizzsales/adminPage/adminBonus/bonusWinner.dart';
import 'package:wizzsales/adminPage/adminCommission/addCommission.dart';
import 'package:wizzsales/adminPage/adminCommission/addCurrentCommission.dart';
import 'package:wizzsales/adminPage/adminCommission/adminComWinner.dart';
import 'package:wizzsales/adminPage/adminCommission/rateList/rateScale.dart';
import 'package:wizzsales/adminPage/adminCommission/commissionPage.dart';
import 'package:wizzsales/adminPage/adminCommission/commissionSettings.dart';
import 'package:wizzsales/adminPage/adminCommission/payPeriod/addPayPeriod.dart';
import 'package:wizzsales/adminPage/adminCommission/report/comReport.dart';
import 'package:wizzsales/adminPage/adminCommission/searchCommission.dart';
import 'package:wizzsales/adminPage/adminContests/AdminContests.dart';
import 'package:wizzsales/adminPage/adminMainHome.dart';
import 'package:wizzsales/adminPage/adminManageGoals/adminManageGoals.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionList.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseList.dart';
import 'package:wizzsales/adminPage/adminOverride/addOverride.dart';
import 'package:wizzsales/adminPage/adminOverride/addProductCoast.dart';
import 'package:wizzsales/adminPage/adminOverride/overrideConfigDetails.dart';
import 'package:wizzsales/adminPage/adminOverride/overridePage.dart';
import 'package:wizzsales/adminPage/adminOverride/overrideSettings.dart';
import 'package:wizzsales/adminPage/adminOverride/productCost.dart';
import 'package:wizzsales/adminPage/adminOverride/report/overrideReport.dart';
import 'package:wizzsales/adminPage/adminOverride/reportForDist/reportForDist.dart';
import 'package:wizzsales/adminPage/adminOverride/searchOverride.dart';
import 'package:wizzsales/adminPage/adminOverride/setOverrideUser.dart';
import 'package:wizzsales/adminPage/adminPaperWork/adminManagePaper.dart';
import 'package:wizzsales/adminPage/adminPaperWork/adminPaperWork.dart';
import 'package:wizzsales/adminPage/adminProgress/officeProgress.dart';
import 'package:wizzsales/adminPage/adminReport/adminReport.dart';
import 'package:wizzsales/adminPage/adminReport/pages/cEvent/customerEventPage.dart';
import 'package:wizzsales/adminPage/adminReport/pages/cList/customerList.dart';
import 'package:wizzsales/adminPage/adminReport/pages/referralList/ReferralList.dart';
import 'package:wizzsales/adminPage/adminReport/pages/rewardOrders/rewardOrders.dart';
import 'package:wizzsales/adminPage/adminReport/pages/seriNumberEnter/sNumList.dart';
import 'package:wizzsales/adminPage/adminSale/AdminSaleDetails.dart';
import 'package:wizzsales/adminPage/adminSale/CommissionDetails.dart';
import 'package:wizzsales/adminPage/adminSale/CustomerDetails.dart';
import 'package:wizzsales/adminPage/adminSale/adminSaleTabBar/AdminCustomerTabBar.dart';
import 'package:wizzsales/adminPage/adminSale/adminSaleTabBar/AdminSaleTabBar.dart';
import 'package:wizzsales/adminPage/adminSetting/adminSettings.dart';
import 'package:wizzsales/adminPage/adminStockManagament/pages/addWarehouse.dart';
import 'package:wizzsales/adminPage/adminStockManagament/pages/assignGlobalStock.dart';
import 'package:wizzsales/adminPage/adminStockManagament/pages/importerSummary.dart';
import 'package:wizzsales/adminPage/adminStockManagament/pages/setWarehouse.dart';
import 'package:wizzsales/adminPage/adminStockManagament/pages/updateWarehouse.dart';
import 'package:wizzsales/adminPage/adminStockManagament/report/importerInventoryReport.dart';
import 'package:wizzsales/adminPage/adminStockManagament/stockManagament.dart';
import 'package:wizzsales/adminPage/inventory/distStock.dart';
import 'package:wizzsales/adminPage/adminStockManagament/pages/stockDetails.dart';
import 'package:wizzsales/adminPage/adminStockManagament/pages/stockScanBarcode.dart';
import 'package:wizzsales/adminPage/inventory/stockHistory.dart';
import 'package:wizzsales/adminPage/adminStockManagament/pages/stockPage.dart';
import 'package:wizzsales/adminPage/inventory/report/inventoryReport.dart';
import 'package:wizzsales/main.dart';
import 'package:wizzsales/model/demoModel/demoQuestions.dart';
import 'package:wizzsales/model/quickSaleModel/quickSaleModel.dart';
import 'package:wizzsales/view/board/board.dart';
import 'package:wizzsales/view/businessCenter/businessCenter.dart';
import 'package:wizzsales/view/contests/allContest/allContest.dart';
import 'package:wizzsales/view/contests/myContest/myContest.dart';
import 'package:wizzsales/view/dealerOverride/dealerOverrideWinner.dart';
import 'package:wizzsales/view/demos/completeDemo.dart';
import 'package:wizzsales/view/demos/demoQuestionPage.dart';
import 'package:wizzsales/view/demos/startDemo.dart';
import 'package:wizzsales/view/demos/startDemoFromAppointment.dart';
import 'package:wizzsales/view/expense/addExpense.dart';
import 'package:wizzsales/view/expense/allExpense.dart';
import 'package:wizzsales/view/expense/report/expenseReport.dart';
import 'package:wizzsales/view/internetPage/internet.dart';
import 'package:wizzsales/view/demos/demoTabbar/liveDemoTabBar.dart';
import 'package:wizzsales/view/myLeads/leadDetails.dart';
import 'package:wizzsales/view/myLeads/totalLeads.dart';
import 'package:wizzsales/view/quickSales/AddQuickSale.dart';
import 'package:wizzsales/view/quickSalesEnterValue/QuickSaleValue.dart';
import 'package:wizzsales/view/reports/leadReport/leadExcelReport/totalLeadsReport.dart';
import 'package:wizzsales/view/progress/myProgress.dart';
import 'package:wizzsales/view/reports/appointmentReport/appointmentReport.dart';
import 'package:wizzsales/view/reports/tabBar/leadReportTabBar.dart';
import 'package:wizzsales/view/sale/dealerComDetails/dealerComDetails.dart';
import 'package:wizzsales/view/sale/details/SaleDetails.dart';
import 'package:wizzsales/view/setAppointment/myAppointment.dart';
import 'package:wizzsales/view/signature/signature.dart';
import 'package:wizzsales/view/stock/dealerStockList.dart';
import 'package:wizzsales/view/trainingSection/addContact.dart';
import 'package:wizzsales/view/trainingSection/trainingSection.dart';
import '../../adminPage/adminCommission/rateList/editCommissionRate.dart';
import '../../model/OLD/Sale.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/view/contests/contests.dart';
import 'package:wizzsales/view/home/home.dart';
import 'package:wizzsales/view/leads&Appointment/leadsAppointment.dart';
import 'package:wizzsales/view/login/login_view.dart';
import 'package:wizzsales/view/login/reset_view.dart';
import 'package:wizzsales/view/mainHome/mainHome.dart';
import 'package:wizzsales/view/myAccount/myAccount.dart';
import 'package:wizzsales/view/myAccount/updateAddress.dart';
import 'package:wizzsales/view/myAccount/updateEmail.dart';
import 'package:wizzsales/view/myAccount/updatePassword.dart';
import 'package:wizzsales/view/myAccount/updateSocial.dart';
import 'package:wizzsales/view/myAccount/uploadPicture.dart';
import 'package:wizzsales/view/notify/wizzNotify.dart';
import 'package:wizzsales/view/pdfPage/pdfPage.dart';
import 'package:wizzsales/view/profile/profile.dart';
import 'package:wizzsales/view/register/registerView.dart';
import 'package:wizzsales/view/resources/resourceTabBar.dart';
import 'package:wizzsales/view/resources/resources.dart';
import 'package:wizzsales/view/sale/AddSale.dart';
import 'package:wizzsales/view/sale/SalePage.dart';
import 'package:wizzsales/view/sale/saleTabbar/mySaleTab.dart';
import 'package:wizzsales/view/sale/saleTabbar/officeSaleTab.dart';
import 'package:wizzsales/view/vacation/vacationDrawing.dart';
import 'package:wizzsales/view/videoPage/videoPage.dart';

import '../../model/OLD/leadReport/Lead.dart';
import '../../model/appointmentModel/Data.dart';
import '../../model/detailsReportModel/DetailReportModel.dart';
import '../../view/bonus/bonusWinnerList.dart';
import '../../view/reports/goalsReport/goalsReport.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case '/${PageName.internetPage}':
        return MaterialPageRoute(builder: (_) => const Internet());

      case '/${PageName.myApp}':
        return MaterialPageRoute(builder: (_) => const MyApp());

      case '/${PageName.stockHistory}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        int poolId = arguments!["poolId"];
        return MaterialPageRoute(builder: (_) =>  StockHistoryPage(poolId));

      case '/${PageName.addCurrentCommissionRate}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        int poolId = arguments!["poolId"];
        return MaterialPageRoute(builder: (_) =>  AddCurrentCommission(poolId));

      case '/${PageName.loginPage}':
      return MaterialPageRoute(builder: (_) => const LoginView(null));

      case '/${PageName.liveDemo}':
        return MaterialPageRoute(builder: (_) =>  const LiveDemoTabBar());

      case '/${PageName.logout}':
        return MaterialPageRoute(builder: (_) => const LoginView(null));

      case '/${PageName.resetView}':
        return MaterialPageRoute(builder: (_) => const ResetView(null));

      case '/${PageName.digitalSignature}':
        return MaterialPageRoute(builder: (_) =>  const Signature());

      case '/${PageName.inventoryReportPage}':
        return MaterialPageRoute(builder: (_) =>  const InventoryReport());

      case '/${PageName.importerInventoryReport}':
        return MaterialPageRoute(builder: (_) =>  const ImporterInventoryReport());

      case '/${PageName.dealerOverridePage}':
        return MaterialPageRoute(builder: (_) =>  const DealerOverrideWinner());

      case '/${PageName.stockManagement}':
        return MaterialPageRoute(builder: (_) =>   StockManagement("importerInventory".tr()));

      case '/${PageName.dealerComPage}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

         Sale sale = arguments!['sale'];
        return MaterialPageRoute(builder: (_) =>   DealerComDetails(sale));

      case '/${PageName.overrideReportDist}':
        return MaterialPageRoute(builder: (_) =>   OverrideReportDist("overrideDetails".tr()));

      case '/${PageName.importerSummary}':
        return MaterialPageRoute(builder: (_) =>   ImporterSummary("importerInventorySummary".tr()));

      case '/${PageName.assignGlobalStock}':
        return MaterialPageRoute(builder: (_) =>   AssignGlobalStock("assignStock".tr()));

      case '/${PageName.overrideSettingsPage}':
        return MaterialPageRoute(builder: (_) =>   OverrideSettings("overrideSettings".tr()));

      case '/${PageName.searchOverridePage}':
        return MaterialPageRoute(builder: (_) =>   SearchOverride("overrideDetailsNamePosition".tr()));

      case '/${PageName.commissionSettings}':
        return MaterialPageRoute(builder: (_) =>   CommissionSettings("comSettings".tr()));

      case '/${PageName.searchComPage}':
        return MaterialPageRoute(builder: (_) =>   SearchCommission("comDetailsNamePosition".tr()));

      case '/${PageName.setOverrideUserPage}':
        return MaterialPageRoute(builder: (_) =>   SetOverrideUser("setOverrideUser".tr()));

      case '/${PageName.addWarehouse}':
        return MaterialPageRoute(builder: (_) =>   AddWarehouse("addWarehouse".tr()));

      case '/${PageName.payPeriodPage}':
        return MaterialPageRoute(builder: (_) =>   AddPayPeriod("comPayPeriodSettings".tr()));

      case '/${PageName.setWarehouses}':
        return MaterialPageRoute(builder: (_) =>   SetWarehouses("setWarehouses".tr()));

      case '/${PageName.commReport}':
        return MaterialPageRoute(builder: (_) =>  const CommissionReport());

      case '/${PageName.successBoard}':
        return MaterialPageRoute(builder: (_) =>  const DemoBoard());

      case '/${PageName.overrideWinner}':
        return MaterialPageRoute(builder: (_) =>  const OverrideReport());

      case '/${PageName.bonusWinnerReport}':
        return MaterialPageRoute(builder: (_) =>  const BonusWinnerReport());

      case '/${PageName.inventoryReportPage}':
        return MaterialPageRoute(builder: (_) =>  const InventoryReport());

      case '/${PageName.productCost}':
        return MaterialPageRoute(builder: (_) =>  ProductCost("overrideProductCost".tr()));

      case '/${PageName.appointmentBoard}':
        return MaterialPageRoute(builder: (_) =>  AppointmentBoardPage("appointmentBoard".tr()));

      case '/${PageName.weeklyApptBoard}':
        return MaterialPageRoute(builder: (_) =>  WeeklyAppt("weeklyApptBoard".tr()));

      case '/${PageName.salesBoard}':
        return MaterialPageRoute(builder: (_) =>  SalesBoardPage("salesBoard".tr()));

      case '/${PageName.bonusPage}':
        return MaterialPageRoute(builder: (_) =>  BonusPage("bonus".tr()));

      case '/${PageName.boardPage}':
        return MaterialPageRoute(builder: (_) =>  AdminBoard("board".tr()));

      case '/${PageName.dealerBoardPage}':
        return MaterialPageRoute(builder: (_) =>  Board("board".tr()));

      case '/${PageName.bonusWinnerPage}':
        return MaterialPageRoute(builder: (_) =>  BonusWinnerList("bonusList".tr()));

      case '/${PageName.commissionPage}':
        return MaterialPageRoute(builder: (_) =>  const CommissionPage());

      case '/${PageName.bonusWinner}':
        return MaterialPageRoute(builder: (_) =>  BonusWinner("bonusWinner".tr()));

      case '/${PageName.addProductCoast}':
        return MaterialPageRoute(builder: (_) =>  AddProductCoast("addProductCoast".tr()));

      case '/${PageName.myProgress}':
        return MaterialPageRoute(builder: (_) =>  MyProgress("myProgress".tr()));

      case '/${PageName.overridePage}':
        return MaterialPageRoute(builder: (_) =>  const OverridePage());


      case '/${PageName.adminProgress}':
        return MaterialPageRoute(builder: (_) =>  OfficeProgress("myProgress".tr()));

      case '/${PageName.dealerStockList}':
        return MaterialPageRoute(builder: (_) =>  DealerStockList("assignList".tr()));

      case '/${PageName.myAppointment}':
        return MaterialPageRoute(builder: (_) =>  const MyAppointment());

      case '/${PageName.myLeads}':
        return MaterialPageRoute(builder: (_) =>  const TotalLeads());

      case '/${PageName.totalLeadsReport}':
        return MaterialPageRoute(builder: (_) =>  const TotalLeadsReport());


      case '/${PageName.businessCenter}':
        return MaterialPageRoute(builder: (_) =>  BusinessCenter("businessCenter".tr()));


      case '/${PageName.completeDemo}':
        return MaterialPageRoute(builder: (_) =>  CompleteDemo("completeDemo".tr()));

      case '/${PageName.overrideScreen}':
        return MaterialPageRoute(builder: (_) =>  const AdminOverride());

      case '/${PageName.addOverrideScreen}':
        return MaterialPageRoute(builder: (_) =>  AddOverride("addOverride".tr()));

      case '/${PageName.expense}':
        return MaterialPageRoute(builder: (_) =>  const AllExpense());

      case '/${PageName.addExpense}':
        return MaterialPageRoute(builder: (_) =>  AddExpense("addExpense".tr()));

      case '/${PageName.expenseReport}':
        return MaterialPageRoute(builder: (_) =>  ExpenseReport("expenseReport".tr()));

      case '/${PageName.startDemo}':
        return MaterialPageRoute(builder: (_) =>  StartDemo("startDemo".tr()));

      case '/${PageName.startDemoAppointment}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        Data data = arguments!['data'];
        return MaterialPageRoute(builder: (_) =>  StartDemoAppointment(data));


      case '/${PageName.updateWarehousePage}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        WarehouseList data = arguments!['warehouse'];
        return MaterialPageRoute(builder: (_) =>  UpdateWarehouse(data));

      case '/${PageName.demoDetails}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
        DemoQuestions question = arguments!['question'];
        int demoId = arguments["demoId"];
        return MaterialPageRoute(builder: (_) =>  DemoQuestionPage(question,demoId));

      case '/${PageName.appointmentReport}':
        return MaterialPageRoute(builder: (_) =>  const AppointmentReport());

      case '/${PageName.registerPage}':
        return MaterialPageRoute(builder: (_) =>  RegisterView("register".tr()));

      case '/${PageName.mainHome}':
        return MaterialPageRoute(builder: (_) => const MainHome());

      case '/${PageName.home}':
        return MaterialPageRoute(builder: (_) => const Home(null));

      case '/${PageName.sale}':
        return MaterialPageRoute(builder: (_) =>  SalePage("salesActivity".tr()));

      case '/${PageName.notification}':
        return MaterialPageRoute(builder: (_) =>  WizzNotify("notification".tr()));

      case '/${PageName.contests}':
        return MaterialPageRoute(builder: (_) =>  const Contests());

      case '/${PageName.resources}':
        return MaterialPageRoute(builder: (_) =>  Resources("resources".tr()));

      case '/${PageName.myAccount}':
        return MaterialPageRoute(builder: (_) =>  MyAccount("myAccount".tr()));

      case '/${PageName.profile}':
        return MaterialPageRoute(builder: (_) =>   Profile("profile".tr()));

      case '/${PageName.uploadPhoto}':
        return MaterialPageRoute(builder: (_) =>  UploadPicture("updatePicture".tr()));

      case '/${PageName.updateEmail}':
        return MaterialPageRoute(builder: (_) =>  UpdateEmail("updateEmail".tr()));

      case '/${PageName.updatePassword}':
        return MaterialPageRoute(builder: (_) =>  UpdatePassword("updatePass".tr()));

      case '/${PageName.updateAddress}':
        return MaterialPageRoute(builder: (_) =>  UpdateAddress("updateAddress".tr()));

      case '/${PageName.updateSocial}':
        return MaterialPageRoute(builder: (_) =>  UpdateSocial("socialMedia".tr()));

      case '/${PageName.leadsAppointment}':
        return MaterialPageRoute(builder: (_) =>  LeadsAppointment("leadsAppointment".tr()));

      case '/${PageName.vacationDrawing}':
        return MaterialPageRoute(builder: (_) =>  VacationDrawing("vacationDrawing".tr()));


      case '/${PageName.trainingSection}':
        return MaterialPageRoute(builder: (_) =>  TrainingSection("trainingSection".tr()));

      case '/${PageName.addContact}':
        return MaterialPageRoute(builder: (_) =>  AddContact("addContact".tr()));

      case '/${PageName.allContest}':
        return MaterialPageRoute(builder: (_) =>  const AllContest());

      case '/${PageName.myContest}':
        return MaterialPageRoute(builder: (_) =>   const MyContests());

      case '/${PageName.saleDetails}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        Sale sale = arguments!['sale'];

        return MaterialPageRoute(builder: (_) =>  SaleDetails(sale));

      case '/${PageName.addSale}':
        Sale sale = Sale();
        return MaterialPageRoute(builder: (_)=> AddSale(sale));

      case '/${PageName.quickAddSale}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
        QuickSaleModel quickSaleModel = arguments!['quick'];
        int? demoLiveId = arguments['demoId'];
        Sale sale = Sale();
        return MaterialPageRoute(builder: (_)=> AddQuickSale(sale,quickSaleModel,demoLiveId));

      case '/${PageName.quickAddSaleEnterValue}':

        Sale sale = Sale();
        return MaterialPageRoute(builder: (_)=> QuickSaleValue(sale));

      case '/${PageName.mySaleTabBar}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        int initialIndex = arguments!['index'];
        return MaterialPageRoute(builder: (_)=>  MySaleTab(initialIndex));

      case '/${PageName.officeSaleTabBar}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        int initialIndex = arguments!['index'];
        return MaterialPageRoute(builder: (_)=>  OfficeSaleTab(initialIndex));

      case '/${PageName.resourceTabBar}':
        String? appBarName = settings.arguments as String;

        return MaterialPageRoute(builder: (_)=> ResourceTabBar(appBarName,null));



      case '/${PageName.videoPage}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        String title = arguments!['title'].toString();
        String url = arguments['url'].toString();

        return MaterialPageRoute(builder: (_)=> VideoPage(title,url));

      case '/${PageName.pdfPage}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
        String title = arguments!['title'].toString();
        String url = arguments['url'].toString();
        return MaterialPageRoute(builder: (_)=> PdfPage(title,url));

      case '/${PageName.leadDetails}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        List<Lead> detail = arguments!['detail'];
        return MaterialPageRoute(builder: (_) =>  LeadDetails(detail));

      case '/${PageName.leadReport}':
        return MaterialPageRoute(builder: (_) => const LeadReportTabBar());

      case '/${PageName.goalsReport}':
        return MaterialPageRoute(builder: (_) =>  GoalsReportPage("goalsReport".tr()));
        //admin pages

      case '/${PageName.adminHome}':
        return MaterialPageRoute(builder: (_) => const AdminMainHome());

      case '/${PageName.adminSalesTab}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        String type = arguments!['type'];
        return MaterialPageRoute(builder: (_) =>  AdminSaleTab(type));

      case '/${PageName.adminCustomerSalesTab}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        String type = arguments!['type'];
        return MaterialPageRoute(builder: (_) =>  AdminCustomerSaleTab(type));

      case '/${PageName.adminSetting}':
        return MaterialPageRoute(builder: (_) =>  AdminSettings("settings".tr()));

      case '/${PageName.adminReport}':
        return MaterialPageRoute(builder: (_) =>  AdminReport("report".tr()));

      case '/${PageName.adminCList}':
        return MaterialPageRoute(builder: (_) =>  const CustomerList());

      case '/${PageName.adminRewardOrder}':
        return MaterialPageRoute(builder: (_) =>  const RewardOrders());

      case '/${PageName.adminReferralList}':
        return MaterialPageRoute(builder: (_) =>  const ReferralList());

      case '/${PageName.adminCustomerEvent}':
        return MaterialPageRoute(builder: (_) =>  const CustomerEventPage());

      case '/${PageName.adminSerialNumberEnter}':
        return MaterialPageRoute(builder: (_) =>  const SerialNumberList());



      case '/${PageName.adminCommissionWinner}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        int? id = arguments!['id'];
        return MaterialPageRoute(builder: (_) =>  AdminComWinner(id));

      case '/${PageName.adminCustomerSaleDetails}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        Sale sale = arguments!['sale'];
        return MaterialPageRoute(builder: (_) =>  CustomerDetails(sale));

      case '/${PageName.adminEditComRate}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        Detail detail = arguments!['detail'];
        return MaterialPageRoute(builder: (_) =>  EditCommissionRate(detail));

      case '/${PageName.adminSaleDetails}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        Sale sale = arguments!['sale'];
        return MaterialPageRoute(builder: (_) =>  AdminSaleDetails(sale));

      case '/${PageName.adminStockPages}':
        return MaterialPageRoute(builder: (_) =>   StockPage("importerInventory".tr()));

      case '/${PageName.addBonusScreen}':
        return MaterialPageRoute(builder: (_) =>   const AdminAddBonus());

      case '/${PageName.bonusScreen}':
        return MaterialPageRoute(builder: (_) =>   const AdminBonus());

      case '/${PageName.adminDigitalSignature}':
        return MaterialPageRoute(builder: (_) =>  AdminPaperWork("paperWork".tr()));

      case '/${PageName.adminManagePaper}':
        return MaterialPageRoute(builder: (_) =>  AdminManagePaper("managePaperWork".tr()));

      case '/${PageName.adminDistStock}':
        return MaterialPageRoute(builder: (_) =>  DistStock("inventoryOperations".tr()));

      case '/${PageName.adminStockDetails}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
        int id = arguments!['id'];
        int assign = arguments['assign'];
        int total = arguments['total'];
        return MaterialPageRoute(builder: (_) =>   StockDetails(id,assign,total));

      case '/${PageName.adminAllContest}':
        return MaterialPageRoute(builder: (_) =>   AdminContest("allContest".tr()));

      case '/${PageName.adminManageGoals}':
        return MaterialPageRoute(builder: (_) =>   AdminManageGoals("manageGoals".tr()));

      case '/${PageName.adminCarousel}':
        return MaterialPageRoute(builder: (_) =>   AllCarousel("allCarousel".tr()));

      case '/${PageName.adminAddCarousel}':
        return MaterialPageRoute(builder: (_) =>   AddCarousel("addCarousel".tr()));

      case '/${PageName.adminCommission}':
        return MaterialPageRoute(builder: (_) =>   const Commission());

      case '/${PageName.adminScanProduct}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
        int id = arguments!['id'];
        int assign = arguments['assign'];
        dynamic total = arguments['total'];
        String? beginSerial = arguments['beginSerial'];
        String? endSerial = arguments['endSerial'];
        return MaterialPageRoute(builder: (_) =>    ScanStockBarcode(id,assign,total,beginSerial,endSerial));

      case '/${PageName.saleComDetails}':
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

        Sale sale = arguments!['sale'];
        return MaterialPageRoute(builder: (_) =>  CommissionDetails(sale));

      case '/${PageName.adminAddCom}':

        return MaterialPageRoute(builder: (_) =>  const AddCommission());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(
          body: Center(
            child: Text('Hatalı Rota'),
          ),
        )
        );
    }
  }
}