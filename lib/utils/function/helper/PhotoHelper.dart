import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class PhotoHelper {
  static Future<Map<String, dynamic>> getPhoto(BuildContext context) async {
    Map<String, dynamic> photoFile = {};
    await showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      shape: bottomSheetShape(context),
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  await openImagePicker().then((value) => {
                    photoFile["image"] = File(value!),
                  });
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/camera.png",
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    ),
                    const SizedBox(width: 4,),
                    Text(
                      "camera".tr(),
                      style: CustomTextStyle()
                          .semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              GestureDetector(
                onTap: () async {
                  await openGalleryPicker().then((value) => {
                    photoFile["image"] = File(value!),
                  });
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/gallery.png",
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    ),
                    const SizedBox(width: 4,),
                    Text(
                      "gallery".tr(),
                      style: CustomTextStyle()
                          .semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    return photoFile;
  }
  static Future<void>deletePhoto(BuildContext context,File? file) async{
    await file!.delete();
  }
}