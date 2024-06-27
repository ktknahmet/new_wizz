
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';

class PdfAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String name;
  final PdfViewerController controller;
  const PdfAppBar({super.key, required this.name,required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: AppBar(
        leading:BackButton(color: ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
        elevation: 0,
        backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
        title: Text(name, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textTitleLight))),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.first_page,
              color: ColorUtil().getColor(context, ColorEnums.wizzColor),
            ),
            onPressed: () {
              controller.previousPage();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.last_page,
              color: ColorUtil().getColor(context, ColorEnums.wizzColor),
            ),
            onPressed: () {
              controller.nextPage();
            },
          ),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(96);
}
