import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/viewModel/SalesVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../../utils/style/CustomTextStyle.dart';

class InfoStep extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? step;
  final String? totalStepCount;
  const InfoStep({super.key, required this.continueClick,this.previousClick,this.step, this.totalStepCount});

  @override
  State<InfoStep> createState() => _InfoStepState();
}

class _InfoStepState extends State<InfoStep> {
  TextEditingController cFirstName=TextEditingController();
  TextEditingController cLastName=TextEditingController();
  TextEditingController cEmail=TextEditingController();
  TextEditingController cPhoneNumber = TextEditingController();
  TextEditingController sFirstName=TextEditingController();
  TextEditingController sLastName=TextEditingController();
  TextEditingController sEmail=TextEditingController();
  TextEditingController sPhoneNumber = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController address = TextEditingController();
  @override
  void initState() {
    setState(() {


        cFirstName.text = SaleVM.addSaleModel.cfirstname ?? "";
        cLastName.text = SaleVM.addSaleModel.clastname ?? "";
        cEmail.text = SaleVM.addSaleModel.cemail ?? "";
        cPhoneNumber.text = SaleVM.addSaleModel.cphone2 ?? "";
        sFirstName.text = SaleVM.addSaleModel.sfirstname ?? "";
        sLastName.text = SaleVM.addSaleModel.slastname ?? "";
        sEmail.text = SaleVM.addSaleModel.semail ?? "";
        address.text = SaleVM.addSaleModel.caddress ?? "";
        city.text = SaleVM.addSaleModel.ccity ?? "";
        zipcode.text = SaleVM.addSaleModel.czipcode ?? "";
        county.text = SaleVM.addSaleModel.ccounty ?? "";
        state.text = SaleVM.addSaleModel.cstate ?? "";
        cPhoneNumber.text = extractPhoneNumber(SaleVM.addSaleModel.cphone ?? "");
        sPhoneNumber.text = extractPhoneNumber(SaleVM.addSaleModel.sphone ?? "");

    });
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> SalesVm(),
      child: Consumer<SalesVm>(
        builder: (context,viewModel,_){
          return  Column(
              children: [
                Text("customerInfo".tr(),style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                Text("pleaseFillInfo".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                const SizedBox(height: 8,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${context.tr("step")} 3/${widget.totalStepCount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                ),
                const SizedBox(height: 8,),
                accountCreate(context, "firstName", cFirstName),
                const SizedBox(height: 8,),
                accountCreate(context, "lastName", cLastName),
                const SizedBox(height: 8,),
                mailCreate(context, "email", cEmail),
                const SizedBox(height: 8,),
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
                  controller: cPhoneNumber,
                  initialCountryCode:viewModel.cCountryCode ?? "US",
                  showDropdownIcon: true,
                  dropdownIconPosition: IconPosition.trailing,
                  onCountryChanged: (code){
                    viewModel.changeCode(code.dialCode);
                    SaleVM.addSaleModel.cCode = viewModel.cCountryCode!;
                  },
                ),
                const SizedBox(height: 8,),
                SizedBox(
                  width: sizeWidth(context).width*0.85,
                  child: Text("spouseCanEmpty".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                ),
                const SizedBox(height: 8,),
                accountCreate(context, "sFirstName", sFirstName),
                const SizedBox(height: 8,),
                accountCreate(context, "sLastName", sLastName),
                const SizedBox(height: 8,),
                mailCreate(context, "sEmail", sEmail),
                const SizedBox(height: 8,),
                Align(
                    alignment: Alignment.centerLeft,
                    child:Text("sPhone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                  controller: sPhoneNumber,
                  initialCountryCode:viewModel.sCountryCode ?? "US",
                  showDropdownIcon: true,
                  dropdownIconPosition: IconPosition.trailing,
                  onCountryChanged: (code){
                    viewModel.changeSCode(code.dialCode);
                    SaleVM.addSaleModel.sphone2 = viewModel.sCountryCode!;
                  },
                ),
                const SizedBox(height: 16,),
                accountCreate(context, "address", address),

                const SizedBox(height: 16,),
                accountCreate(context, "zipCode", zipcode),
                const SizedBox(height: 16,),
                accountCreate(context, "city", city),
                const SizedBox(height: 16,),
                accountCreate(context, "state", state),
                const SizedBox(height: 16,),
                accountCreate(context, "county", county),
                const SizedBox(height: 16,),
                ChangeNotifierProvider<LocationProvider>(
                  create: (_)=>LocationProvider(),
                  child: Consumer<LocationProvider>(
                    builder: (context,value,_){

                      return ElevatedButton(
                        style: elevatedButtonStyle(context),
                        onPressed: () async{
                          await value.getLocationDetails(context);
                          zipcode.text = value.locationDetails["zipcode"] ?? "";
                          county.text = value.locationDetails["county"] ?? "";
                          state.text = value.locationDetails["state"] ?? "";
                          city.text = value.locationDetails["city"] ?? "";
                          address.text = value.locationDetails["street"] ?? "";

                        },
                        child:  Text("fillFromLocation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8,top: 24),
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
                          onPressed: () async{
                            nextPage();
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
  nextPage(){

    if(cFirstName.text.isNotEmpty && cLastName.text.isNotEmpty &&
        cEmail.text.isNotEmpty && cPhoneNumber.text.isNotEmpty && address.text.isNotEmpty
        && zipcode.text.isNotEmpty && city.text.isNotEmpty && state.text.isNotEmpty){
      bool mail = isEmail(cEmail.text.toString());
      if(mail){
        String cDialCode = SaleVM.addSaleModel.cCode ?? "1";
        String cLastPhone = cPhoneNumber.text;

        String sDialCode = SaleVM.addSaleModel.sphone2 ?? "1";
        String sLastPhone = sPhoneNumber.text;
        if(sPhoneNumber.text.isNotEmpty){
          SaleVM.addSaleModel.sphone = "+$sDialCode-$sLastPhone";
        }
        SaleVM.addSaleModel.cphone = "+$cDialCode-$cLastPhone";
        SaleVM.addSaleModel.cfirstname = cFirstName.text;
        SaleVM.addSaleModel.clastname = cLastName.text;
        SaleVM.addSaleModel.cemail = cEmail.text;
        if (sFirstName.text.isNotEmpty) {
          SaleVM.addSaleModel.sfirstname = sFirstName.text;
        }
        if (sLastName.text.isNotEmpty) {
          SaleVM.addSaleModel.slastname = sLastName.text;
        }
        if (sEmail.text.isNotEmpty) {
          if(isEmail(sEmail.text)){
            SaleVM.addSaleModel.semail = sEmail.text;
          }else{
            snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
          }
        }
        SaleVM.addSaleModel.caddress = address.text;
        SaleVM.addSaleModel.ccity = city.text;
        SaleVM.addSaleModel.czipcode = zipcode.text;
        SaleVM.addSaleModel.ccounty = county.text;
        SaleVM.addSaleModel.cstate = state.text;
        widget.continueClick!();
      }else{
        snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
      }


    }else{
      snackBarDesign(context, StringUtil.error, "personalInfoMustRequired".tr());
    }
  }
}
