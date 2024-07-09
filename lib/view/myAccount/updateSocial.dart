import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/socialModel/postSocial.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/AccountVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import '../../widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously
class UpdateSocial extends BaseStatefulPage {
  const UpdateSocial(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _UpdateSocialState();
}

class _UpdateSocialState extends BaseStatefulPageState<UpdateSocial> {
  AccountVm viewModel = AccountVm();
  TextEditingController twitter = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController tiktok = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController youtube = TextEditingController();
  @override
  void initState() {
    getAccount();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AccountVm>(
        builder: (context,value,_){
          return Column(
              children: [
                socialMediaAccount(context,"addTwitter", twitter, "twitter.png"),
                const SizedBox(height: 16,),
                socialMediaAccount(context,"addInstagram", instagram, "instagram.png"),
                const SizedBox(height: 16,),
                socialMediaAccount(context,"addFacebook", facebook, "facebook.png"),
                const SizedBox(height: 16,),
                socialMediaAccount(context,"addTiktok", tiktok, "tiktok.png"),
                const SizedBox(height: 16,),
                socialMediaAccount(context,"addYoutube", youtube, "youtube.png"),


                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: sizeWidth(context).width*0.75,
                          child: ElevatedButton(
                            style: elevatedButtonStyle(context),
                            onPressed: () async{
                              await post();
                            },
                            child:Text("socialMedia".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                        ),
                        const SizedBox(height: 16,),
                      ],
                    ),
                  ),
                ),

              ],

            );

        },
      ),
    );
  }
  getAccount()async{
    await viewModel.getAccountValue(context,facebook.text,twitter.text,instagram.text,tiktok.text);

    if(viewModel.socialMedia !=null){
      facebook.text = viewModel.socialMedia![0].facebook_user_name ?? "";
      twitter.text = viewModel.socialMedia![0].twitter_user_name ?? "";
      instagram.text = viewModel.socialMedia![0].instagram_user_name ?? "";
      tiktok.text = viewModel.socialMedia![0].tiktok_user_name ?? "";
      youtube.text = viewModel.socialMedia![0].tiktok_user_name ?? "";
    }
  }
  post() async{
   PostSocial post = PostSocial(
     facebookUserName: facebook.text.toLowerCase(),
     twitterUserName: twitter.text.toLowerCase(),
     instagramUserName: instagram.text.toLowerCase(),
     tiktokUserName: tiktok.text.toLowerCase()
   );
   await viewModel.postSocialMedia(context,post);
   if(viewModel.postSocial!.isNotEmpty){
     snackBarDesign(context, StringUtil.success, "updatedSocial".tr());
     Navigator.pushNamed(context, '/${PageName.mainHome}');
   }
  }

}
