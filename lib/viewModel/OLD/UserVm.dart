import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wizzsales/constants/ApiEndpoints.dart';
import 'package:wizzsales/model/OLD/CareerSales.dart';
import 'package:wizzsales/model/OLD/CodeDraw.dart';
import 'package:wizzsales/model/OLD/Distributor.dart';
import 'package:wizzsales/model/OLD/Draw.dart';
import 'package:wizzsales/model/OLD/Notifications.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/OLD/leadReport/LeadReport.dart';
import 'package:wizzsales/model/OLD/register/Code.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/OLD/register/RegisterUser.dart';
import 'package:wizzsales/model/contactReferral/getReferral.dart';
import 'package:wizzsales/utils/OLD/LocalStorageApp.dart';
import "package:http/http.dart" as http;
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously
class UserVM {
  static Future<RegisterUser> register(
      BuildContext context,
      User user,
      String password,
      String cPassword,
      String roles,
      String distributor,
      File? imageFile) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.register),
    );

    if (imageFile != null) {
      var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('avatar', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
    }

    request.fields['firstname'] = user.firstname ?? "";
    request.fields['lastname'] = user.lastname ?? "";
    request.fields['birthday'] = user.birthday ?? "";
    request.fields['email'] = user.email ?? "";
    request.fields['password'] = password;
    request.fields['c_password'] = cPassword;
    request.fields['code'] = distributor;
    request.fields['sgoal'] = user.sgoal ?? "";
    request.fields['goal'] = user.goal ?? "";
    request.fields['address'] = user.address ?? "";
    request.fields['city'] = user.city ?? "";
    request.fields['state'] = user.state ?? "";
    request.fields['zipcode'] = user.zipcode ?? "";
    request.fields['phone'] = user.phone ?? "";
    request.fields['role'] = roles;
    request.fields['country'] = user.country ?? "";
    request.fields['county'] = user.county ?? "";

    LoginUser? registeredUser;
    Code? errorCode;

    await request.send().then((result) async {

      await http.Response.fromStream(result).then((response) async {
        await showProgress(context, true);
        try {
          await showProgress(context, false);
          print("kayıt oluyor :${response.statusCode} -- ${response.body}");
          if (response.statusCode == 200 ||
              response.statusCode == 201 ||
              response.statusCode == 302) {
            if (response.body.isNotEmpty) {
              var json = jsonDecode(response.body.toString());
              LoginUser loginUser = LoginUser.fromJson(json);
              loginUser.password = password;
              await UserVM.getUserDetail(context);

              SharedPref pref = SharedPref();
              await pref.setString(SharedUtils.userModel, jsonEncode(loginUser.toJson()));
              registeredUser = loginUser;
            } else {
              return null;
            }
          } else if (response.statusCode == 400) {
            var tagObjsJson = jsonDecode(response.body);
            snackBarDesign(context, StringUtil.error, tagObjsJson.toString());
            Code hata = Code.fromJson(tagObjsJson);
            errorCode = hata;
          } else {

          }
        } catch (e) {

        }
      });
    });
    await showProgress(context, false);
    return RegisterUser(loginUser: registeredUser, code: errorCode);
  }
  static Future<User> getUserDetail(BuildContext context) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    await showProgress(context, true);
    User user = User();
    String filename = "UserDetailData.json";
    var cacheDir = await getTemporaryDirectory();
    try {
      final response = await http.get(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.userdetails),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId
          });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          File file = File("${cacheDir.path}/$filename");
          file.writeAsString(response.body, flush: true, mode: FileMode.write);

          var json = jsonDecode(response.body.toString());

          User user = User.fromJson(json);
         await pref.setString(SharedUtils.user, jsonEncode(user.toJson()));
         print("kayıt edildi :${jsonEncode(user.toJson())}");
          LocalStorageApp.officeSalesTitle =
              json['officeSalesTitle'].toString();
          LocalStorageApp.officeSalesView = json['office_sales'].toString();
          LocalStorageApp.saleFotoMessage = json['saleFotoMessage'].toString();
          LocalStorageApp.profileFotoMessage =
              json['profileFotoMessage'].toString();
          var tagObjsJson = json['tshirtsizes'] as List;
          LocalStorageApp.sizeList =
              tagObjsJson.map((tagJson) => AllSizes.fromJson(tagJson)).toList();
          LocalStorageApp.newsTitle = json['newsTitle'].toString();

          LocalStorageApp.myDocuments = json['myDocuments'];

          LocalStorageApp.drawView = json['drawView'];
          LocalStorageApp.drawTitle1 = json['drawTitle1'].toString();
          LocalStorageApp.drawTitle2 = json['drawTitle2'].toString();
          LocalStorageApp.drawTitle3 = json['drawTitle3'].toString();
          LocalStorageApp.drawTitle4 = json['drawTitle4'].toString();

          LocalStorageApp.leadView = json['leadView'];
          //LocalStorageApp.leadView = 1;
          LocalStorageApp.leadTitle1 = json['leadTitle1'].toString();
          LocalStorageApp.leadTitle2 = json['leadTitle2'].toString();
          LocalStorageApp.leadTitle3 = json['leadTitle3'].toString();
          LocalStorageApp.leadTitle4 = json['leadTitle4'].toString();
          LocalStorageApp.leadTitle5 = json['leadTitle5'].toString();

          LocalStorageApp.saveString(LocalStorageApp.userKey, jsonEncode(user.toJson()).toString());
          LocalStorageApp.user = user;
          user = user;
          String? type;
          print("user type :$type");

          await pref.setString(SharedUtils.admin, user.roleType!);

          if(user.roleType=="SUPERADMIN" || user.roleType=="ADMIN"){
            type= "admin";
          }else{
            type = "main";
          }

          await pref.setString(SharedUtils.admin,type);
          if(type=="admin"){
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/${PageName.adminHome}',
                  (Route<dynamic> route) => false,
            );
          }else{
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/${PageName.mainHome}',
                  (Route<dynamic> route) => false,
            );
          }


          return user;
        } else {
          user = await getDataFromJson(filename, cacheDir);
          return user;
        }
      } else {
        user = await getDataFromJson(filename, cacheDir);
        return user;
      }
    } catch (e) {
      user = await getDataFromJson(filename, cacheDir);
      await showProgress(context, false);
      return user;
    }
  }
  static Future<dynamic> getDataFromJson(filename, cacheDir) async {
    User user = User();
    if (await File(cacheDir.path + "/" + filename).exists()) {
      var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();

      var json = jsonDecode(jsonData.toString());
      user = User.fromJson(json);
      LocalStorageApp.saleFotoMessage = json['saleFotoMessage'].toString();
      LocalStorageApp.profileFotoMessage =
          json['profileFotoMessage'].toString();
      LocalStorageApp.newsTitle = json['newsTitle'].toString();
      LocalStorageApp.saveString(
          LocalStorageApp.userKey, jsonEncode(user.toJson()).toString());
      LocalStorageApp.user = user;

    }
    return user;
  }
  static Future<List<Notifications>> getNotifications(BuildContext context) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    List<Notifications> dataList = [];

    try {
      final response = await http.get(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.notifications),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId
          });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          var json = jsonDecode(response.body.toString());
          var tagObjsJson = json as List;
          List<Notifications> dataList = [];
          List<Notifications> notificationsList = tagObjsJson
              .map((tagJson) => Notifications.fromJson(tagJson))
              .toList();
          dataList = notificationsList;

          return dataList;
        } else {
          dataList = [];

          return dataList;
        }
      } else {
        dataList = [];

        return dataList;
      }
    } catch (e) {
      dataList = [];

      return dataList;
    }

  }
  static Future<String> getResourcesNew(BuildContext context) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    try {
      final response = await http.get(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.resources),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId
          });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {
          var json = response.body.toString();
          print("dönen veri :$json");
          return json;
        } else {
          // dataList = [];
        }
      } else {
        // dataList = [];
      }
    } catch (e) {
      // dataList = [];
    }
    return 'error';
  }
  static Future<String> postDraw(BuildContext context, Draw draw) async {
    bool returnval = false;
    String code="";
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    await  showProgress(context, true);
    try {

      var request = http.MultipartRequest(
        "POST",
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.draw),
      );

      request.headers['Authorization'] = "Bearer $token";
      request.headers['profile'] = activeProfile;
      request.headers['salesroleid'] = salesRoleId;
      request.headers['Accept'] = "application/json";

      //request.fields['code'] = draw.code;
      request.fields['date'] = draw.date!;
      request.fields['cfirstname'] = draw.cfirstname!;
      request.fields['clastname'] = draw.clastname!;
      request.fields['cphone'] = draw.cphone!;
      request.fields['cemail'] = draw.cemail!;
      request.fields['sfirstname'] = draw.sfirstname!;
      request.fields['slastname'] = draw.slastname!;
      request.fields['sphone'] = draw.sphone!;
      request.fields['semail'] = draw.semail!;
      request.fields['caddress'] = draw.caddress!;
      request.fields['ccounty'] = draw.ccounty ?? "";
      request.fields['ccountry'] = draw.ccountry ?? "";
      request.fields['cstate'] = draw.cstate!;
      request.fields['ccity'] = draw.ccity!;
      request.fields['czipcode'] = draw.czipcode!;
      await request.send().then((result) async {
        await http.Response.fromStream(result).then((response) {
          try {

            if (response.statusCode == 200 ||
                response.statusCode == 201 ||
                response.statusCode == 302) {
              if (response.body.isNotEmpty) {
                draw.code = response.body.toString().replaceAll("\"", "");
                code = draw.code!;
                print("draw code :${draw.code}");
                print("draws response:$draw -- ${response.body}");
                LocalStorageApp.drawList.add(draw);

                snackBarDesign(context, StringUtil.success, "Draw add successful");
                returnval = true;
                return returnval;
              } else {
                code ="error";
                returnval = false;
              }
            } else if (response.statusCode == 401) {
                 deleteToken(context);
            } else if (response.statusCode == 400) {
              var tagObjsJson = jsonDecode(response.body);
              Codedraw hata = Codedraw.fromJson(tagObjsJson);
              if (hata.cphone!.isNotEmpty) {
                snackBarDesign(context, StringUtil.error,hata.cphone![0]);

              } else if (hata.date!.isNotEmpty) {
                snackBarDesign(context, StringUtil.error,hata.date![0]);
              } else if (hata.cname!.isNotEmpty) {
                snackBarDesign(context, StringUtil.error,hata.cname![0]);
              } else if (hata.cfirstname!.isNotEmpty) {
                snackBarDesign(context, StringUtil.error,hata.cfirstname![0]);
              } else if (hata.clastname!.isNotEmpty) {
                snackBarDesign(context, StringUtil.error,hata.clastname![0]);
              } else if (hata.caddress!.isNotEmpty) {
                snackBarDesign(context, StringUtil.error,hata.caddress![0]);
              }
               }else {
              snackBarDesign(context, StringUtil.error,response.reasonPhrase!);
              code="error";
              returnval = false;
            }
          } catch (e) {

            returnval = false;
          }
        });
      });
    } catch (e) {
      returnval = false;
    }
    await  showProgress(context, false);
    return code;
  }
  static Future<String> updateUser(BuildContext context, User user,
      String password, String cPassword, String roles, File? imageFile) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.userupdate),
    );
    if (imageFile != null) {
      var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('avatar', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
    }
    request.headers['Authorization'] = "Bearer $token";
    request.headers['profile'] = activeProfile;
    request.headers['salesroleid'] = salesRoleId;
    request.headers['Accept'] = "application/json";
    request.fields['firstname'] = user.firstname ?? "";
    request.fields['lastname'] = user.lastname ?? "";
    request.fields['birthday'] = user.birthday ?? "";
    request.fields['email'] = user.email ?? "";
    request.fields['password'] = password;
    request.fields['c_password'] = cPassword;
    request.fields['address'] = user.address ?? "";
    request.fields['sgoal'] = user.sgoal ?? "";
    request.fields['goal'] = user.goal ?? "";
    request.fields['city'] = user.city ?? "";
    request.fields['state'] = user.state ?? "";
    request.fields['tshirtsize'] = user.tshirtsize.toString();
    request.fields['zipcode'] = user.zipcode ?? "";
    request.fields['phone'] = user.phone ?? "";
    request.fields['role'] = roles;
    request.fields['country'] = user.country ?? "";
    request.fields['county'] = user.county ?? "";
    request.fields['assistboxPassword'] = "Hyla2021";
    request.fields['assistboxToken'] = user.assistboxToken ?? "";

    String code = "";
    try {

      await request.send().then((result) async {
        await http.Response.fromStream(result).then((response) {
          print("dönen kod :${response.statusCode}");
          if (response.statusCode == 200 ||
              response.statusCode == 201 ||
              response.statusCode == 302) {
            if (response.body.isNotEmpty) {

              code = "OK";
            } else {

              code = "ERROR";
            }

          } else if (response.statusCode == 400) {
            var tagObjsJson = jsonDecode(response.body);
            Code hata = Code.fromJson(tagObjsJson);
            if (hata.email!.isNotEmpty) {
              snackBarDesign(context, StringUtil.error,hata.email![0]);
            } else if (hata.code!.isNotEmpty) {
              snackBarDesign(context, StringUtil.error,hata.code![0]);
            } else if (hata.password!.isNotEmpty) {
              snackBarDesign(context, StringUtil.error,hata.password![0]);
            } else if (hata.cpassword!.isNotEmpty) {
              snackBarDesign(context, StringUtil.error,hata.cpassword![0]);
            } else if (hata.name!.isNotEmpty) {
              snackBarDesign(context, StringUtil.error,hata.name![0]);
            } else if (hata.role!.isNotEmpty) {
              snackBarDesign(context, StringUtil.error,hata.role![0]);
            }
            code = "ERROR";
          } else if (response.statusCode == 401) {
            deleteToken(context);
          } else {
            snackBarDesign(context, StringUtil.error, response.reasonPhrase ?? "Error");
            code = "ERROR";
          }
        });
      });
    } catch (e) {
      code = "ERROR";
    }
    return code;
  }
  static Future<Distributor?> getDistributors(BuildContext context) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    await showProgress(context, true);
    Distributor dist = Distributor();
    String filename = "DistributorData.json";
    var cacheDir = await getTemporaryDirectory();
    try {
      final response = await http.get(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.distributors),
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

          var json = jsonDecode(response.body.toString());
          dist = Distributor.fromJson(json);
          await showProgress(context, false);
          return dist;
        } else {
          await showProgress(context, false);
          return null;
        }
      } else if (response.statusCode == 401) {
        deleteToken(context);
      } else {
        dist = await getDistributorDataFromJson(filename, cacheDir);
        await showProgress(context, false);
        return dist;
      }
    } catch (e) {
      dist = await getDistributorDataFromJson(filename, cacheDir);
      await showProgress(context, false);
      return dist;
    }
  }
  static Future<dynamic> getDistributorDataFromJson(filename, cacheDir) async {
    Distributor dist = Distributor();
    if (await File(cacheDir.path + "/" + filename).exists()) {
      var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();

      var json = jsonDecode(jsonData.toString());
      dist = Distributor.fromJson(json);
    }
    return dist;
  }
  static Future<List<LeadReport>?>? allLeadReport(BuildContext context) async {
    List<LeadReport> leadReports = [];
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    print("bilgiler :$token -- $activeProfile -- $salesRoleId");
    try {
        final response = await http.get(Uri.parse("https://hylana.wizz.app/api/v16/reports/leads"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "Accept": "application/json",
          });


      if (response.statusCode==200 || response.statusCode == 201 ||
          response.statusCode == 302){
        if (response.body.isNotEmpty) {
          List<dynamic> jsonList = jsonDecode(response.body.toString());

          for (var jsonItem in jsonList) {
            LeadReport leadReport = LeadReport.fromJson(jsonItem);
            leadReports.add(leadReport);
          }
          return leadReports;
        }
      } else if (response.statusCode == 401) {
        await deleteToken(context);
      } else if (response.statusCode == 400) {

        snackBarDesign(context, StringUtil.error, response.reasonPhrase!);
      } else {
        return null;
      }
    } catch (e) {
       snackBarDesign(context, StringUtil.error, e.toString());
       print("hata mesajı :${e.toString()}");
      return null;
    }
    return null;
  }
  static Future<CareerSales?> getCareerSales(BuildContext context,int userId) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    try{

      final response = await http.get(
          Uri.parse("${ApiEndpoints.baseUrl}/user/$userId/careersales/alltime"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "Accept": "application/json",

          });

      if(response.statusCode==200 || response.statusCode == 201 ||
          response.statusCode == 302){
        var tagObjsJson = jsonDecode(response.body.toString());
        CareerSales careerSales = CareerSales.fromJson(tagObjsJson);
        print("career :${careerSales.approvedsalessofar}");

        return careerSales;
      }else{

      }

    }catch(e){

    }
    return null;

  }
  static Future<dynamic> postReferral(BuildContext context,String list) async {
    showProgress(context, true);
    SharedPref pref = SharedPref();
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    String token = await pref.getString(context, SharedUtils.userToken);
    try{

      final response = await http.post(

        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.postReferral),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "profile": activeProfile,
          "salesroleid": salesRoleId,
          "Accept": "application/json",
        },
        body: list,
      );

       print("dönen değer :${response.statusCode}");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302 ) {


        snackBarDesign(context, StringUtil.success, "successAdded".tr());
        showProgress(context, false);
        return "OKEY";
      } else if (response.statusCode == 401) {
        showProgress(context, false);
        deleteToken(context);

        return "Error";
      } else if (response.statusCode == 400) {
        showProgress(context, false);
        snackBarDesign(context, StringUtil.error, "${response.reasonPhrase!} ${response.body}");


      } else {
        showProgress(context, false);
        snackBarDesign(context, StringUtil.error, response.reasonPhrase!);


      }
    }catch(e){
      showProgress(context, false);
      snackBarDesign(context, StringUtil.error, e.toString());

    }

  }
  static Future<List<GetReferral>?> getReferral(BuildContext context) async {
    SharedPref pref = SharedPref();
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    try {
      final response =

      await http.get(Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.postReferral),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "profile": activeProfile,
            "salesroleid": salesRoleId,
            "Accept": "application/json",
          }
      );
      print("status code :${response.statusCode}");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        if (response.body.isNotEmpty) {

          var json = jsonDecode(response.body.toString());
          var tagObjsJson = json as List;
          List<GetReferral> dataList = [];
          List<GetReferral> referral = tagObjsJson
              .map((tagJson) => GetReferral.fromJson(tagJson))
              .toList();
          dataList = referral;
          return dataList;
        }
      } else if (response.statusCode == 401) {
         deleteToken(context);
      } else if(response.statusCode==400){
        snackBarDesign(context, StringUtil.error, response.reasonPhrase!);

      }else{
        return null;
      }
    } catch (e) {
      // ViewUtil.closeProgress(ViewUtil.bottombarContext!);
      return null;
    }
    return null;
  }
}