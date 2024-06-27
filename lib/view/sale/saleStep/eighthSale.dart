import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/function/helper/PhotoHelper.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class EighthSale extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? totalStepCount;
  final String? step;

  const EighthSale({super.key, required this.continueClick,this.previousClick,this.step, this.totalStepCount});

  @override
  State<EighthSale> createState() => _EighthSaleState();
}

class _EighthSaleState extends State<EighthSale> {
  TextEditingController saleNoteController = TextEditingController();
  Map<String,dynamic> photoMap={};
  File? selectedImage;

  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  void initState() {
    saleNoteController.text =SaleVM.addSaleModel.note ?? "";
    selectedImage = SaleVM.addSaleModel.imageFile;
    print("sales price :${SaleVM.addSaleModel.price}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeWidth(context).height,
      child: Column(
        children: [
          Text("notesSalesPhoto".tr(),style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
          Text("pleaseFillSalesPhoto".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
          const SizedBox(height: 8,),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("${context.tr("step")} 8/${widget.totalStepCount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
          ),
          const SizedBox(height: 40),
          accountCreate(context, "salesNote", saleNoteController),
          const SizedBox(height: 16,),
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
              if (photoMap["image"] != null) {
                setState(() {
                  selectedImage = photoMap["image"];
                });
              }
            },
            icon:  Icon(Icons.photo_camera, size: 24.0,color:ColorUtil().getColor(context, ColorEnums.wizzColor) ,),
            label: Text("addSalePicture".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),), // <-- Text
          ),
          const SizedBox(height: 16,),
          Visibility(
            visible: selectedImage !=null ? true :false,
            child: ElevatedButton(
                onPressed: ()async{
                  await PhotoHelper.deletePhoto(context, selectedImage);
                  setState(() {
                    selectedImage = null;
                  });
                },
                style: elevatedButtonStyle(context),
                child: Text("delete".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ),
          ),
          const SizedBox(height: 8,),
          Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        widget.previousClick!();
                      },
                      style: elevatedButtonStyle(context),
                      child: Text("previous".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        SaleVM.addSaleModel.note = saleNoteController.text;
                        SaleVM.addSaleModel.imageFile = selectedImage;
                        widget.continueClick!();

                      },
                      style: elevatedButtonStyle(context),
                      child: Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    )
                  ],
                ),
              )

        ],
      ),
    );
  }
}
