import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Draw.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/viewModel/VacationVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../utils/function/providerFunc/LocationProvider.dart';

class VacationDrawing extends BaseStatefulPage {
  const VacationDrawing(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _VacationDrawingState();
}

class _VacationDrawingState extends BaseStatefulPageState<VacationDrawing> {
  TextEditingController cFirstName=TextEditingController();
  TextEditingController cLastName=TextEditingController();
  TextEditingController cEmail=TextEditingController();
  TextEditingController sFirstName=TextEditingController();
  TextEditingController sLastName=TextEditingController();
  TextEditingController sEmail=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController zipCode=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController country=TextEditingController();
  TextEditingController county=TextEditingController();
  TextEditingController cPhoneNumber = TextEditingController();
  TextEditingController sPhoneNumber = TextEditingController();
  String countryCode="";
  String countryNumber="";
  String countryIsoCode="";
  String scountryCode="";
  String scountryNumber="";
  String scountryIsoCode="";
  Draw post = Draw();

  @override
  Widget design() {
    return ChangeNotifierProvider(
      create: (_)=>VacationVm(),
      child: Consumer<VacationVm>(
        builder: (context,value,_){
          return Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        accountCreate(context, "cFirstName", cFirstName),
                        const SizedBox(height: 8,),
                        accountCreate(context, "cLastName", cLastName),
                        const SizedBox(height: 8,),
                        mailCreate(context, "cEmail", cEmail),
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
                          initialCountryCode: value.cCountryCode,
                          showDropdownIcon: true,
                          dropdownIconPosition: IconPosition.trailing,
                          onCountryChanged: (code){
                            value.changeCode(code.dialCode);
                          },
                          onChanged: (change){
                            setState(() {
                              countryCode=change.countryCode;
                              countryNumber = change.number;
                              countryIsoCode = change.countryISOCode;
                            });
                          },
                        ),
                        const SizedBox(height: 8,),
                        accountCreate(context, "address", address),
                        const SizedBox(height: 8,),
                        accountCreate(context, "zipCode", zipCode),
                        const SizedBox(height: 8,),
                        accountCreate(context, "city", city),
                        const SizedBox(height: 8,),
                        accountCreate(context, "state", state),
                        const SizedBox(height: 8,),
                        accountCreate(context, "country", country),
                        const SizedBox(height: 8,),
                        accountCreate(context, "county", county),
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
                          initialCountryCode: value.sCountryCode,
                          showDropdownIcon: true,
                          dropdownIconPosition: IconPosition.trailing,

                          onCountryChanged: (code){
                            value.changeSCode(code.dialCode);
                          },
                          onChanged: (change){
                            setState(() {
                              scountryCode=change.countryCode;
                              scountryNumber = change.number;
                              scountryIsoCode = change.countryISOCode;
                            });
                          },
                        ),

                      ],
                    ),
                  )
              ),
              const SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: 44,
                              child: Center(
                                  child: ChangeNotifierProvider<LocationProvider>(
                                    create: (_)=>LocationProvider(),
                                    child: Consumer<LocationProvider>(
                                      builder: (context,value,_){
                                        return ElevatedButton(
                                          style: elevatedButtonStyle(context),
                                          onPressed: () async{
                                            await value.getLocationDetails(context);
                                            zipCode.text = value.locationDetails["zipcode"] ?? "";
                                            country.text = value.locationDetails["country"] ?? "";
                                            county.text = value.locationDetails["county"] ?? "";
                                            state.text = value.locationDetails["state"] ?? "";
                                            city.text = value.locationDetails["city"] ?? "";
                                            address.text = value.locationDetails["street"] ?? "";

                                          },
                                          child:  Text("fillFromLocation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        );
                                      },
                                    ),
                                  )
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex:1,
                          child: SizedBox(
                            height: 44,
                            child: Center(
                              child: ElevatedButton(
                                style: elevatedButtonStyle(context),
                                onPressed: () async{
                                  await save(context);
                                },
                                child:  Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


            ],
          );
        },
      ),
    );
  }
  save(BuildContext context) async{
   if(cFirstName.text.isNotEmpty && cLastName.text.isNotEmpty && cEmail.text.isNotEmpty && cPhoneNumber.text.isNotEmpty && address.text.isNotEmpty
   && zipCode.text.isNotEmpty && city.text.isNotEmpty && state.text.isNotEmpty && country.text.isNotEmpty && county.text.isNotEmpty){
     var cPhone = formatPhoneNumber(cPhoneNumber.text, countryCode);
     var sPhone = formatPhoneNumber(sPhoneNumber.text, countryCode);
     var cPhone2 =countryIsoCode  + '#' + countryCode + "#" + countryNumber;
     var sPhone2 =scountryIsoCode  + '#' + scountryCode + "#" + scountryNumber;
     post = Draw(date: DateFormat('yyyy-MM-dd').format(DateTime.now()),code: "New Entry",
         cname: cFirstName.text,cfirstname: cFirstName.text,clastname: cLastName.text,cemail: cEmail.text.toLowerCase(),
         cphone: cPhone,cphone2: cPhone2, sname: sFirstName.text,sfirstname: sFirstName.text,slastname: sLastName.text,
         semail: sEmail.text.toLowerCase(),sphone:sPhone,sphone2: sPhone2,caddress: address.text,ccity: city.text,
         ccountry: country.text,ccounty: county.text,cstate: state.text,czipcode: zipCode.text);

     UserVM.postDraw(context, post).then((value) {
       if(value !="error"){
         showDrawCodeAlert(context,drawCodeString(value));
       }
     });

   }else{
     snackBarDesign(context, StringUtil.error, "emptyField".tr());
   }
  }
}
