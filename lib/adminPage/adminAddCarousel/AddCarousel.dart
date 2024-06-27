import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminVm/adminCarouselVm.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/helper/DocumentHelper.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../constants/colorsUtil.dart';
import '../../utils/function/helper/PhotoHelper.dart';
// ignore_for_file: use_build_context_synchronously


class AddCarousel extends BaseStatefulPage {
  const AddCarousel(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AddCarouselState();
}

class _AddCarouselState extends BaseStatefulPageState<AddCarousel> {
  Map<String, dynamic> photoMap = {};
  Map<String, dynamic> docMap = {};
  AdminCarouselVm viewModel = AdminCarouselVm();
  TextEditingController order = TextEditingController();
  TextEditingController sliderName=TextEditingController();
  TextEditingController setLink=TextEditingController();

  bool result=false;
  File? abc;



  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,

      child: Consumer<AdminCarouselVm>(
        builder: (context,value,_){
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    width: sizeWidth(context).width*0.90,
                    height: sizeWidth(context).height * 0.18,
                    child:viewModel.selectImage != null ?
                    Image.file(
                      viewModel.selectImage!, fit: BoxFit.contain,)
                        :  Image.asset(
                      "assets/slip.png", height: 64,)
                ),

                const SizedBox(height: 8,),
                ElevatedButton.icon(
                  style: elevatedButtonStyle(context),
                  onPressed: () async {
                    photoMap = await PhotoHelper.getPhoto(context);
                    if (photoMap["image"] != null) {
                      setState(() {
                        viewModel.selectImage = photoMap["image"];
                      });
                    }
                  },
                  icon: Icon(Icons.photo_camera, size: 24.0,
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                  label: Text("carouselMedia".tr(),
                    style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),), // <-- Text
                ),
                const SizedBox(height: 16,),
                Visibility(
                    visible: viewModel.selectImage == null ? false : true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                viewModel.deleteImage();
                              });
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("delete".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 8,),
                accountCreate(context, "carouselName", sliderName),
                const SizedBox(height: 8,),
                accountNumber(context, "carouselOrder", order),
                const SizedBox(height: 8,),
                Container(
                  decoration: containerDecoration(context),
                  width: sizeWidth(context).width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                      underline: const SizedBox(),
                      hint: Text(
                        "selectCarouselType".tr(),
                        style: CustomTextStyle().semiBold12(
                          ColorUtil().getColor(context, ColorEnums.textTitleLight),
                        ),
                      ),
                      value: viewModel.type != null
                          ? carouselType.keys.firstWhere((element) => element== viewModel.type)
                          : null,
                      onChanged: (String? newValue) {
                        viewModel.setType(newValue!);
                        viewModel.setSliderType(carouselType[newValue]);
                        viewModel.setAddedPhoto(false);

                      },
                      items: carouselType.keys.map((String key) {
                        // carouselType haritasındaki her bir anahtar için bir DropdownMenuItem oluşturun
                        return DropdownMenuItem<String>(
                          value: key,
                          child: Text(
                            key,
                            style: CustomTextStyle().semiBold12(
                              ColorUtil().getColor(context, ColorEnums.textDefaultLight),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                Visibility(
                    visible: viewModel.sliderType=="link" ? true :false,
                    child: accountCreate(context, "setLink", setLink)),


                Visibility(
                  visible: viewModel.addedPhoto == true ? true : false,
                  child: Card(
                    shape: cardShape(context),
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("docUploaded".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          Icon(Icons.check,color: ColorUtil().getColor(context, ColorEnums.wizzColor),)
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:viewModel.sliderType !=null && viewModel.sliderType!="link" ? true :false,
                  child:  Column(
                    children: [
                      ElevatedButton.icon(
                        style: elevatedButtonStyle(context),
                        onPressed: () async {
                          docMap=await DocumentHelper.getDocument(context);
                          if (docMap["document"] != null) {
                            viewModel.setFileType(docMap["fileType"]);
                            viewModel.uploadDocument = docMap["document"];
                            if(viewModel.uploadDocument!=null){
                              result =  await uploadDocument(context,viewModel.uploadDocument!,docMap["fileType"]);
                              if(result){
                                viewModel.setAddedPhoto(true);
                                snackBarDesign(context, StringUtil.success, "docUploaded".tr());
                              }else{
                                viewModel.setAddedPhoto(false);
                              }
                            }
                          }
                        },
                        icon: Icon(Icons.drive_folder_upload_outlined, size: 24.0,
                          color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                        label: Text("uploadDocument".tr(),
                          style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),), // <-- Text
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 16,),
                SizedBox(
                  width: sizeWidth(context).width*0.80,
                  child: ElevatedButton(
                    onPressed: ()async{

                      await post();
                    },
                    style: elevatedButtonStyle(context),
                    child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
  post()async{
    if(viewModel.sliderType == null){
      snackBarDesign(context, StringUtil.error, "pleaseSelectCarouselType".tr());
      return;
    }
      if(viewModel.sliderType=="link"){

        if(viewModel.selectImage !=null && sliderName.text.isNotEmpty && order.text.isNotEmpty && viewModel.sliderType!.isNotEmpty && setLink.text.isNotEmpty){

          await viewModel.postSliderLink(
            context,
            sliderName.text,
            int.parse(order.text),
            setLink.text,
              viewModel.sliderType!,
            viewModel.selectImage!);
          if(viewModel.response!.response.statusCode==200){

            setState(() {
              viewModel.deleteImage();
              viewModel.sliderType = null;
              viewModel.type = null;
              setLink.clear();
              order.clear();
              sliderName.clear();
            });
          }else{
            snackBarDesign(context, StringUtil.error, viewModel.response!.response.statusMessage!);
          }
        }else{
          snackBarDesign(context, StringUtil.error, "allAreaMustRequired".tr());
        }
      }else{
        if(viewModel.selectImage !=null && sliderName.text.isNotEmpty && order.text.isNotEmpty && viewModel.sliderType!.isNotEmpty && result==true && viewModel.uploadDocument!=null){

          await viewModel.postSlider(
            context,
            sliderName.text,
            int.parse(order.text),
            "",
            viewModel.uploadDocument,
            viewModel.sliderType!,
            viewModel.selectImage!,);
          if(viewModel.response!.response.statusCode==200){

            setState(() {
              viewModel.deleteImage();
              viewModel.sliderType = null;
              viewModel.type = null;
              setLink.clear();
              order.clear();
              sliderName.clear();
            });
          }else{
            snackBarDesign(context, StringUtil.error, viewModel.response!.response.statusMessage!);
          }
        }else{
          snackBarDesign(context, StringUtil.error, "allAreaMustRequired".tr());
        }
      }
}

}
