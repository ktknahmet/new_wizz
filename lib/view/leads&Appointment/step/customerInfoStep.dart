import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class CustomerInfoStep extends StatefulWidget {
  final VoidCallback? continueClick;
  final String? step;
  final String? totalStepCount;

  const CustomerInfoStep({super.key, required this.continueClick, this.step, this.totalStepCount});

  @override
  State<CustomerInfoStep> createState() => _CustomerInfoStepState();
}

class _CustomerInfoStepState extends State<CustomerInfoStep> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController sEmailController = TextEditingController();
  TextEditingController sFirstNameController = TextEditingController();
  TextEditingController sLastNameController = TextEditingController();
  TextEditingController sPhoneNumber = TextEditingController();
  String sCountryCode="US";
  String countryCode="US";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (SaleVM.addLeadsModel.cfirstname != null) {
          firstNameController.text = SaleVM.addLeadsModel.cfirstname!;

        }
        if (SaleVM.addLeadsModel.clastname != null) {
          lastNameController.text = SaleVM.addLeadsModel.clastname!;

        }
        if (SaleVM.addLeadsModel.cemail != null) {
          emailController.text = SaleVM.addLeadsModel.cemail!;

        }
        if(SaleVM.addLeadsModel.cphone !=null){
          countryCode = SaleVM.addLeadsModel.cCountyCode!;
          print("ülke kodu geliyor : $countryCode");
          phoneNumber.text = SaleVM.addLeadsModel.cphone!;

        }

        if (SaleVM.addLeadsModel.sfirstname != null && SaleVM.addLeadsModel.sfirstname!.isNotEmpty) {

          sFirstNameController.text = SaleVM.addLeadsModel.sfirstname!;
        }
        if (SaleVM.addLeadsModel.slastname != null && SaleVM.addLeadsModel.slastname!.isNotEmpty) {

          sLastNameController.text = SaleVM.addLeadsModel.slastname!;
        }
        if (SaleVM.addLeadsModel.semail != null && SaleVM.addLeadsModel.semail!.isNotEmpty) {

          sEmailController.text = SaleVM.addLeadsModel.semail!;
        }
        if (SaleVM.addLeadsModel.sphone != null && SaleVM.addLeadsModel.sphone!.isNotEmpty) {

          int length = SaleVM.addLeadsModel.sphone!.length;
          String telefon = SaleVM.addLeadsModel.sphone!;
          telefon = telefon.substring(2,length);
          phoneNumber.text = telefon;
          sPhoneNumber.text = telefon;
        }
        var leadid = SaleVM.addLeadsModel.leadid;
        print("leadid :$leadid");

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [
            Text("customerInfo".tr(),style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("fillInfo".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("${context.tr("step")} ${widget.step}/${widget.totalStepCount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ),

            const SizedBox(height: 20,),
            accountCreate(context,"firstName",firstNameController),
            const SizedBox(height: 8,),
            accountCreate(context,"lastName",lastNameController),

            const SizedBox(height: 8,),
            mailCreate(context,"email",emailController),
            const SizedBox(height: 8,),
            Align(
                alignment: Alignment.centerLeft,
                child:Text("phone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
              controller: phoneNumber,
              initialCountryCode:countryCode,
              showDropdownIcon: true,
              dropdownIconPosition: IconPosition.trailing,
              onChanged: (change){
                setState(() {
                  SaleVM.addLeadsModel.cCountyCode = change.countryISOCode;
                  SaleVM.addLeadsModel.cCdode = change.countryCode;

                });
              },
              onCountryChanged: (value){
                setState(() {
                  countryCode = value.dialCode;
                });

              },
            ),
            const SizedBox(height: 8,),
            accountCreate(context,"sFirstName",sFirstNameController),
            const SizedBox(height: 8,),
            accountCreate(context,"sLastName",sLastNameController),

            const SizedBox(height: 8,),
            mailCreate(context,"sEmail",sEmailController),
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
              initialCountryCode:sCountryCode,
              showDropdownIcon: true,
              dropdownIconPosition: IconPosition.trailing,

              onCountryChanged: (value){
                setState(() {
                  sCountryCode = value.dialCode;
                });

              },
            ),
            const SizedBox(height: 8,),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child:  Padding(
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
                                child: ElevatedButton(
                                  style: elevatedButtonStyle(context),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child:  Text("previous".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                ),
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
                                  await check();

                                },
                                child:  Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  check() async{
    bool checkMail = isEmail(emailController.text);
    if(firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && phoneNumber.text.isNotEmpty && emailController.text.isNotEmpty){
      if(checkMail){
        SaleVM.addLeadsModel.cfirstname = firstNameController.text;
        SaleVM.addLeadsModel.clastname = lastNameController.text;
        SaleVM.addLeadsModel.cemail = emailController.text;


        //SaleVM.addLeadsModel.cCountyCode = customerPhoneNumber;
        SaleVM.addLeadsModel.cphone =phoneNumber.text.toString();


        if (sFirstNameController.text.isNotEmpty) {
          SaleVM.addLeadsModel.sfirstname = sFirstNameController.text;
        }
        if (sLastNameController.text.isNotEmpty) {
          SaleVM.addLeadsModel.slastname = sLastNameController.text;
        }
        if (sEmailController.text.isNotEmpty) {
          SaleVM.addLeadsModel.semail = sEmailController.text;
        }
        if (sPhoneNumber.text.isNotEmpty) {
          SaleVM.addLeadsModel.sphone =  sPhoneNumber.text.toString();

        }
        widget.continueClick!();
      } else{
        snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
      }

    }else{
      snackBarDesign(context,StringUtil.error,"personalInfoMustRequired".tr());
    }

    }

}
