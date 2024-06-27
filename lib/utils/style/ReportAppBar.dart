
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';

class ReportAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String name;
  final Function? func;
  const ReportAppBar({super.key, required this.name,this.func});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: AppBar(
        leading:BackButton(color: ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
        elevation: 0,
        backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
        title: Text(name, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textTitleLight))),
        actions: func != null
            ? <Widget>[
          IconButton(
            icon: Icon(
              Icons.download,
              color: ColorUtil().getColor(context, ColorEnums.textTitleLight),
            ),
            onPressed: () async {
              await func!();
            },
          ),
        ]
            : <Widget>[],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(96);
}
