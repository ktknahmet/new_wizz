import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:retrofit/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminModel/carousel/SliderPayload.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously
class AdminCarouselVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<SliderPayload>? getSlider;
  HttpResponse? response;
  File? selectImage;
  File? uploadDocument;
  String fileType="";
  bool? deleteResponse;
  String query="";
  bool addedPhoto = false;
  String? type;
  String? sliderType;


  setType(String value){
    type = value;
    notifyListeners();
  }
  setSliderType(String slider){
    sliderType = slider;
    notifyListeners();
  }
  setAddedPhoto(bool type){
    addedPhoto = type;

    notifyListeners();
  }
  setQuery(String value){
    query = value;
    notifyListeners();
  }
  List<SliderPayload> searchSlider(List<SliderPayload> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<SliderPayload> filteredList =
    list.where((slider) => slider.sliderViewName!.toLowerCase().contains(query.toLowerCase()) ||
        slider.sliderType!.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }

  setImage(File value){
    selectImage = value;
  }
  setFileType(String type){
    fileType = type;
    notifyListeners();
  }

  deleteImage(){
    selectImage =null;
  }
  deleteDocument(){
    uploadDocument =null;
  }

  allSlider(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getAllSlider().then((value) {
        getSlider = value;
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
      notifyListeners();

    }
  }

  deleteSlider(BuildContext context,int id) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    showProgress(context, true);
    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.deleteSlider(id).then((value) {
        deleteResponse = value;
        snackBarDesign(context, StringUtil.success, "deletedCarousel".tr());
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
  postSlider(BuildContext context,String sliderName,int order,String click,dynamic onClickFile,String type,File file,) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    showProgress(context, true);
    notifyListeners();
    try {
      await apiService.postSlider(sliderName, order, click,onClickFile, type, file,).then((value) {
        response = value;
        snackBarDesign(context, StringUtil.success, "addedCarousel".tr());
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
  postSliderLink(BuildContext context,String sliderName,int order,String click,String type,File file,) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    showProgress(context, true);
    notifyListeners();
    try {
      await apiService.postSliderLink(sliderName, order, click, type, file,).then((value) {
        response = value;
        snackBarDesign(context, StringUtil.success, "addedCarousel".tr());
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