import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/function/helper/PhotoHelper.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/viewModel/QuickSaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class InformationStep extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? step;
  final String? totalStepCount;
  const InformationStep({super.key, required this.continueClick,this.previousClick,this.step, this.totalStepCount});

  @override
  State<InformationStep> createState() => _InformationStepState();
}

class _InformationStepState extends State<InformationStep> {
  QuickSaleVm viewModel = QuickSaleVm();
  TextEditingController saleNoteController = TextEditingController();

  Map<String,dynamic> photoMap={};

  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  void initState() {
    SaleVM.addSaleModel.date = mmDDYDate(DateTime.now().toString());

    saleNoteController.text =SaleVM.addSaleModel.note ?? "";
    viewModel.selectedImage = SaleVM.addSaleModel.imageFile;
    print("telefon :${SaleVM.addSaleModel.cphone}  -- ${SaleVM.addSaleModel.clastname} -- ${SaleVM.addSaleModel.cemail}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<QuickSaleVm>(
        builder: (context,value,_){
          return Column(
              children: [
                Text("customerInfo".tr(),style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                const SizedBox(height: 8,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${context.tr("step")} 2/${widget.totalStepCount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                ),
                SizedBox(
                    width: sizeWidth(context).width*0.25,
                    height: sizeWidth(context).height*0.12,
                    child:viewModel.selectedImage != null ?
                    ClipOval(
                        child:Image.file(viewModel.selectedImage!,fit: BoxFit.fill,height: 96,)
                    ) : ClipOval(
                        child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                    )
                ),
                const SizedBox(height: 8,),
                ElevatedButton.icon(
                  style:elevatedButtonStyle(context),
                  onPressed: () async {
                    clearFocus(context);
                    photoMap = await PhotoHelper.getPhoto(context);
                    if (photoMap["image"] != null) {
                      setState(() {
                        viewModel.selectedImage = photoMap["image"];
                      });
                    }
                  },
                  icon:  Icon(Icons.photo_camera, size: 24.0,color:ColorUtil().getColor(context, ColorEnums.wizzColor) ,),
                  label: Text("addSalePicture".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),), // <-- Text
                ),
                const SizedBox(height: 16,),
                Visibility(
                  visible: viewModel.selectedImage !=null ? true :false,
                  child: ElevatedButton(
                      onPressed: ()async{
                        await PhotoHelper.deletePhoto(context, viewModel.selectedImage);
                        setState(() {
                          viewModel.selectedImage = null;
                        });
                      },
                      style: elevatedButtonStyle(context),
                      child: Text("delete".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                  ),
                ),
                const SizedBox(height: 8,),
                accountCreate(context, "salesNote", saleNoteController),
                if(SaleVM.addSaleModel.clastname!.isEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 8,),
                      accountCreate(context, "cLastName", viewModel.lastNameController),
                    ],
                  ),
                if(SaleVM.addSaleModel.cemail!.isEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 8,),
                      mailCreate(context, "email", viewModel.emailController),
                    ],
                  ),
                if(SaleVM.addSaleModel.cphone!.isEmpty)
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child:Text("cPhone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      IntlPhoneField(
                        decoration:phoneDecoration(context),
                        flagsButtonMargin: const EdgeInsets.only(left: 20),
                        disableLengthCheck: true,
                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                        dropdownTextStyle:CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [maskFormatter],
                        showCountryFlag: true,
                        cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                        controller: viewModel.phoneController,
                        initialCountryCode:viewModel.cCountryCode ?? "US",
                        showDropdownIcon: true,
                        dropdownIconPosition: IconPosition.trailing,
                        onCountryChanged: (code){
                          viewModel.changeCode(code.dialCode);
                          SaleVM.addSaleModel.cCode = viewModel.cCountryCode!;
                        },
                      ),
                      const SizedBox(height: 8,)
                    ],
                  ),
                Card(
                  shape: cardShape(context),
                  color: ColorUtil().getColor(context, ColorEnums.background),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:sizeWidth(context).width*0.40,
                                child: Text("date".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(SaleVM.addSaleModel.date ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:sizeWidth(context).width*0.40,
                                child: Text("cName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(SaleVM.addSaleModel.cfirstname ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ],
                        ),

                        if(SaleVM.addSaleModel.clastname!.isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width:sizeWidth(context).width*0.40,
                                      child: Text("cLastName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(SaleVM.addSaleModel.clastname ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        if(SaleVM.addSaleModel.cphone!.isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width:sizeWidth(context).width*0.40,
                                      child: Text("cPhone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(SaleVM.addSaleModel.cphone!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        const SizedBox(height: 4,),
                        if(SaleVM.addSaleModel.cemail!.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width:sizeWidth(context).width*0.25,
                                  child: Text("cEmail".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(SaleVM.addSaleModel.cemail ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:sizeWidth(context).width*0.40,
                                child: Text("address".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(SaleVM.addSaleModel.caddress ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:sizeWidth(context).width*0.40,
                                child: Text("state".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(SaleVM.addSaleModel.cstate ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:sizeWidth(context).width*0.40,
                                child: Text("city".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(SaleVM.addSaleModel.ccity ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:sizeWidth(context).width*0.40,
                                child: Text("zipCode".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(SaleVM.addSaleModel.czipcode ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8,top: 16),
                  child: SizedBox(
                    width: sizeWidth(context).width,
                    height: sizeWidth(context).height*0.05,
                    child:  Row(
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
                          onPressed: () {
                            control();
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        )
                      ],
                    ),
                  ),
                )

              ]
          );
        },
      ),
    );
  }
  control()async{

    SaleVM.addSaleModel.note = saleNoteController.text;
    SaleVM.addSaleModel.imageFile = viewModel.selectedImage;

    if(SaleVM.addSaleModel.clastname!.isEmpty){
      if(viewModel.lastNameController.text.isNotEmpty){
        viewModel.setLastName(viewModel.lastNameController.text);
        SaleVM.addSaleModel.clastname = viewModel.lastName;
      }else{
        snackBarDesign(context, StringUtil.error, "lastNameEmailPhone".tr());
      }
      return;
    }

    if(SaleVM.addSaleModel.cemail!.isEmpty){
      bool check= isEmail(viewModel.emailController.text.isNotEmpty ? viewModel.emailController.text : "");
      if(check){
        viewModel.setEmail(viewModel.lastNameController.text);
        SaleVM.addSaleModel.cemail = viewModel.emailController.text;
      }else{
        snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
      }
      return;
    }
    if(SaleVM.addSaleModel.cphone!.isEmpty){


      String cDialCode = viewModel.cCountryCode ?? "1";

      viewModel.setPhone(viewModel.phoneController.text.isNotEmpty ? viewModel.phoneController.text :"");
      if(viewModel.phone!.length ==10){
        SaleVM.addSaleModel.cphone = "+$cDialCode-${viewModel.phone}";
      }else{
        snackBarDesign(context, StringUtil.error, "phoneMustDigit".tr());
      }
      return;
    }

    if(SaleVM.addSaleModel.clastname!.isEmpty || SaleVM.addSaleModel.cemail!.isEmpty || SaleVM.addSaleModel.cphone!.isEmpty){
      snackBarDesign(context, StringUtil.error, "lastNameEmailPhone".tr());
      return;
    }else{
      widget.continueClick!();
    }

  }
}
