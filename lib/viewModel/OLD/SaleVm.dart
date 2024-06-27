import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wizzsales/constants/ApiEndpoints.dart';
import 'package:wizzsales/model/OLD/MyOfficeSales.dart';
import 'package:wizzsales/model/OLD/Sale.dart';
import 'package:wizzsales/model/OLD/SalePagination.dart';
import 'package:wizzsales/model/OLD/contestModel/Active.dart';
import 'package:wizzsales/model/OLD/contestReportModel/CompetitionsReports.dart';
import 'package:wizzsales/model/OLD/leads.dart';
import 'package:wizzsales/model/OLD/myContestModel/myCont.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:http/http.dart' as http;
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../model/OLD/Draw.dart';
class SaleVM {
  static Sale addSaleModel = Sale();
  static Leads addLeadsModel = Leads();

  static Future<String> getAllLeads(BuildContext context) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    String list = "";
    try {
      final response = await http.get(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.allleadlist),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "Accept": "application/json",
          });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          var json = response.body.toString();
          list = json;
        }
      } else if (response.statusCode == 401) {
        deleteToken(context);
        return "";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
    return list;
  }

  static Future<String> getQuestions(BuildContext context, int lead) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    String list = "";
    try {
      final response = await http.get(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.questions),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "leadid": lead.toString(),
            "Accept": "application/json",
          });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          var json = response.body.toString();
          list = json;
        }
      } else if (response.statusCode == 401) {
        await deleteToken(context);
        return "";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
    return list;
  }

  static Future<dynamic> postLead(BuildContext context, String list) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);

    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    print("id role :$salesRoleId -- $activeProfile");
    try {
      await showProgress(context, true);
      final response = await http.post(

        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.lead),
        headers: <String, String>{
          'Authorization': "Bearer $token",
          "profile": activeProfile,
          "salesroleid": salesRoleId,
          'Accept': "application/json charset=utf-8",
          'Content-Type': "application/json"
        },
        body: list,
      );
      await showProgress(context, false);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        var data = response.body.toString();


        print("response lead :$data");

        snackBarDesign(context, StringUtil.success, "Successfuly added lead");
        Navigator.pushNamedAndRemoveUntil(context, '/${PageName.mainHome}', (Route<dynamic> route) => false,);
      } else if (response.statusCode == 401) {
        await deleteToken(context);

        return "Error";
      } else if (response.statusCode == 400) {

        snackBarDesign(context, StringUtil.error,
            "${response.reasonPhrase!} ${response.body}");


        print("gelen hata ${response.reasonPhrase}  ${response.body}");
      } else {

        snackBarDesign(context, StringUtil.error, response.reasonPhrase!);
      }
    } catch (e) {
      snackBarDesign(context, StringUtil.error, e.toString());
    }
  }

  static Future<SalePagination?> getSaleList(BuildContext context, int status,
      int page) async {

    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    try {
      final response = await http.get(Uri.parse(
          "https://hylana.wizz.app/api/v16/allsales/v2?salestatus=$status&page=$page"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "Accept": "application/json",
          });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          var json = jsonDecode(response.body.toString());
          SalePagination salePagination = SalePagination.fromJson(json);

          return salePagination;
        }
      } else if (response.statusCode == 401) {

        deleteToken(context);
      } else if (response.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(response.reasonPhrase!.substring(9));
        List<String> errorMessages = [];
        responseData.forEach((key, value) {
          if (value is List<dynamic>) {
            for (var error in value) {
              errorMessages.add(error);
            }
          }
        });
        for (var errorMessage in errorMessages) {
          snackBarDesign(context, StringUtil.error, errorMessage);
        }
      } else {
        return null;
      }
    } catch (e) {
      // ViewUtil.closeProgress(ViewUtil.bottombarContext!);
      return null;
    }

    return null;
  }

  static Future<SalePagination?> getMySaleList(BuildContext context,
      String orgId, int status, int page) async {


    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    try {
      final response = await http.get(Uri.parse(
          "https://hylana.wizz.app/api/v16/user/organisation/$orgId/sales/v2?salestatus=$status&page=$page"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "Accept": "application/json",
          });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          var json = jsonDecode(response.body.toString());
          SalePagination salePagination = SalePagination.fromJson(json);

          return salePagination;
        }
      } else if (response.statusCode == 401) {
        deleteToken(context);
      } else if (response.statusCode == 400) {
        snackBarDesign(context, StringUtil.error, response.reasonPhrase!);
      } else {
        return null;
      }
    } catch (e) {
      // ViewUtil.closeProgress(ViewUtil.bottombarContext!);
      return null;
    }
    return null;
  }


  Future<String> updateSaleStatus(BuildContext context, int? id,
      String? serialId, String? status) async {
    await showProgress(context, true);
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    var request = http.MultipartRequest("POST",
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.salesChangeStatus));

    request.headers['Authorization'] = "Bearer $token";
    request.headers["profile"] = activeProfile;
    request.headers["salesroleid"] = salesRoleId;
    request.headers['Accept'] = "application/json";
    request.fields['id'] = id.toString();
    request.fields['serialid'] = serialId!;
    request.fields['status'] = status!;

    String code = "";
    try {
      await request.send().then((result) async {
        await http.Response.fromStream(result).then((response) {
          print("response :${response.statusCode} -- ${response.body} -- ${response.reasonPhrase!}");
          if (response.statusCode == 200 || response.statusCode == 201 ||
              response.statusCode == 302) {
            if (response.body.isNotEmpty) {
              var json = response.body.toString();
              code = json;

              snackBarDesign(context, StringUtil.success, "statusUpdate".tr());
            }
          } else if (response.statusCode == 403) {
            snackBarDesign(context, StringUtil.error, "duplicateSaleStatus".tr());

            return "error";
          }else if(response.statusCode==401){
            snackBarDesign(context, StringUtil.error, response.body);
          }
          return "error";
        });
      });
    } catch (e) {
      snackBarDesign(context, StringUtil.error, e.toString());
    }
    await showProgress(context, false);

    return code;
  }

  static Future<List<MyOfficeSales>?> getOfficeSalesList(BuildContext context,
      int organisationId) async {

    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    try {
      final response = await http.get(
          Uri.parse("${ApiEndpoints.baseUrl}${ApiEndpoints
              .officeSales}/$organisationId"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "profile": activeProfile,
            "salesroleid": salesRoleId
          });
      if (response.statusCode == 200 || response.statusCode == 201 ||
          response.statusCode == 302) {
        var json = jsonDecode(response.body.toString());
        var tagObjsJson = json as List;
        List<MyOfficeSales> dataList = [];
        List<MyOfficeSales> officeSalesList = tagObjsJson
            .map((tagJson) => MyOfficeSales.fromJson(tagJson))
            .toList();
        dataList = officeSalesList;

        return dataList;
      } else {

        snackBarDesign(context, StringUtil.success, response.reasonPhrase!);
      }
    } catch (e) {

      snackBarDesign(context, StringUtil.success, e.toString());
    }

    return null;
  }

  static Future<List<MyOfficeSales>?> getMySalesList(BuildContext context,
      int userId, int organisationId) async {

    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    try {
      Map data = {
        'userid': userId,
        'organisationid': organisationId,
      };
      //encode Map to JSON
      var body = json.encode(data);
      final response = await http.post(
          Uri.parse("${ApiEndpoints.baseUrl}${ApiEndpoints.mySales}"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "profile": activeProfile,
            "salesroleid": salesRoleId
          },
          body: body
      );

      if (response.statusCode == 200 || response.statusCode == 201 ||
          response.statusCode == 302) {
        var json = jsonDecode(response.body.toString());
        var tagObjsJson = json as List;
        List<MyOfficeSales> dataList = [];
        List<MyOfficeSales> officeSalesList = tagObjsJson
            .map((tagJson) => MyOfficeSales.fromJson(tagJson))
            .toList();
        dataList = officeSalesList;
        return dataList;
      } else {
        snackBarDesign(context, StringUtil.success, response.reasonPhrase!);
      }
    } catch (e) {
      snackBarDesign(context, StringUtil.success, e.toString());
    }
    return null;
  }

  static Future<List<Draw>> getLeads(BuildContext context) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    try {
      final response = await http.get(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.leadlist),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "Accept": "application/json",
          });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          var json = jsonDecode(response.body.toString()) as List;
          List<Draw> dataList =
          json.map((tagJson) => Draw.fromJson(tagJson)).toList();


          return dataList;
        }
      } else if (response.statusCode == 401) {
        deleteToken(context);
        return [];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
    return [];
  }
  static Future<int> qualifySale(BuildContext context, Sale sale,
      File? imageFile, String drawCode) async {
    int returnval=0;
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
     showProgress(context, true);
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("https://hylana.wizz.app/api/v16/v2/sales"),
      );

      if (imageFile != null) {
        var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile('salepicture', stream, length,
            filename: basename(imageFile.path));
        request.files.add(multipartFile);
      }

      request.headers['Authorization'] =
      "Bearer $token";
      request.headers['profile'] = activeProfile;
      request.headers['salesroleid'] = salesRoleId;
      request.headers['Accept'] = "application/json";


      request.fields['serialid'] = sale.serialid!;
      request.fields['date'] = sale.date ?? "";
      request.fields['cfirstname'] = sale.cfirstname ?? "";
      request.fields['clastname'] = sale.clastname ?? "";
      request.fields['cphone'] = sale.cphone ?? "";
      request.fields['cemail'] = sale.cemail ?? "";

      request.fields['sfirstname'] = sale.sfirstname ?? "";
      request.fields['slastname'] = sale.slastname ?? "";
      request.fields['sphone'] = sale.sphone ?? "";
      request.fields['semail'] = sale.semail ?? "";

      request.fields['caddress'] = sale.caddress ?? "";
      request.fields['note'] = sale.note ?? "";
      request.fields['ccounty'] = sale.ccounty ?? "";
      request.fields['ccountry'] = sale.ccountry ?? "";
      request.fields['office'] = sale.office ?? "";
      request.fields['cstate'] = sale.cstate ?? "";
      request.fields['ccity'] = sale.ccity ?? "";
      request.fields['czipcode'] = sale.czipcode ?? "";
      request.fields['drawCode'] = drawCode;
      request.fields['dealer'] = sale.dealer != null && sale.dealer!.id != null
          ? sale.dealer!.id.toString()
          : "";
      request.fields['da'] =
      sale.da != null && sale.da!.id != null ? sale.da!.id.toString() : "";
      request.fields['dps'] =
      sale.dps != null && sale.dps!.id != null ? sale.dps!.id.toString() : "";
      request.fields['finance'] =
      sale.finance != null ? sale.finance.toString() : "";
      request.fields['leadtype'] =
      sale.leadtype != null ? sale.leadtype.toString() : "";
      request.fields['leader'] = sale.leader != null && sale.leader!.id != null
          ? sale.leader!.id.toString()
          : "";
      request.fields['sm'] =
      sale.sm != null && sale.sm!.id != null ? sale.sm!.id.toString() : "";
      request.fields['price'] = sale.price!;
      request.fields['down_type'] =
      sale.downType != null ? sale.downType.toString() : "";
      request.fields['down'] = sale.down ?? "";
      request.fields['fee1'] = sale.fee1 ?? "";
      request.fields['fee2'] = sale.fee2 ?? "";
      request.fields['financeby'] =
      sale.financeby != null ? sale.financeby.toString() : "";
      request.fields['reserve'] =
      sale.reserve != null ? sale.reserve.toString() : "";
      request.fields['other_deductions'] =
      sale.otherDeductions != null ? sale.otherDeductions.toString() : "";
      request.fields['netprice'] =
      sale.netprice != null ? sale.netprice.toString() : "";
      request.fields['comision'] = sale.comision ?? "";
      request.fields['tax'] = sale.tax ?? "";
      request.fields['financepercentage'] = sale.financepercentage ?? "";
      request.fields['longitude'] = "";
      request.fields['latitude'] = "";
      await request.send().then((result) async {
        await http.Response.fromStream(result).then((response) {
           showProgress(context, false);
          try {
            print("kayıt yapıldı ${response.statusCode} -- ${response.body}");
            if (response.statusCode == 200 ||
                response.statusCode == 201 ||
                response.statusCode == 302) {
              if (response.body.isNotEmpty) {

                String lastPart="";
                if(response.body.contains("{")){
                  List<String> parts = response.body.split('}'); // JSON nesnelerini ayır
                  lastPart = parts.last.trim();
                }else{
                  lastPart = response.body;
                }
                // Map<String, dynamic> data = json.decode(lastPart);
                // İstediğiniz değeri al
                int returnValue = int.tryParse(lastPart)!;
                returnval = returnValue;
                return returnval;
              } else {
                returnval = 0;
              }
            } else if (response.statusCode == 401) {
              deleteToken(context);
            } else if (response.statusCode == 400) {
              snackBarDesign(context, StringUtil.error,
                  "${response.reasonPhrase!} ${response.body}");

              returnval = 0;
            }
          } catch (e) {
            snackBarDesign(context, StringUtil.error, e.toString());
            returnval = 0;
          }
        });
      });
    } catch (e) {
      returnval = 0;
    }

    return returnval;
  }
  static Future<int> demoSale(BuildContext context, Sale sale,
      File? imageFile, String drawCode) async {
    int returnval=0;
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
     showProgress(context, true);
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("https://hylana.wizz.app/api/v16/v2/sales"),
      );

      if (imageFile != null) {
        var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile('salepicture', stream, length,
            filename: basename(imageFile.path));
        request.files.add(multipartFile);
      }

      request.headers['Authorization'] =
      "Bearer $token";
      request.headers['profile'] = activeProfile;
      request.headers['salesroleid'] = salesRoleId;
      request.headers['Accept'] = "application/json";


      request.fields['serialid'] = sale.serialid!;
      request.fields['date'] = sale.date ?? "";
      request.fields['cfirstname'] = sale.cfirstname ?? "";
      request.fields['clastname'] = sale.clastname ?? "";
      request.fields['cphone'] = sale.cphone ?? "";
      request.fields['cemail'] = sale.cemail ?? "";

      request.fields['sfirstname'] = sale.sfirstname ?? "";
      request.fields['slastname'] = sale.slastname ?? "";
      request.fields['sphone'] = sale.sphone ?? "";
      request.fields['semail'] = sale.semail ?? "";

      request.fields['caddress'] = sale.caddress ?? "";
      request.fields['note'] = sale.note ?? "";
      request.fields['ccounty'] = sale.ccounty ?? "";
      request.fields['ccountry'] = sale.ccountry ?? "";
      request.fields['office'] = sale.office ?? "";
      request.fields['cstate'] = sale.cstate ?? "";
      request.fields['ccity'] = sale.ccity ?? "";
      request.fields['czipcode'] = sale.czipcode ?? "";
      request.fields['drawCode'] = drawCode;
      request.fields['dealer'] = sale.dealer != null && sale.dealer!.id != null
          ? sale.dealer!.id.toString()
          : "";
      request.fields['da'] =
      sale.da != null && sale.da!.id != null ? sale.da!.id.toString() : "";
      request.fields['dps'] =
      sale.dps != null && sale.dps!.id != null ? sale.dps!.id.toString() : "";
      request.fields['finance'] =
      sale.finance != null ? sale.finance.toString() : "";
      request.fields['leadtype'] =
      sale.leadtype != null ? sale.leadtype.toString() : "";
      request.fields['leader'] = sale.leader != null && sale.leader!.id != null
          ? sale.leader!.id.toString()
          : "";
      request.fields['sm'] =
      sale.sm != null && sale.sm!.id != null ? sale.sm!.id.toString() : "";
      request.fields['price'] = sale.price!;
      request.fields['down_type'] =
      sale.downType != null ? sale.downType.toString() : "";
      request.fields['down'] = sale.down ?? "";
      request.fields['fee1'] = sale.fee1 ?? "";
      request.fields['fee2'] = sale.fee2 ?? "";
      request.fields['financeby'] =
      sale.financeby != null ? sale.financeby.toString() : "";
      request.fields['reserve'] =
      sale.reserve != null ? sale.reserve.toString() : "";
      request.fields['other_deductions'] =
      sale.otherDeductions != null ? sale.otherDeductions.toString() : "";
      request.fields['netprice'] =
      sale.netprice != null ? sale.netprice.toString() : "";
      request.fields['comision'] = sale.comision ?? "";
      request.fields['tax'] = sale.tax ?? "";
      request.fields['financepercentage'] = sale.financepercentage ?? "";
      request.fields['longitude'] = "";
      request.fields['latitude'] = "";

      await request.send().then((result) async {
        showProgress(context, false);
        await http.Response.fromStream(result).then((response) {
          try {
            print("kayıt yapıldı demo ${response.statusCode} -- ${response.body}");
            if (response.statusCode == 200 ||
                response.statusCode == 201 ||
                response.statusCode == 302) {
              if (response.body.isNotEmpty) {

                String lastPart="";
                if(response.body.contains("{")){
                  List<String> parts = response.body.split('}'); // JSON nesnelerini ayır
                  lastPart = parts.last.trim();
                }else{
                  lastPart = response.body;
                }
               // Map<String, dynamic> data = json.decode(lastPart);
                // İstediğiniz değeri al
                int returnValue = int.tryParse(lastPart)!;
                returnval = returnValue;
                return returnval;
              } else {
                returnval = 0;
              }
            } else if (response.statusCode == 401) {
              deleteToken(context);
            } else if (response.statusCode == 400) {
              snackBarDesign(context, StringUtil.error,
                  "${response.reasonPhrase!} ${response.body}");

              returnval = 0;
            }
          } catch (e) {
            snackBarDesign(context, StringUtil.error, e.toString());
            returnval = 0;
          }
        });
      });
    } catch (e) {
      returnval = 0;
    }

    return returnval;
  }

  static Future<List<Active>> getAllContests(BuildContext context) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    try {
      final response = await http.get(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.competitions),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "Accept": "application/json",
          });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          var tagObjsJson = jsonDecode(response.body.toString()) as List;
          List<Active> dataList =
          tagObjsJson.map((tagJson) => Active.fromJson(tagJson)).toList();



          return dataList;
        } else {

          return [];
        }
      } else if (response.statusCode == 401) {
        deleteToken(context);
        return [];
      } else {

        return [];
      }
    } catch (e) {

      return [];
    }
  }
  static Future<List<CompetitionsReports>> getCompetitionsResult(BuildContext context, int id) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    await showProgress(context, true);
    List<CompetitionsReports> list = [];
    try {
      final response = await http.get(
          Uri.parse("${ApiEndpoints.baseUrl}${ApiEndpoints.competitions}$id/reports"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "Accept": "application/json",
          });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          var tagObjsJson = jsonDecode(response.body.toString()) as List;
          List<CompetitionsReports> dataList = tagObjsJson
              .map((tagJson) => CompetitionsReports.fromJson(tagJson))
              .toList();
          list = dataList;
          await showProgress(context, false);
          return list;
        } else {
          await showProgress(context, false);
          list = list;
        }
      } else if (response.statusCode == 401) {
        deleteToken(context);
        return list;
      } else {
        await showProgress(context, false);
        list = list;
      }
    } catch (e) {
      return list;
    }
    await showProgress(context, false);
    return list;
  }

  static Future<MyCont> getDashBoard(BuildContext context) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(
        context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    String filename = "DashboardData.json";
    var cacheDir = await getTemporaryDirectory();
    try {
      final response = await http.get(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.dashboard),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "Accept": "application/json",
          });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          File file = File("${cacheDir.path}/$filename");
          file.writeAsString(response.body, flush: true, mode: FileMode.write);
          var tagObjsJson = jsonDecode(response.body.toString());
          MyCont data = MyCont.fromJson(tagObjsJson);

          return data;
        } else {
          MyCont result = await getDataFromJson(filename, cacheDir);
          return result;
        }
      } else if (response.statusCode == 401) {
        deleteToken(context);
        return MyCont();
      } else {
        MyCont result = await getDataFromJson(filename, cacheDir);
        await showProgress(context, false);
        return result;
      }
    } catch (e) {
      MyCont result = await getDataFromJson(filename, cacheDir);

      return result;
    }
  }

  static Future<dynamic> getDataFromJson(filename, cacheDir) async {
    if (await File(cacheDir.path + "/" + filename).exists()) {
      var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();
      var tagObjsJson = jsonDecode(jsonData.toString());
      var response = MyCont.fromJson(tagObjsJson);
      return response;
    } else {
      return null;
    }
  }
}