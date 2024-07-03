import 'dart:core';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/boardListModel.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusOverlapping.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusRuleList.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusTypes.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusWinnerList.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/postBonus.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/checkComAdd.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comAmount.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comDetails.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comExist.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comInactive.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comRateExtendDate.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comReportModel.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comSaleDetails/ComSaleDetails.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionList.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionPost.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionTypes.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionWinner.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPeriod/getPayPeriod.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPeriod/postPayPeriod.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPost.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/postAdjust.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/updateComRate.dart';
import 'package:wizzsales/adminPage/adminModel/inventoryModel/postDistInventoryWarehouse.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/allOverride.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/orgDetails.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideReports.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideType.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserDelete.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserList.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserPost.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideWinner.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/postOverride.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/postProductCoast.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/productCoastList.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/updateProductCoast.dart';
import 'package:wizzsales/adminPage/adminModel/roles/allRoles.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/distStockList/DistStockList.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postStockDealer/postStockDealer.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/stockDealer/stockDealer.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/stockHistory/stockHistory.dart';
import 'package:wizzsales/adminPage/adminModel/stockPayModel/postStockPay.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseDelete.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseList.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehousePost.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseUpdate.dart';
import 'package:wizzsales/constants/ApiEndpoints.dart';
import 'package:wizzsales/model/OLD/Draw.dart';
import 'package:wizzsales/model/OLD/leadReport/LeadReport.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/allUsers/allUser.dart';
import 'package:wizzsales/model/appointmentModel/AppointmentModel.dart';
import 'package:wizzsales/model/appointmentModel/Data.dart';
import 'package:wizzsales/model/appointmentModel/appointmentValues/AppintmentValues.dart';
import 'package:wizzsales/model/appointmentModel/editAppointmentModel/editAppointment.dart';
import 'package:wizzsales/model/appointmentModel/response/responseAppointment.dart';
import 'package:wizzsales/model/bonusWinnerModel/bonusWinnerDealer.dart';
import 'package:wizzsales/model/demoModel/demoNote.dart';
import 'package:wizzsales/model/demoModel/demoQuestions.dart';
import 'package:wizzsales/model/demoModel/demoUnsuccessModel.dart';
import 'package:wizzsales/model/demoModel/liveDemoList.dart';
import 'package:wizzsales/model/demoModel/postDemoQuestion.dart';
import 'package:wizzsales/model/demoModel/postLiveDemo.dart';
import 'package:wizzsales/model/detailsReportModel/DetailReportModel.dart';
import 'package:wizzsales/model/expenseModel/allExpenseModel.dart';
import 'package:wizzsales/model/expenseModel/expenseSale.dart';
import 'package:wizzsales/model/expenseModel/expenseTypes.dart';
import 'package:wizzsales/model/goals/UserGoals.dart';
import 'package:wizzsales/model/leadModel/leadStatusList.dart';
import 'package:wizzsales/model/leadModel/leadStatusPost.dart';
import 'package:wizzsales/model/loginModel/Login.dart';
import 'package:wizzsales/model/overrideModel/dealerOverrideWinner.dart';
import 'package:wizzsales/model/reset/ResetModel.dart';
import 'package:wizzsales/model/saleDocument/postReceiveAmount.dart';
import 'package:wizzsales/model/saleDocument/saleDeduction.dart';
import 'package:wizzsales/model/socialModel/SocialMedia.dart';
import 'package:wizzsales/model/socialModel/postSocial.dart';
import 'package:wizzsales/model/stockCheckIn/returnStock.dart';
import 'package:wizzsales/model/stockModel/assignDealerList.dart';
import 'package:wizzsales/service/ServiceModule.dart';

import '../../adminPage/adminModel/inventoryModel/allAssignStock.dart';
import '../../adminPage/adminModel/postGoals/PostGoals.dart';

part 'ApiService.g.dart';

@RestApi(baseUrl:ApiEndpoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  static ApiService create() {
    return ApiService(ServiceModule().baseService("","",""));
  }

  @GET(ApiEndpoints.assignStockBefore)
  Future<bool> checkStockBefore(@Query("serial_number") String serialId);

  @POST(ApiEndpoints.login)
  Future<LoginUser> loginUser(@Body() Login user);

  @POST(ApiEndpoints.reset)
  Future<String> resetPassword(@Body() ResetModel resetModel);


  @POST(ApiEndpoints.postDemoQuestion)
  Future<String> postDemoQuestions(@Body() List<PostDemoQuestion> postDemoQuestion);

  @GET(ApiEndpoints.myAppointment)
  Future<AppointmentModel> getAppointment(@Query("page") int page);

  @GET(ApiEndpoints.allAppointment)
  Future<List<Data>> getAllAppointment();

  @GET(ApiEndpoints.goalsDetails)
  Future<List<UserGoals>> getGoals();

  @GET(ApiEndpoints.getExpense)
  Future<List<AllExpenseModel>> getAllExpense();

  @GET(ApiEndpoints.leadsReport)
  Future<List<LeadReport>> getAllLeads();

  @GET(ApiEndpoints.leadStatus)
  Future<List<LeadStatusList>> getLeadStatus();

  @POST(ApiEndpoints.leadStatus)
  Future<String> postLeadStatus(@Body() LeadStatusPost leadStatusPost);

  @GET(ApiEndpoints.getExpense)
  Future<List<AllExpenseModel>> getAllExpenseReport(
      @Query("startDate") String startDate,
      @Query("endDate") String endDate);

  @POST(ApiEndpoints.assignSale)
  Future<String> postAssignSale(
      @Query("sale_id") int saleId,
      @Query("demo_live_id") int demoId);

  @GET(ApiEndpoints.expenseTypes)
  Future<List<ExpenseType>> expenseTypes();

  @POST(ApiEndpoints.goalsDetails)
  Future<String> postGoals(@Body() PostGoalReport postGoalReport);

  @GET(ApiEndpoints.edtAppointmentList)
  Future<AppointmentValues> editAppointment(@Query("lead") int lead);

  @GET(ApiEndpoints.expenseSaleList)
  Future<List<ExpenseSale>> saleList();

  @GET(ApiEndpoints.demoList)
  Future<List<LiveDemoList>> allDemos();

  @POST(ApiEndpoints.postUnDemo)
  Future<List<DemoUnsuccessModel>> postUnsuccessDemo(@Body() List<DemoUnsuccessModel> model);

  @POST(ApiEndpoints.postDemoNote)
  Future<String> postDemoNotes(@Body() DemoNote demoNote);

  @GET(ApiEndpoints.leadlist)
  Future<List<Draw>> leadList();

  @GET(ApiEndpoints.liveDemoList)
  Future<List<LiveDemoList>> liveDemoList();

  @GET(ApiEndpoints.adminStockDealer)
  Future<List<StockDealer>> getStockDealer();

  @GET(ApiEndpoints.allComReport)
  Future<List<ComReportModel>> getComReport(
      @Query("begin_date") String beginDate,
      @Query("end_date") String endDate);

  @GET(ApiEndpoints.saleDetail)
  Future<List<ComSaleDetails>> getSaleDetails(
      @Query("serialnumber") String serialNumber);

  @GET(ApiEndpoints.allRoles)
  Future<List<AllRoles>> getAllRoles();

  @GET(ApiEndpoints.adminGetCommission)
  Future<List<CommisionList>> getCommission();

  @GET(ApiEndpoints.comReport)
  Future<ComDetails> getCommReport();

  @GET(ApiEndpoints.commissionTypes)
  Future<List<CommisionTypes>> getCommissionTypes();

  @GET(ApiEndpoints.commissionWinner)
  Future<List<CommissionWinner>> getCommissionWinner(
      @Query("calc_pool_id") int? id,
      @Query("pay_period") String? period,
      @Query("pay_date") String? date);

  @GET(ApiEndpoints.commissionWinner)
  Future<List<CommissionWinner>> getSaleComDetail(
      @Query("sale_id") int? id);

  @GET(ApiEndpoints.adminStockList)
  Future<List<DistStockList>> getStockList(@Query("distributor_id") int? id);

  @GET(ApiEndpoints.overrideType)
  Future<List<OverrideType>> getOverrideTypes();

  @GET(ApiEndpoints.getAllUser)
  Future<List<AllUsers>> getAllUser();

  @GET(ApiEndpoints.orgDetails)
  Future<List<OrgDetails>> getOrgDetails();

  @GET(ApiEndpoints.overrideWinnerDealer)
  Future<List<DealerOverrideWinner>> getDealerOverrideWinner();

  @GET(ApiEndpoints.overrideReports)
  Future<OverrideReports> getOverrideReports();

  @GET(ApiEndpoints.getProductCoast)
  Future<List<ProductCoastList>> getProductCoast(@Query("distributor_id") int? id);

  @GET(ApiEndpoints.bonusWinner)
  Future<List<BonusWinnerList>> getBonusWinner();

  @GET(ApiEndpoints.bonusWinnerDealer)
  Future<List<BonusWinnerDealerList>> getBonusWinnerDealer();

  @GET(ApiEndpoints.bonusRule)
  Future<List<BonusRuleList>> getBonusRule();

  @POST(ApiEndpoints.bonusRule)
  Future<String> postBonus(@Body() PostBonus postBonus);

  @GET(ApiEndpoints.bonusTypes)
  Future<List<BonusTypes>> getBonusTypes();

  @POST(ApiEndpoints.bonusOverlapping)
  Future<String> postOverlapping(@Body() BonusOverlapping overlapping);

  @PUT(ApiEndpoints.getProductCoast)
  Future<String> updateProductCoast(@Body() UpdateProductCoast update);

  @POST(ApiEndpoints.getProductCoast)
  Future<String> postProductCoast(@Body() PostProductCoast post);

  @GET(ApiEndpoints.overrideWinner)
  Future<List<AdminOverrideWinner>> getOverrideWinner(
      @Query("begin_date") String? beginDate,
      @Query("end_date") String? endDate);

  @GET(ApiEndpoints.overrideWinner)
  Future<List<AdminOverrideWinner>> getOverrideWinnerDetail(
      @Query("pay_date") String? payDate);

  @GET(ApiEndpoints.allOverride)
  Future<List<AllOverride>> allOverride();

  @POST(ApiEndpoints.overrideUserDelete)
  Future<String> deleteOverrideUser(@Body() OverrideUserDelete deleteOverride);

  @GET(ApiEndpoints.overrideUser)
  Future<List<OverrideUserList>> allOverrideUser();

  @POST(ApiEndpoints.overrideUser)
  Future<String> postOverrideUser(@Body() OverrideUserPost postOverride);

  @GET(ApiEndpoints.assignDealar)
  Future<List<AssignDealerList>> getAssignList();

  @GET(ApiEndpoints.warehouses)
  Future<List<WarehouseList>> getWarehouses(
      @Query("distributor_id") int? distId);

  @GET(ApiEndpoints.allAssignStock)
  Future<List<AllAssignStock>> getAssignStock(
      @Query("serial_number") String? serial
      );

  @POST(ApiEndpoints.warehouses)
  Future<String> postWarehouse(@Body() WarehousePost warehousePost);

  @POST(ApiEndpoints.deleteWarehouses)
  Future<String> deleteWarehouse(@Body() WarehouseDelete delete);

  @POST(ApiEndpoints.updateWarehouses)
  Future<String> updateWarehouse(@Body() WarehouseUpdate warehousePost);

  @GET(ApiEndpoints.board)
  Future<BoardListModel> getBoard();

  @GET(ApiEndpoints.payPeriod)
  Future<GetPayPeriod> getPayPeriod();

  @POST(ApiEndpoints.postOverride)
  Future<String> postOverride(@Body() PostOverride postOverride);

  @POST(ApiEndpoints.adminPostStockDealer)
  Future<String> postStockDealer(@Body() PostStockDealer postStockDealer);

  @POST(ApiEndpoints.salesDeduction)
  Future<String> postSaleDeduction(@Body() SaleDeduction deduction);

  @POST(ApiEndpoints.postReceiveAmount)
  Future<String> postSaleAmount(@Body() PostReceiveAmount receive);

  @PATCH(ApiEndpoints.updateComRate)
  Future<String> updateRate(@Body() UpdateComRate update);

  @POST(ApiEndpoints.comExist)
  Future<String> checkComExist(@Body() ComExist exist);

  @POST(ApiEndpoints.payPeriod)
  Future<String> postPayPeriod(@Body() PostPayPeriod postPay);

  @POST(ApiEndpoints.stockPay)
  Future<String> postStockPay(@Body() PostStockPay postStock);

  @POST(ApiEndpoints.postDistWarehouse)
  Future<String> postDistWarehouse(@Body() PostDistInventoryWarehouse post);

  @POST(ApiEndpoints.comInactive)
  Future<String> updateInactive(@Body() ComInactive post);

  @POST(ApiEndpoints.comActive)
  Future<String> updateActive(@Body() ComInactive post);

  @POST(ApiEndpoints.comExtendDate)
  Future<String> updateExtendDate(@Body() ComRateExtendDate extendDate);

  @POST(ApiEndpoints.stockReturnDist)
  Future<String> returnStock(@Body() ReturnStock returnStock);

  @POST(ApiEndpoints.adminPostPay)
  Future<String> postPay(@Body() PayPost payPost);

  @POST(ApiEndpoints.adminReturnPostPay)
  Future<String> returnPostPay(@Body() PayPost payPost);

  @POST(ApiEndpoints.commPostAmount)
  Future<String> postComAmount(@Body() ComAmount comAmount);

  @POST(ApiEndpoints.postComAdjust)
  Future<String> postComAdjust(@Body() PostAdjust postAdjust);

  @POST(ApiEndpoints.postCommission)
  Future<int> postCommission(@Body() CommisionPost post);

  @POST(ApiEndpoints.checkCurrentAddCom)
  Future<String> checkComAdd(@Body() CheckComAdd post);

  @GET(ApiEndpoints.reportDetails)
  Future<DetailReportModel> detailReport(
      @Query("userid") int id,
      @Query("organisationid") int org);

  @POST(ApiEndpoints.completeDemo)
  Future<DemoQuestions> completeDemo(
      @Query("status") int status,
      @Query("demo_live_id") int demoId);

  @GET(ApiEndpoints.getSocial)
  Future<List<SocialMedia>> getSocial(
      @Query("facebookUserName") String facebook,
      @Query("twitterUserName") String twitter,
      @Query("instagramUserName") String instagram,
      @Query("tiktokUserName") String tiktok,
     );

  @GET(ApiEndpoints.stockHistory)
  Future<List<StockHistory>> getStockHistory(
      @Query("pool_detail_id") int poodId);

  @POST(ApiEndpoints.getSocial)
  Future<String> postSocial(@Body() PostSocial postSocial);

  @POST(ApiEndpoints.postLiveDemo)
  Future<String> postStartDemo(@Body() PostLiveDemo postLiveDemo);

  @POST(ApiEndpoints.postAppointment)
  Future<ResponseAppointment> postAppointment(@Body() EditAppointmentModel postAppointment);
}