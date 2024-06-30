import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/dio.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/model/saleDocument/getSaleDocument.dart';
import 'package:wizzsales/model/saleDocument/saleDocument.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../widgets/Constant.dart';
// ignore_for_file: use_build_context_synchronously

class SaleDocumentVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<SaleDocument>? saleDocument;
  List<GetSaleDocument>? allSaleDocument;
  HttpResponse? response;
  File? selectImage;

  setImage(File value){
    selectImage = value;
  }
  deleteImage(){
    selectImage =null;
  }

  saleDocTypes(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      saleDocument = await apiService.getSaleDocumentTypes();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          String jsonString = json.encode(res!.data);
          showErrorMessage(context,jsonString);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        print("General error: $error");
      }
    } finally {
      notifyListeners();

    }
  }
  allSaleDoc(BuildContext context,int id) async{
    String token = await pref.getString(context, SharedUtils.userToken);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      allSaleDocument=  await apiService.getSaleDocument(id);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          String jsonString = json.encode(res!.data);
          showErrorMessage(context,jsonString);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        print("General error: $error");
      }
    } finally {
      notifyListeners();

    }
  }
  postSaleDocument(BuildContext context,int typeId,int saleId,int userId,String note,File photo) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    int orgId = await pref.getInt(context, SharedUtils.orgId);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    showProgress(context, true);
    notifyListeners();
    try {
      await apiService.postSaleDoc(typeId, saleId, userId, note, photo, orgId).then((value) {
        response = value;
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          String jsonString = json.encode(res!.data);
          showErrorMessage(context,jsonString);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();

    }
  }
}