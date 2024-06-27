import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/model/socialModel/SocialMedia.dart';
import 'package:wizzsales/model/socialModel/postSocial.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously
class AccountVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  List<SocialMedia>? socialMedia;
  String? postSocial;


  Future<void>getAccountValue(BuildContext context,String facebook,String twitter,String instagram,String tiktok) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);


    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
       await apiService.getSocial(facebook,twitter,instagram,tiktok).then((value) =>{
         socialMedia = value,
       });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;

        if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }else if(res!.statusCode==400) {
          
        }else if (error.type == DioExceptionType.connectionError) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/${PageName.internetPage}',
                (Route<dynamic> route) => false,
          );
        }
      }
    } finally {

      notifyListeners();

    }

  }
  Future<void>postSocialMedia(BuildContext context,PostSocial social) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      postSocial = await apiService.postSocial(social);

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      // İşlemin sonunda her durumda notifyListeners ve showProgress(false) yapılır
      notifyListeners();
      showProgress(context, false);
    }

  }
}