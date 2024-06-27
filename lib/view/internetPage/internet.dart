import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';

class Internet extends StatefulWidget {
  const Internet({super.key});

  @override
  State<Internet> createState() => _InternetState();
}

class _InternetState extends State<Internet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context,ColorEnums.background ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Image.asset("assets/noInternet.png"),
         const SizedBox(height: 8,),
          Text("noInternet".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
         const SizedBox(height: 8,),
         ElevatedButton(
           onPressed: ()async{
             Navigator.pushNamedAndRemoveUntil(
               context,
               '/${PageName.myApp}',
                   (Route<dynamic> route) => false,
             );

           },
           style: elevatedButtonStyle(context),
           child: Text("tryAgain".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
         ) 
        ],
      ),
    );
  }
}
