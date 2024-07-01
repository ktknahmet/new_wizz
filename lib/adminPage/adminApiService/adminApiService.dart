import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wizzsales/adminPage/adminModel/adminContestModel/AdminContestModel.dart';
import 'package:wizzsales/adminPage/adminModel/carousel/SliderPayload.dart';
import 'package:wizzsales/adminPage/adminModel/contractModel/AdminContractList.dart';
import 'package:wizzsales/adminPage/adminModel/contractModel/AdminSignature.dart';
import 'package:wizzsales/adminPage/adminModel/customerEventModel/CustomerEventModel.dart';
import 'package:wizzsales/adminPage/adminModel/customerListModel/cListmodel.dart';
import 'package:wizzsales/adminPage/adminModel/stockReportModel/stockReportData.dart';
import 'package:wizzsales/adminPage/adminModel/customerListModel/postCList.dart';
import 'package:wizzsales/adminPage/adminModel/enterSerialModel/EnterSerial.dart';
import 'package:wizzsales/adminPage/adminModel/postModel/adminResponse.dart';
import 'package:wizzsales/adminPage/adminModel/referralListModel/ReferralModel.dart';
import 'package:wizzsales/adminPage/adminModel/rewardOrderModel/rewardOrderModel.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/organisations/allOrganisations.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/pool/poolHistory.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/pool/poolListDetails.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/pool/stockPool.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/poolDistributor/poolDistributor.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postPool/poolProductSave.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postPool/stockPostResponse.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/product/StockProduct.dart';
import 'package:wizzsales/adminPage/adminModel/stockReportModel/stockReportModel.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/constants/ApiEndpoints.dart';
import 'package:wizzsales/model/contractModel/contractType.dart';
import 'package:wizzsales/model/contractModel/distributorContract.dart';
import 'package:wizzsales/model/saleDocument/getSaleDocument.dart';
import 'package:wizzsales/model/saleDocument/saleDocument.dart';
part 'adminApiService.g.dart';

@RestApi(baseUrl:ApiEndpoints.adminBase)
abstract class AdminApiService{
  factory AdminApiService(Dio dio) = _AdminApiService;

  static AdminApiService create(){
    return AdminApiService(AdminModule().baseService(""));
  }
  @GET(ApiEndpoints.adminCList)
  Future<CListModel> getCustomerList(
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize);

  @GET(ApiEndpoints.adminSerialEnter)
  Future<EnterSerial> getSerialNum(
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize);

  @GET(ApiEndpoints.adminRewardOrder)
  Future<RewardOrderModel> getRewardOrder(
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize);

  @GET(ApiEndpoints.adminReferralList)
  Future<ReferralModel> getReferralList(
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize);

  @GET(ApiEndpoints.adminCustomerEvent)
  Future<CustomerEventModel> getCustomerEvent(
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize);

  @GET(ApiEndpoints.saleDocument)
  Future<List<SaleDocument>> getSaleDocumentTypes();

  @GET(ApiEndpoints.getSlider)
  Future<List<SliderPayload>> getAllSlider();

  @DELETE(ApiEndpoints.deleteSlider)
  Future<bool> deleteSlider(
      @Query("sliderId") int sliderId);

  @GET(ApiEndpoints.getSaleDocument)
  Future<List<GetSaleDocument>> getSaleDocument(@Path("saleId") int saleId);

  @GET(ApiEndpoints.getDistributorContract)
  Future<List<DistributorContract>> getDistributorContract(@Path("distributorId") int distributorId);

  @GET(ApiEndpoints.adminContract)
  Future<List<AdminContractList>> getAdminContract();

  @POST(ApiEndpoints.adminContract)
  @MultiPart()
  Future<HttpResponse> postAdminContract(
      @Part() String ContractName,
      @Part() List<String> DistributorIds,
      @Part() File File);


  @GET(ApiEndpoints.distributorContractType)
  Future<List<ContractType>> distributorContractType(@Path("distributorId") int distributorId);

  @GET(ApiEndpoints.getDistSignature)
  Future<List<AdminSignature>> distributorSignature(@Path("distributorId") int distributorId);

  @POST(ApiEndpoints.updateCustomerEvent)
  Future<AdminResponse> updateCEvent(@Body() PostCList post);

  @GET("https://hylana.wizz.app/api/v16/stock-pools/reports")
  Future<List<StockReportDataDetails>> getStockReportListAllData(
      @Query("beginDate") String? beginDate,
      @Query("endDate") String? endDate,
      @Query("distributor_id") int? distId,
      @Query("export") String? download);

  @PATCH(ApiEndpoints.approveRewardOrder)
  Future<AdminResponse> updateApproveReward(@Path("transactionCode") String code);

  @PATCH(ApiEndpoints.cancelRewardOrder)
  Future<AdminResponse> cancelApproveReward(@Path("transactionCode") String code);

  @PATCH(ApiEndpoints.usedRewardOrder)
  Future<AdminResponse> usedReward(@Path("transactionCode") String code);

  @GET("https://hylana.wizz.app/api/v16/getContest")
  Future<AdminContestModel> getAllContest(
      @Query("page") int page,);


  @POST("https://hylana.wizz.app/api/v16/stock-pools")
  Future<int> postStockPool(@Body() StockPool pool);

  @GET("https://hylana.wizz.app/api/v16/stock-pools")
  Future<List<GetPoolHistory>> getPoolHistory();

  @GET("https://hylana.wizz.app/api/v16/stock-pools/products")
  Future<List<StockProduct>> getStockProduct();

  @GET("https://hylana.wizz.app/api/v16/stock-pools/organisations")
  Future<List<AllOrganisations>> allOrganisations();



  @GET("https://hylana.wizz.app/api/v16/stock-pools/{id}/details")
  Future<List<PoolListDetails>> getPoolList(@Path("id") int poolId);

  @POST("https://hylana.wizz.app/api/v16/stock-pools/products")
  Future<StockPostResponse> postPool(@Body() PoolProductSave save);

  @POST("https://hylana.wizz.app/api/v16/assign-stock")
  Future<String> detailsPost(@Body() List<PoolDistributor> poolDistributor);

  @POST(ApiEndpoints.postDistContract)
  @MultiPart()
  Future<HttpResponse> postDistContract(@Part() int DistributorId,@Part() int ContractId,@Part() File ContractFile);

  @POST(ApiEndpoints.postDistSignature)
  @MultiPart()
  Future<HttpResponse> postDistSignature(@Part() int DistributorId,@Part() File SignatureFile);

  @POST(ApiEndpoints.postSaleDocument)
  @MultiPart()
  Future<HttpResponse> postSaleDoc(@Part() int SaleDocumentTypeId,@Part() int SaleId,@Part() int UserId,
      @Part() String Note,@Part() File Document, @Part() int OrganisationId);

  @POST(ApiEndpoints.postExpense)
  @MultiPart()
  Future<HttpResponse> postExpensesData(@Part() int ExpenseTypeId,@Part() int UserId,@Part() int? SaleId,
      @Part() int OrganisationId,@Part() double ExpenseNetPrice,@Part() double ExpenseTaxPrice,
      @Part() String ExpenseDate, @Part() File Document,@Part() int? StartMil,@Part() int? EndMil);

  @POST(ApiEndpoints.postSlider)
  @MultiPart()
  Future<HttpResponse> postSlider(@Part() String SliderViewName,@Part() int SliderOrder,
      @Part() String OnClick,@Part() File OnClickFile,@Part() String SliderType,@Part() File File);

  @POST(ApiEndpoints.postSlider)
  @MultiPart()
  Future<HttpResponse> postSliderLink(@Part() String SliderViewName,@Part() int SliderOrder,
      @Part() String OnClick,@Part() String SliderType,@Part() File File);
}