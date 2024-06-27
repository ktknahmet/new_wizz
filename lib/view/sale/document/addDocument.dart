import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/helper/PhotoHelper.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/ExpenseVm.dart';
import 'package:wizzsales/viewModel/SaleDocumentVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../../model/saleDocument/saleDocument.dart';
// ignore_for_file: use_build_context_synchronously
class AddDocument extends StatefulWidget {
  final int saleId;
  const AddDocument(this.saleId,{super.key});

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  Map<String, dynamic> photoMap = {};
  SaleDocumentVm viewModel = SaleDocumentVm();
  TextEditingController note = TextEditingController();

  LoginUser? loginUser;
  int? docId;
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(name: "addDocument".tr(),),
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: sizeWidth(context).width,
            height: sizeWidth(context).height,
            child: ChangeNotifierProvider.value(
                    value: viewModel,
                    child: Consumer<SaleDocumentVm>(
                      builder: (context,value,_){
                        return  Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                    width: sizeWidth(context).width * 0.25,
                                    height: sizeWidth(context).height * 0.12,
                                    child:viewModel.selectImage != null ?
                                    ClipOval(
                                        child: Image.file(
                                          viewModel.selectImage!, fit: BoxFit.fill, height: 96,)
                                    ) :  ClipOval(
                                        child: Image.asset(
                                          "assets/slip.png", height: 64,)
                                    )
                                ),
                                const SizedBox(height: 8,),
                                ElevatedButton.icon(
                                  style: elevatedButtonStyle(context),
                                  onPressed: () async {
                                    photoMap = await PhotoHelper.getPhoto(context);
                                    print("photomap: $photoMap");
                                    if (photoMap["image"] != null) {
                                      setState(() {
                                        viewModel.selectImage = photoMap["image"];
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.photo_camera, size: 24.0,
                                    color: ColorUtil().getColor(
                                        context, ColorEnums.wizzColor),),
                                  label: Text("updateDocumentPhoto".tr(),
                                    style: CustomTextStyle().semiBold16(
                                        ColorUtil().getColor(context,
                                            ColorEnums.textDefaultLight)),), // <-- Text
                                ),
                                const SizedBox(height: 16,),
                                Visibility(
                                    visible: viewModel.selectImage == null ? false : true,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                viewModel.deleteImage();
                                              });

                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("delete".tr(),
                                              style: CustomTextStyle().semiBold12(
                                                  ColorUtil().getColor(context,
                                                      ColorEnums.textTitleLight)),)
                                        ),
                                      ],
                                    )
                                ),
                                viewModel.saleDocument == null ?
                                    spinKit(context)
                                :Container(
                                  decoration: containerDecoration(context),
                                  width: sizeWidth(context).width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:   DropdownButton<SaleDocument>(
                                      dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                      underline: const SizedBox(),
                                      hint: Text("selectType".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                      value: docId != null && viewModel.saleDocument!.any((type) => type.id == docId)
                                          ? viewModel.saleDocument!.firstWhere((element) => element.id == docId)
                                          : null,
                                      onChanged: (SaleDocument? newValue) {
                                        setState(() {
                                          docId = newValue?.id;
                                        });
                                      },
                                      items: viewModel.saleDocument!.map<DropdownMenuItem<SaleDocument>>((SaleDocument doc) {
                                        return DropdownMenuItem<SaleDocument>(
                                          value: doc,
                                          child: Text(doc.typeName!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                accountCreate(context, "note", note),
                                const SizedBox(height: 16,),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: sizeWidth(context).width*0.80,
                                  child: ElevatedButton(
                                    onPressed: ()async{
                                      await postDoc();
                                    },
                                    style: elevatedButtonStyle(context),
                                    child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

        ),
      ),
    );
  }
  getList()async{
    await viewModel.saleDocTypes(context);
  }
  postDoc()async{
    if(docId !=null && viewModel.selectImage!=null){
      SharedPref pref = SharedPref();
      loginUser ??= await getUser(context);
      int index = await pref.getInt(context, SharedUtils.profileIndex);
      int userId = loginUser!.profiles![index].id!;
      await viewModel.postSaleDocument(context,docId!,widget.saleId,userId,note.text,viewModel.selectImage!);

      if(viewModel.response!.response.statusCode==200){
        snackBarDesign(context, StringUtil.success, "addedDocument".tr());
        setState(() {
          note.clear();
          viewModel.deleteImage();
        });
      }
    }else{
      snackBarDesign(context, StringUtil.error, "selectTypeAndPhoto".tr());
    }

  }
}