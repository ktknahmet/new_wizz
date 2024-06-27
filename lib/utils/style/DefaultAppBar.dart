
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String name;
  const DefaultAppBar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: AppBar(
        leading:BackButton(color: ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
        elevation: 0,
        backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
        title: Text(name, style: CustomTextStyle().semiBold14(ColorUtil().getColor(context,ColorEnums.textTitleLight))),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(96);
}
