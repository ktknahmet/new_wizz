
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';

class CheckBackBar extends StatelessWidget implements PreferredSizeWidget{
  final String name;
  final bool? check;
  const CheckBackBar({super.key, required this.name,this.check});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: AppBar(
        leading:BackButton(color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),
        onPressed: (){
          if(check ==true){
            Navigator.pop(context);
          }else{
            showSaveBonusDialog(context);
          }
        },),
        elevation: 0,
        backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
        title: Text(name, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textTitleLight))),

      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(96);
}
