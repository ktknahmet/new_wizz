import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminModel/inventoryModel/postDistInventoryWarehouse.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/distStockList/DistStockList.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/organisations/allOrganisations.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/pool/poolHistory.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/pool/poolListDetails.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/pool/stockPool.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/poolDistributor/poolDistributor.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postPool/poolProductSave.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postPool/poolStockProduct.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postPool/stockPostResponse.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postStockDealer/postStockDealer.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/product/StockProduct.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/stockDealer/stockDealer.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/stockHistory/stockHistory.dart';
import 'package:wizzsales/adminPage/adminModel/stockPayModel/postStockPay.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseList.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/stockCheckIn/returnStock.dart';
import 'package:wizzsales/model/stockModel/assignDealerList.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../adminModel/inventoryModel/allAssignStock.dart';
// ignore_for_file: use_build_context_synchronously

class StockVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  Barcode? result;
  String query="";
  String stockQuery="";
  int? response;
  String? postStock;
  List<AssignDealerList>? assignList;
  List<StockHistory>? stockHistory;
  List<GetPoolHistory>? getPoolHistory;
  List<StockProduct>? stockProduct;
  List<PoolListDetails> poolList=[];
  List<DistStockList>? distStockList;
  List<PoolDistributor>? distributorList;
  List<AllOrganisations>? organisations;
  List<PoolStockProduct> poolStock=[];
  List<AllAssignStock>? allAssignStock;
  List<WarehouseList>? warehouseList;
  List<StockDealer>? stockDealer;
  StockPostResponse? postResponse;
  String detailsPostResponse="";
  List<PoolDistributor> postList=[];
  List<StockProduct> products =[];
  int? productId;
  PermissionStatus? status;

  LoginUser? loginUser;
  TextEditingController distWarehouseName = TextEditingController();
  int? distWarehouseId;
  TextEditingController distributorId = TextEditingController();
  TextEditingController warehouseName = TextEditingController();
  TextEditingController importerWarehouse = TextEditingController();
  int? distId;
  User? user;
  int index=0;
  List<Map<String, bool>> gridMap = [];
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');


  void addPoolListWithModel(List<AllAssignStock> list) {
    // Seçilen elemanları tutacak geçici bir liste oluşturalım
    List<PoolListDetails> selectedDetails = [];

    for (int i = 0; i < list.length; i++) {
      if (list[i].check == true) {
        PoolListDetails details = PoolListDetails(
          poolDetailId: list[i].poolDetailId,
          stockPoolId: list[i].stockPoolId,
          productId: list[i].productId,
          productName: list[i].productName,
          stockDate: list[i].stockDate,
          quantity: list[i].quantity,
          serialNumber: list[i].serialNumber,
          distributorId: distId ?? list[i].distributorId,
          assignedToDistributor: list[i].assignedToDistributor,
          isPaid: list[i].isPaid,
          paidDate: list[i].paidAt,
          distWarehouseId: distWarehouseId,
          importerWarehouseName: list[i].importerWarehouseName,
          distWarehouseName: distWarehouseName.text.isEmpty ? list[i].distributorWarehouseName : distWarehouseName.text,

        );

        selectedDetails.add(details);
      }
    }

    if (poolList.isEmpty || poolList.isNotEmpty) {
      PoolListDetails firstDetail = PoolListDetails(
        poolDetailId: list[0].poolDetailId,
        stockPoolId: list[0].stockPoolId,
        productId: list[0].productId,
        productName: list[0].productName,
        stockDate: list[0].stockDate,
        quantity: list[0].quantity,
        serialNumber: list[0].serialNumber,
        distributorId: distId ?? list[0].distributorId,
        assignedToDistributor: list[0].assignedToDistributor,
        isPaid: list[0].isPaid,
        paidDate: list[0].paidAt,
        distWarehouseId: distWarehouseId,
        importerWarehouseName: list[0].importerWarehouseName,
        distWarehouseName: distWarehouseName.text.isEmpty ? list[0].distributorWarehouseName : distWarehouseName.text,
      );

      poolList.add(firstDetail);

      // Seçilen diğer elemanları kontrol edelim
      for (int i = 1; i < selectedDetails.length; i++) {
        bool existsInPoolList = false;

        // Seri numarası kontrolü yapalım
        for (var existingDetail in poolList) {
          if (existingDetail.serialNumber == selectedDetails[i].serialNumber) {
            existsInPoolList = true;
            break; // Eşleşme bulunduğunda döngüden çıkalım
          }
        }
        // Eğer seri numarası poolList içinde yoksa, ekleyelim
        if (!existsInPoolList) {
          poolList.add(selectedDetails[i]);
        }
      }
    }
    notifyListeners();
  }
  addPoolList(BuildContext context,AllAssignStock stock,String serial){

    if(poolList.isEmpty){
      PoolListDetails details = PoolListDetails(
        poolDetailId: stock.poolDetailId,
        stockPoolId: stock.stockPoolId,
        productId: stock.productId,
        productName: stock.productName,
        stockDate: stock.stockDate,
        quantity: stock.quantity,
        serialNumber: stock.serialNumber,
        distributorId: distId ?? stock.distributorId,
        assignedToDistributor: stock.assignedToDistributor,
        isPaid: stock.isPaid,
        paidDate: stock.paidAt,
        distWarehouseId: distWarehouseId,
        importerWarehouseName: stock.importerWarehouseName,
        distWarehouseName: distWarehouseName.text.isEmpty ? stock.distributorWarehouseName : distWarehouseName.text,

      );
      poolList.add(details);
    }else{
      bool check = false;
      for(int i=0;i<poolList.length;i++){
        if(poolList[i].serialNumber == serial){
          check = true;
        }
      }
      if(!check){
        PoolListDetails details = PoolListDetails(
          poolDetailId: stock.poolDetailId,
          stockPoolId: stock.stockPoolId,
          productId: stock.productId,
          productName: stock.productName,
          stockDate: stock.stockDate,
          quantity: stock.quantity,
          serialNumber: stock.serialNumber,
          distributorId: distId ?? stock.distributorId,
          assignedToDistributor: stock.assignedToDistributor,
          isPaid: stock.isPaid,
          paidDate: stock.paidAt,
          distWarehouseId: distWarehouseId,
          importerWarehouseName: stock.importerWarehouseName,
          distWarehouseName: distWarehouseName.text.isEmpty ? stock.distributorWarehouseName : distWarehouseName.text,

        );
        poolList.add(details);
      }else{
        snackBarDesign(context, StringUtil.error, "thisSerialWasAdd".tr());
      }
    }

    notifyListeners();
  }

  setAssignStockCheckbox(int index,bool value,List<AllAssignStock> list){
    list[index].check = value;
    notifyListeners();
  }
  clearDistWarehouseName(){
    distWarehouseName.clear();
    notifyListeners();
  }
  setPaidWithIndex(List<PoolListDetails> list ,int index){
    if(list[index].isPaid == true){
      list[index].isPaid = false;
      list[index].paidDate = null;
    }else{
      list[index].isPaid = true;
      list[index].paidDate = formatDate(DateTime.now().toString());
    }

    notifyListeners();
  }

  setProductId(int id){
    productId = id;
    notifyListeners();
  }
  addProducts(StockProduct product){
    products.add(product);
    notifyListeners();
  }


  setAllDistIdWith(String distName,int id){
    distWarehouseName.text = distName;
    distWarehouseId = id;

    for(int i=0;i<poolList.length;i++){
      if(poolList[i].distWarehouseId ==null){
        poolList[i].distributorId = distId;
        poolList[i].distWarehouseId = id;
        poolList[i].distWarehouseName = distWarehouseName.text;
      }
    }
    notifyListeners();
  }
  setAllDistId(String distName,int id){
    distributorId.text = distName;
    distId = id;
    notifyListeners();
  }
  setDistIdPoolStock(int index,int id){
    poolStock[index].distributorId = id;
    notifyListeners();
  }
  setDistId(String serial,int id){
    for(int i=0;i<poolList.length;i++){
      print("serial number $serial  --${poolList[i].serialNumber}");
      if(poolList[i].serialNumber == serial){
        poolList[i].distributorId = id;
      }
    }
    notifyListeners();
  }

  setDistSpesificWarehouse(int index,int id,String name){
    poolList[index].distWarehouseId = id;
    poolList[index].distWarehouseName = name;
    notifyListeners();
  }
  setDistWarehouse(int distId,String value){
    warehouseName.text = value;
    for(int i=0;i<poolList.length;i++){
      poolList[i].distWarehouseId = distId;
      poolList[i].distWarehouseName = value;
    }

    notifyListeners();
  }
  setDistWarehouseName(int index,String value){
    poolStock[index].distWarehouseName = value;
    notifyListeners();
  }
  setImporterWarehouseName(String value,int id){
    importerWarehouse.text = value;
    for(int i=0;i<poolStock.length;i++){
      if(poolStock[i].importerWarehouseName ==null){
        poolStock[i].importerWarehouseName = value;
        poolStock[i].distWarehouseId  =id;
      }
    }
    notifyListeners();
  }
  addGridMap(Map<String,bool> map){
    gridMap.add(map);
    notifyListeners();
  }

  setGridMap(String key,bool value) {

    for (int i = 0; i < gridMap.length; i++) {
      if (gridMap[i].containsKey(key)) { // Belirtilen anahtarı içerip içermediğini kontrol et
        gridMap[i][key] = value; // Değerini tersine çevir
      }
    }
    notifyListeners();
  }
  checkCamera()async{
    await Permission.camera.request().then((value) => {
      status = value,
    });
    print("kamera durum :$status");
    notifyListeners();
  }

  setQuery(String value){
    query = value;
    notifyListeners();
  }

  setStockQuery(String value){
    stockQuery = value;
    notifyListeners();
  }

  deletePoolListItem(String serial){
    poolList.removeWhere((element) =>
    element.serialNumber == serial);
  }

  List<AllOrganisations> searchOrganisation(List<AllOrganisations> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<AllOrganisations> filteredList = list.where((resource) =>
    (resource.name != null && resource.name!.toLowerCase().contains(query.toLowerCase()))).toList();
    return filteredList;
  }
  List<PoolListDetails> searchProduct(List<PoolListDetails> list, String query) {
    if (query.isEmpty) {
      return list;
    }

    List<PoolListDetails> filteredList = list.where((resource) =>
        (resource.serialNumber != null && resource.serialNumber!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.distributorId != null && resource.distributorId!.toString().toLowerCase().contains(getOrgName(organisations!,query)!))||
        (resource.importerWarehouseName != null && resource.importerWarehouseName!.toLowerCase().contains(query.toLowerCase()))).toList();

  
    return filteredList;
  }

  List<DistStockList> searchStockList(List<DistStockList> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<DistStockList> filteredList = list.where((value) =>
    (value.serialNumber != null && value.serialNumber!.toString().toLowerCase().contains(query.toLowerCase())) ||
        (value.dealerName != null && value.dealerName!.toString().toLowerCase().contains(query.toLowerCase())) ||
        (value.warehouseName != null && value.warehouseName!.toString().toLowerCase().contains(query.toLowerCase())
        )).toList();
    return filteredList;
  }

  List<WarehouseList> searchWarehouse(List<WarehouseList> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<WarehouseList> filteredList = list.where((value) =>
    (value.warehouseName != null && value.warehouseName!.toString().toLowerCase().contains(query.toLowerCase())) ||
        (value.warehousePhone != null && value.warehousePhone!.toString().toLowerCase().contains(query.toLowerCase())) ||
        (value.warehouseAdress != null && value.warehouseAdress!.toString().toLowerCase().contains(query.toLowerCase())) ||
        (value.warehouseSpocname != null && value.warehouseSpocname!.toString().toLowerCase().contains(query.toLowerCase())
        )).toList();
    return filteredList;
  }

  List<AssignDealerList> searchAssign(List<AssignDealerList> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<AssignDealerList> filteredList = list.where((value) =>
     value.serialNumber!.toString().toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList;
  }

  List<StockDealer> searchDealer(List<StockDealer> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<StockDealer> filteredList = list.where((value) =>
    (value.name != null && value.name!.toString().toLowerCase().contains(query.toLowerCase())) ||
        (value.email != null && value.email!.toString().toLowerCase().contains(query.toLowerCase())) ||
        (value.phone != null && value.phone!.toString().toLowerCase().contains(query.toLowerCase()))
    ).toList();
    return filteredList;
  }

  List<AllAssignStock> searchAssignStock(List<AllAssignStock> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<AllAssignStock> filteredList = list.where((value) =>
    (value.serialNumber != null && value.serialNumber!.toString().toLowerCase().contains(query.toLowerCase())) ||
        (value.importerWarehouseName != null && value.importerWarehouseName!.toString().toLowerCase().contains(query.toLowerCase())) ||
        (value.productName != null && value.productName!.toString().toLowerCase().contains(query.toLowerCase()))
    ).toList();
    return filteredList;
  }

  List<AllOrganisations> searchDist(List<AllOrganisations> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<AllOrganisations> filteredList = list.where((value) =>
    (value.name != null && value.name!.toString().toLowerCase().contains(query.toLowerCase()))
    ).toList();
    return filteredList;
  }

  List<PoolStockProduct> searchScanProduct(List<PoolStockProduct> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<PoolStockProduct> filteredList = list.where((value) => value.productSerialNumber!.toString().toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList;
  }

  deleteItem(List<PoolStockProduct> details,int index){

    details.removeAt(index);
    notifyListeners();
  }
   checkBeforeScan(BuildContext context, QRViewController qrViewController) {

    qrViewController.scannedDataStream.listen((scanData) async {
      result = scanData;
      if(result!.code!.length !=8){
        snackBarDesign(context, StringUtil.error, "serialIdMust8".tr());
        return;
      }else{
        await getAllAssignList(context,result!.code);
        if(allAssignStock!.isNotEmpty){
          addPoolList(context,allAssignStock![0],result!.code!);
        }


      }
      qrViewController.resumeCamera();
      notifyListeners();
    });
  }
  void onQRViewCreated(BuildContext context, QRViewController qrViewController, int productId,int assign,String total) {
    final player = AudioPlayer();

    qrViewController.scannedDataStream.listen((scanData) async {
      result = scanData;
      if ((assign + poolStock.length) < int.parse(total)) {
        if (result!.code!.length == 8) {
          if (poolStock.isNotEmpty) {
            bool found = false;
            for (int i = 0; i < poolStock.length; i++) {
              if (poolStock[i].productSerialNumber! == result!.code) {
                found = true;
                break;
              }
            }
            if (!found) {
              var model = PoolStockProduct(
                productId: productId,
                stockDate: DateTime.now(),
                productSerialNumber: result!.code,
                distributorId: 0,
              );
              poolStock.add(model);
            } else {
              snackBarDesign(context, StringUtil.error, "canNotAddSameSerial".tr());
              return;
            }
          } else {
            var model = PoolStockProduct(
              productId: productId,
              stockDate: DateTime.now(),
              productSerialNumber: result!.code,
              distributorId: 0,
            );
            poolStock.add(model);
          }

          await Future.delayed(const Duration(seconds: 2)); // Delay before resuming camera

        } else {
          snackBarDesign(context, StringUtil.error, "serialIdMust8".tr());
          await player.play(AssetSource('error.mp3'));
          await Future.delayed(const Duration(seconds: 4));
          return;
        }
      } else {
        snackBarDesign(context, StringUtil.error, "cannotAddMoreProduct".tr());
        return;
      }
      qrViewController.resumeCamera();
      notifyListeners();
    });
  }

   checkProductControl(BuildContext context, QRViewController qrViewController, List<PoolListDetails> details) {
    final player = AudioPlayer();
    qrViewController.scannedDataStream.listen((scanData) async {

      result = scanData;
      bool found = false;

      if (distId == null) {
        snackBarDesign(context, StringUtil.error, "pleaseSelectDistributor".tr());
        await player.play(AssetSource('error.mp3'));
        return;
      } else {

        for (int i = 0; i < details.length; i++) {
          if (details[i].serialNumber == result!.code) {
            found = true;
            if (details[i].distributorId == 0) {
              details[i].distributorId = distId!;
              await player.play(AssetSource('scanner.mp3'));
              notifyListeners();
            }
            break;
          }
        }
        if (!found) {
          snackBarDesign(context, StringUtil.error, "serialNumberCannotFind".tr());
          await player.play(AssetSource('error.mp3'));
        }
      }
      await Future.delayed(const Duration(seconds: 4));
      qrViewController.resumeCamera();
    });
    notifyListeners();
  }

  Future<void>postProduct(BuildContext context,PoolProductSave save) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    showProgress(context, true);
    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.postPool(save).then((value) {
        postResponse = value;
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          String jsonString = json.encode(res!.data);
          showErrorMessage(context,jsonString);

        }
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }
  }

  Future<void>postDistributors(BuildContext context,List<PoolDistributor> poolDistributor) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    showProgress(context, true);
    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.detailsPost(poolDistributor).then((value) {
        detailsPostResponse = value;
        snackBarDesign(context, StringUtil.success, "successAdded".tr());
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        }
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }
  }

  Future<void>getOrganisations(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      organisations = await apiService.allOrganisations();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        }
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void>getWarehouse(BuildContext context,int? distId) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      warehouseList = await apiService.getWarehouses(distId);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      notifyListeners();

    }
  }

  Future<void>getAllAssignList(BuildContext context,String? serialNum) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    await showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      allAssignStock = await apiService.getAssignStock(serialNum);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      await showProgress(context, false);
      notifyListeners();

    }
  }

  Future<void>getStockProduct(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      stockProduct=  await apiService.getStockProduct();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        }
      }
    } finally {
      notifyListeners();
    }
  }
  Future<void>getStockList(BuildContext context,int poolId) async{
    String token = await pref.getString(context, SharedUtils.userToken);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    try {
      poolList =await apiService.getPoolList(poolId);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);

        }
      }
    } finally {
      notifyListeners();

    }

  }

  Future<void>poolHistory(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getPoolHistory().then((value) {
        getPoolHistory = value;
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);

        }
      }
    } finally {
      notifyListeners();

    }

  }

  Future<void>postStockPool(BuildContext context,StockPool pool) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    showProgress(context, true);
    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.postStockPool(pool).then((value) {
        response = value;
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);

        }
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }
  }
  //dealerlar için listeleme
  Future<void>getDealerList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      stockDealer = await apiService.getStockDealer();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      notifyListeners();
    }
  }

  //stoklar
  Future<void>getStock(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    user ??= await getUserUser(context);

    int? distId;
    if(user!.roleType !="SUPERADMIN"){
      distId= loginUser!.profiles![index].organisation_id;
    }

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      distStockList = await apiService.getStockList(distId);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void>postPay(BuildContext context,PostStockPay pay,int id) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postStockPay(pay).then((value) => {
        getStockList(context,id)
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
         snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }
  }

  Future<void>postPayAllAssign(BuildContext context,PostStockPay pay,int id,int index) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postStockPay(pay).then((value) => {
      setPaidWithIndex(searchProduct(poolList,query), index),

      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }
  }

  Future<void>postDistWarehouse(BuildContext context,PostDistInventoryWarehouse postDistInventoryWarehouse,Function() function) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postDistWarehouse(postDistInventoryWarehouse).then((value) => {
        Navigator.pop(context),
        snackBarDesign(context, StringUtil.success, "warehouseAdded".tr()),
        function()
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }
  }
  // dealer post
  postDealer(BuildContext context,PostStockDealer stockDealer) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postStockDealer(stockDealer).then((value) => {
        postStock =value,
        Navigator.pop(context),
        snackBarDesign(context, StringUtil.success, postStock!),
        getStock(context)
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          Navigator.pop(context);
          snackBarDesign(context, StringUtil.error, "You must be a distributor or sales manager.");

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }
  }
  //stock history
  Future<void>getStockHistory(BuildContext context,int id) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      stockHistory = await apiService.getStockHistory(id);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      notifyListeners();
    }
  }
  //delarlara atılan ürünler
  Future<void>getAssign(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      assignList = await apiService.getAssignList();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
           snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      notifyListeners();
    }
  }
  returnProduct(BuildContext context,ReturnStock stock) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.returnStock(stock).then((value) => {
        snackBarDesign(context, StringUtil.success, "returnToDist".tr()),
        getStock(context)
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data!);
          Navigator.pop(context);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
          // DioException değilse genel bir hata durumu
          print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }
  }

}