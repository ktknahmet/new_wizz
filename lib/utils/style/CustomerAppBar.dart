// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/providerFunc/AppStateNotifier.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/ProfileVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
class CustomerAppBar extends StatefulWidget {
  const CustomerAppBar({super.key});

  @override
  State<CustomerAppBar> createState() => _CustomerAppBarState();
}

class _CustomerAppBarState extends State<CustomerAppBar> {
  SharedPref pref = SharedPref();
  ProfileVm viewModel = ProfileVm();
  String isAdmin="";
  @override
  void initState() {
    getInfo();
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>AppStateNotifier(),
      child: Consumer<AppStateNotifier>(
        builder: (context,theme,_){
          theme.setTheme(context);
          return Container(
            color: ColorUtil().getColor(context, ColorEnums.background),
            child:Padding(
              padding: Platform.isAndroid ? const EdgeInsets.only(top: 25) : const EdgeInsets.only(top: 40),
              child: SizedBox(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: GestureDetector(
                            onTap: () async{
                              Scaffold.of(context).openDrawer();
                            },

                            child:Icon(Icons.menu_outlined,color:ColorUtil().getColor(context, ColorEnums.appColor) ,)
                        ),
                      ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/app.png",fit: BoxFit.cover,height:photoHeight(context,sizeWidth(context).height),color: ColorUtil().getColor(context, ColorEnums.appColor),),
                  if (viewModel.user == null) spinKit(context) else Visibility(
                    visible: viewModel.loginUser!.profiles![viewModel.index].salesrolename =="sales-manager" || viewModel.loginUser!.profiles![viewModel.index].salesrolename=="distributor" ? true : false,
                    child: SizedBox(
                      height: 40,
                      child:  Card(
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        shape: cardShape(context),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Text(isAdmin == "admin" ? "switchToStandard".tr() :"switchToAdmin".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(width: 16,),
                              SizedBox(
                                 width: sizeWidth(context).width*0.12,

                                 child: Switch(
                                    activeTrackColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    activeColor: AppColors.white,
                                    value: false,
                                    onChanged: (newView) async{
                                      if(newView ==true){
                                        if(isAdmin=="admin"){
                                          await pref.setString(SharedUtils.admin, "main");
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/${PageName.mainHome}',
                                                (Route<dynamic> route) => false,
                                          );
                                        }else{
                                          await pref.setString(SharedUtils.admin, "admin");
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/${PageName.adminHome}',
                                                (Route<dynamic> route) => false,
                                          );
                                        }


                                      }
                                    },
                                  ),
                               ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/${PageName.notification}');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    ),
                    badgeContent:Text("",style: CustomTextStyle().semiBold12(AppColors.white),),
                    badgeAnimation: const badges.BadgeAnimation.fade(
                      animationDuration: Duration(seconds: 1),
                      colorChangeAnimationDuration: Duration(seconds: 1),
                      loopAnimation: false,
                      curve: Curves.fastOutSlowIn,
                      colorChangeAnimationCurve: Curves.easeInCirc,
                    ),
                    child: Icon(Icons.notifications_active_outlined,color:ColorUtil().getColor(context, ColorEnums.appColor) ,)

                  ),
                ),
              ),
                    ],
                  )
              ),
            ),
          );
        },
      ),
    );
  }
  Future<void>getInfo() async{
    await viewModel.getUserInfo(context);
    isAdmin = await pref.getString(context, SharedUtils.admin);
    print("aktekin :$isAdmin");
  }
}
