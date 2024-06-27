import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/helper/PhotoHelper.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class UploadPicture extends BaseStatefulPage {
  const UploadPicture(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _UploadPictureState();
}

class _UploadPictureState extends BaseStatefulPageState<UploadPicture> {
  Map<String,dynamic> photoMap={};
  File? selectedImage;
  @override
  Widget design() {
    return Column(
      children: [
        SizedBox(
            width: sizeWidth(context).width*0.25,
            height: sizeWidth(context).height*0.12,
            child:selectedImage != null ?
            ClipOval(
                child:Image.file(selectedImage!,fit: BoxFit.fill,height: 96,)
            ) : ClipOval(
                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
            )
        ),
        const SizedBox(height: 8,),
        ElevatedButton.icon(
          style:elevatedButtonStyle(context),
          onPressed: () async {
            photoMap = await PhotoHelper.getPhoto(context);
            print("photomap: $photoMap");
            if (photoMap["image"] != null) {
              setState(() {
                selectedImage = photoMap["image"];
              });
            }
          },
          icon:  Icon(Icons.photo_camera, size: 24.0,color:ColorUtil().getColor(context, ColorEnums.wizzColor) ,),
          label: Text("updatePicture".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),), // <-- Text
        ),
        const SizedBox(height: 16,),
        Visibility(
            visible: selectedImage  == null ? false :true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: ()async{
                      photoMap = await PhotoHelper.getPhoto(context);

                      if (photoMap["image"] != null) {
                        setState(() {
                          selectedImage = photoMap["image"];
                        });
                      }
                    },
                    style: elevatedButtonStyle(context),

                    child:  Text("reUpload".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)))
                ),

                ElevatedButton(
                    onPressed: ()async{
                      await PhotoHelper.deletePhoto(context, selectedImage);
                      setState(() {
                        selectedImage = null;
                      });
                    },
                    style: elevatedButtonStyle(context),
                    child: Text("delete".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                ),
              ],
            )
        ),
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
                    },
                    child:Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  ),
                ),
                const SizedBox(height: 16,),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
