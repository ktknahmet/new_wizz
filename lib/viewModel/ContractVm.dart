import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wizzsales/adminPage/adminApiService/adminApiService.dart';
import 'package:wizzsales/adminPage/adminModel/contractModel/AdminContractList.dart';
import 'package:wizzsales/adminPage/adminModel/contractModel/AdminSignature.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/organisations/allOrganisations.dart';
import 'package:wizzsales/adminPage/adminService/adminModule.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/contractModel/contractType.dart';
import 'package:wizzsales/model/contractModel/distributorContract.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class ContractVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<AllOrganisations>? organisations;
  List<DistributorContract>? getContract;
  List<AdminContractList>? getAdminContract;
  List<AdminSignature>? getAdminSignature;
  List<ContractType>? contractType;
  HttpResponse? postContractDist;
  HttpResponse? postSignatureDist;
  HttpResponse? postAdminContract;
  LoginUser? loginUser;
  String? contractName;
  int? contractId;
  File? documentFile;
  File? signatureFile;
  String query="";
  String? selectedDist;

  setDist(String name){
    selectedDist = name;
    notifyListeners();
  }
  List<AdminContractList> expenseDetails(List<AdminContractList> list, String? type) {

    if (type == null || type.isEmpty) {
      return list;
    }
    List<AdminContractList> filteredList = list.where((resource) =>
        resource.distributorName!.toLowerCase().contains(type.toLowerCase())).toList();

    return filteredList;
  }

  setQuery(String value){
    query = value;
    notifyListeners();
  }
  setCheck(List<AllOrganisations> list,int index,bool v){
    list[index].check = v;
    notifyListeners();
  }

  List<DistributorContract> searchContract(List<DistributorContract> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<DistributorContract> filteredList = list.where((resource) => resource.contractName!.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }
  List<AdminSignature> searchAdminSignature(List<AdminSignature> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<AdminSignature> filteredList = list.where((resource) =>
    resource.distributorName!.toLowerCase().contains(query.toLowerCase()) ||
        resource.distributorName!.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }

  List<AllOrganisations> addContract(List<AllOrganisations> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<AllOrganisations> filteredList = list.where((resource) =>
        resource.name!.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }

  setContractName(String name,int id){
    contractName = name;
    contractId = id;
    notifyListeners();
  }
  //kontrakt tipleri dropdown button olacak seçip yükleyecek
  getDistContractType(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    int orgId = await pref.getInt(context, SharedUtils.orgId);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.distributorContractType(91).then((value) {
        contractType = value;
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
  //yüklenen kontraktları listeleyecek
  getDistContract(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    int orgId = await pref.getInt(context, SharedUtils.orgId);


    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getDistributorContract(91).then((value) {
        getContract = value;
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
  //distributor kontrakt yükleme
  postDistContract(BuildContext context,int contractId,File document) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    int orgId = await pref.getInt(context, SharedUtils.orgId);
    showProgress(context, true);

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.postDistContract(91,contractId,document).then((value) {
        postContractDist = value;
        snackBarDesign(context, StringUtil.success, "uploadedPdf".tr());
        Navigator.pop(context);
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
      await showProgress(context, false);
      notifyListeners();
    }
  }
  //distributor belgeleri imzası
  postDistSignature(BuildContext context,File document) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    int orgId = await pref.getInt(context, SharedUtils.orgId);
    showProgress(context, true);

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.postDistSignature(91,document).then((value) {
        postSignatureDist = value;
        snackBarDesign(context, StringUtil.success, "uploadedSignature".tr());
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;

        if (res?.statusCode == 400) {
          //String jsonString = json.encode(res!.data);
          //showErrorMessage(context,jsonString);
          snackBarDesign(context, StringUtil.error, res!.data!);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        print("General error: $error");
      }
    } finally {
      await showProgress(context, false);
      notifyListeners();
    }
  }

  //admin tarafı
  //admin kontrakt listeleme
  getAdminContractList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.getAdminContract().then((value) {
        getAdminContract = value;
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
  //admin contract distributor listeleme
  getAdminSignatureList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    int orgId = await pref.getInt(context, SharedUtils.orgId);
    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.distributorSignature(91).then((value) {
        getAdminSignature = value;
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
  postAdminContracts(BuildContext context,String name,List<String> distId,File document) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    showProgress(context, true);

    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.postAdminContract(name,distId,document).then((value) {
        postAdminContract = value;
        Navigator.pop(context);
        snackBarDesign(context, StringUtil.success, "uploadedDocument".tr());
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
      await showProgress(context, false);
      notifyListeners();
    }
  }
  Future<void>getOrganisations(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);

    showProgress(context, true);
    AdminApiService apiService = AdminApiService(AdminModule().baseService(token));
    notifyListeners();
    try {
      await apiService.allOrganisations().then((value) {
        organisations = value;
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          showErrorMessage(context,"Error");
        }
      }
    } finally {
      showProgress(context, false);
      notifyListeners();

    }

  }

}