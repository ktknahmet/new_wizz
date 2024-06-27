import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/contactReferral/postReferral.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/providerFunc/ContactProvider.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AddContact extends BaseStatefulPage {
  const AddContact(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AddContactState();
}

class _AddContactState extends BaseStatefulPageState<AddContact> {
  ContactProvider viewModel = ContactProvider();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget design() {

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ContactProvider>(
        builder: (context,value,_){
          return Column(
            children: [
              accountCreate(context, "firstName", firstNameController),
              const SizedBox(height: 8,),
              accountCreate(context, "lastName", lastNameController),
              const SizedBox(height: 8,),
              mailCreate(context, "email", emailController),
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
                controller: phoneNumberController,
                initialCountryCode:viewModel.countryCode,
                showDropdownIcon: true,
                dropdownIconPosition: IconPosition.trailing,

                onCountryChanged: (value){
                  viewModel.changeCode(value.dialCode);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: elevatedButtonStyle(context),
                          onPressed: () {
                            Navigator.pop(context);

                          },
                          child:  Text("back".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        ),
                        ElevatedButton(
                          style: elevatedButtonStyle(context),
                          onPressed: () async{
                            await post();
                          },
                          child:  Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
  post() async{
    if(firstNameController.text.isNotEmpty && phoneNumberController.text.isNotEmpty && lastNameController.text.isNotEmpty){
      if(emailController.text.isNotEmpty){
        bool checkEmail = isEmail(emailController.text.toLowerCase());
        if(checkEmail){
          String phone = phoneNumberController.text.replaceAll("-", "");
          String lastPhone = "+${viewModel.countryCode}-$phone";

          List<PostReferral> customer =[];
          PostReferral postReferral = PostReferral(firstname: firstNameController.text,lastname: lastNameController.text,email: emailController.text.toLowerCase(),phone: lastPhone);
          customer.add(postReferral);

          String data = postReferralToJson(customer);
          print("gönderilen data :$data");
          await UserVM.postReferral(context, data).then((value) => {
            debugPrint("veriler :$value"),
            if(value=="OKEY"){
              customer.clear(),
              firstNameController.clear(),
              lastNameController.clear(),
              emailController.clear(),
              phoneNumberController.clear(),
            }
          });
        }else{
          snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
        }
      }else{
        String phone = phoneNumberController.text.replaceAll("-", "");
        String lastPhone = "+${viewModel.countryCode}-$phone";

        List<PostReferral> customer =[];
        PostReferral postReferral = PostReferral(firstname: firstNameController.text,lastname: lastNameController.text,email: emailController.text.toLowerCase(),phone: lastPhone);
        customer.add(postReferral);

        String data = postReferralToJson(customer);
        print("gönderilen data :$data");
        await UserVM.postReferral(context, data).then((value) => {
          if(value=="OKEY"){
            customer.clear(),
            firstNameController.clear(),
            lastNameController.clear(),
            emailController.clear(),
            phoneNumberController.clear(),
          }
        });
      }
    }else{
     snackBarDesign(context, StringUtil.warning, "required".tr());
    }
  }
}
