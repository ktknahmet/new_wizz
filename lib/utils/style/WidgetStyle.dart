import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

cardShape(BuildContext context){
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side:  const BorderSide(color:AppColors.wizzColor, width: 0.6,),
  );
}
homeCard(BuildContext context){
  return RoundedRectangleBorder(
    borderRadius:
    BorderRadius.circular(24.0), // Set border radius
  );
}
cardErrorShape(BuildContext context){
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    side:  BorderSide(color:ColorUtil().getColor(context, ColorEnums.error), width: 1,),
  );
}
elevatedButtonStyle(BuildContext context){
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
    side: BorderSide(
        width: 1,
        color: ColorUtil().getColor(context, ColorEnums.wizzColor),
        style: BorderStyle.solid,),
    shape: RoundedRectangleBorder( // Kare şeklinde düğme için şekil tanımlandı
        borderRadius: BorderRadius.circular(12)),
  );
}
buttonStyle(BuildContext context){
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,

  side: BorderSide(
        width: 1.5,
        color: ColorUtil().getColor(context, ColorEnums.wizzColor),
        style: BorderStyle.solid),
        shape: RoundedRectangleBorder( // Kare şeklinde düğme için şekil tanımlandı
        borderRadius: BorderRadius.circular(12)),
  );
}

buttonWhiteStyle(BuildContext context){
  return ElevatedButton.styleFrom(
    backgroundColor:AppColors.wizzColor,
    shadowColor: Colors.transparent,

    side: BorderSide(
        width: 1,
        color: ColorUtil().getColor(context, ColorEnums.wizzColor),
        style: BorderStyle.solid),
    shape: RoundedRectangleBorder( // Kare şeklinde düğme için şekil tanımlandı
        borderRadius: BorderRadius.circular(0)),
  );
}
elevatedWhiteButtonStyle(BuildContext context){
  return ElevatedButton.styleFrom(
    backgroundColor:AppColors.wizzColor,
    shadowColor: Colors.transparent,


  );
}
containerDecoration(BuildContext context){
  return BoxDecoration(
      color: ColorUtil().getColor(context,ColorEnums.background),
      border: Border.all(color: ColorUtil().getColor(context,ColorEnums.wizzColor), width: 1),
      borderRadius: BorderRadius.circular(15));
}

containerWhiteDecoration(BuildContext context){
  return BoxDecoration(
      color: ColorUtil().getColor(context,ColorEnums.wizzColor),
      border: Border.all(color: ColorUtil().getColor(context,ColorEnums.wizzColor), width: 1),
      borderRadius: BorderRadius.circular(15));
}

whiteDecoration(BuildContext context){
  return BoxDecoration(
      color: ColorUtil().getColor(context,ColorEnums.wizzColor),
      border: Border.all(color: ColorUtil().getColor(context,ColorEnums.wizzColor), width: 1));
}

decoration(BuildContext context){
  return BoxDecoration(
      color: ColorUtil().getColor(context,ColorEnums.background),
      border: Border.all(color: ColorUtil().getColor(context,ColorEnums.wizzColor), width: 1));
}
decorationTransparent(BuildContext context){
  return BoxDecoration(
      color: Colors.transparent,
      border: Border.all(color: ColorUtil().getColor(context,ColorEnums.wizzColor), width: 1.6),
      borderRadius: BorderRadius.circular(15));
}
mainDecoration(BuildContext context){
  return BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: ColorUtil().getColor(context, ColorEnums.mainCard));
}
emptyDecoration(BuildContext context){
  return const InputDecoration(
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
  );
}
containerPageDecoration(BuildContext context){
  return BoxDecoration(
      color: ColorUtil().getColor(context,ColorEnums.wizzColor),
      border: Border.all(color: ColorUtil().getColor(context,ColorEnums.background), width: 1),
      borderRadius: BorderRadius.circular(32));
}
dateInputDecoration(BuildContext context,String hint){
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: ColorUtil().getColor(context, ColorEnums.wizzColor))
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
    hintText: hint.tr(),
    hintStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
            width: 2.0),
        borderRadius: BorderRadius.circular(6.0)),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorUtil()
                .getColor(context, ColorEnums.shadowDefaultLight),
            width: 1.0),
        borderRadius: BorderRadius.circular(6.0)),
  );
}
phoneDecoration(BuildContext context){
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: ColorUtil().getColor(context, ColorEnums.wizzColor))
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius:
      const BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 2, color: ColorUtil().getColor(context, ColorEnums.wizzColor)),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 10),
    border: const OutlineInputBorder(),
  );
}

textFieldTextDesign(BuildContext context,String hint){
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: ColorUtil().getColor(context, ColorEnums.wizzColor))
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
    hintText: hint.tr(),
    hintStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
            width: 2.0),
        borderRadius: BorderRadius.circular(6.0)),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorUtil()
                .getColor(context, ColorEnums.shadowDefaultLight),
            width: 1.0),
        borderRadius: BorderRadius.circular(6.0)),
  );
}
socialMediaTextDesign(BuildContext context,String photo,String name){
  return InputDecoration(
    prefixIcon: Image.asset("assets/$photo", height: 24,),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4),),
    ),
    hintText: name.tr(),
    hintStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: ColorUtil().getColor(context, ColorEnums.wizzColor))
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
            width: 2.0),
        borderRadius: BorderRadius.circular(6.0)),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorUtil()
                .getColor(context, ColorEnums.shadowDefaultLight),
            width: 1.0),
        borderRadius: BorderRadius.circular(6.0)),
  );
}
snackBarDesign(BuildContext context,String type,String message){
  double height = sizeWidth(context).height;
  double autoHeight=0.0;
  if(height<=800){
    autoHeight = message.length+80;
  }else if(height>800 && height<1180){
    autoHeight = message.length+100;
  }else if(height>=1180 && height<1365){
    autoHeight = message.length+120;
  }else{
    autoHeight = message.length+140;
  }
  final snackBar = SnackBar(

    elevation: 0,
    duration: const Duration(seconds: 4),
    /*margin: EdgeInsets.only(
      bottom: sizeWidth(context).height-250,
    ),*/
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.transparent,
    content: SizedBox(
      width: sizeWidth(context).width,
      height: autoHeight,
      child: AwesomeSnackbarContent(
        color: type == StringUtil.success ? ColorUtil().getColor(context, ColorEnums.wizzColor)  :
        type == StringUtil.error ? ColorUtil().getColor(context, ColorEnums.error) :
        ColorUtil().getColor(context, ColorEnums.warning) ,
        title: "",
        messageFontSize: 16,
        message:message,
        contentType: type == StringUtil.success ? ContentType.success  :
        type == StringUtil.error ? ContentType.failure : ContentType.warning,
      ),
    ),

  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
bottomSheetShape(BuildContext context){
  return RoundedRectangleBorder(
      side: BorderSide(color: ColorUtil().getColor(context, ColorEnums.wizzColor)),
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24)));
}
searchTextDesign(BuildContext context,String hint){
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: ColorUtil().getColor(context, ColorEnums.wizzColor))
    ),
    contentPadding: const EdgeInsets.all(8),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorUtil().getColor(context, ColorEnums.wizzColor),width: 2.0),
        borderRadius: BorderRadius.circular(6.0)
    ),
    hintText: hint.tr(),
    hintStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
    prefixIcon: Icon(Icons.search,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(7.0)),),
  );
}