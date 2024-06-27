import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/OLD/register/RegisterUser.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/function/helper/PhotoHelper.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/viewModel/RegisterVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import 'package:wizzsales/widgets/WizzTextField.dart';
import '../../utils/style/WidgetStyle.dart';

class RegisterView extends BaseStatefulPage {
  const RegisterView(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseStatefulPageState<RegisterView> {
  RegisterVm viewModel = RegisterVm();
  bool passObsecure = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController distributorCodeController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController address = TextEditingController();
  String countryCode="";
  List<String> selectedRoles=[];
  String selectedRolesString="";
  File? selectedImage;
  Map<String,dynamic> photoMap={};


  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<RegisterVm>(
        builder: (context,value,_){
          return SingleChildScrollView(
            child: Column(
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
                mailCreate(context,"email",emailController),
                const SizedBox(height: 8,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("password".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    const SizedBox(height: 4,),
                    WizzTextField(
                        hint: "password",
                        textEditingController: passwordController,
                        hintTextColor: ColorEnums.textDefaultLight,
                        hintTextSize: 14,
                        textColor: ColorEnums.textDefaultLight,
                        isObsecure: viewModel.newPassView,
                        isObsecureClicked: (){
                          viewModel.changeNewPass();
                        }
                    ),
                  ],
                ),
                const SizedBox(height: 8,),
                accountCreate(context, "distributorCode", distributorCodeController),
                const SizedBox(height: 8,),

                SizedBox(
                  height: sizeWidth(context).height * 0.15,
                  child: ListView.builder(
                    itemCount: roleList.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(
                          roleList[index].name!.tr(),
                          style: CustomTextStyle().semiBold12(
                            ColorUtil().getColor(context, ColorEnums.textTitleLight),
                          ),
                        ),
                        value: selectedRoles.contains(roleList[index].id.toString()),
                        checkColor: AppColors.white,
                        activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        onChanged: (value) {
                          setState(() {
                            if (value != null && value) {
                              selectedRoles.add(roleList[index].id.toString());
                            } else {
                              selectedRoles.remove(roleList[index].id.toString());
                            }
                            // Seçilen rollerin id'lerini string'e dönüştür
                            selectedRolesString = selectedRoles.join(', ');

                          });
                        },
                      );
                    },
                  ),
                ),
                accountCreate(context, "firstName", firstNameController),
                const SizedBox(height: 16,),
                accountCreate(context, "lastName", lastNameController),
                const SizedBox(height: 16,),

                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("birthDay".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                const SizedBox(
                  height: 4,
                ),
                TextField(
                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                  cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                  decoration: dateInputDecoration(context,"selectBirthday"),
                  controller: dateInput,
                  readOnly: true,
                  onTap: () async{
                    dateInput.text = await DatePickerHelper.getDatePicker(context);
                  },
                ),
                const SizedBox(height: 16,),
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
                  initialCountryCode:viewModel.cCountryCode ?? "US",
                  showDropdownIcon: true,
                  dropdownIconPosition: IconPosition.trailing,

                  onCountryChanged: (value){
                    viewModel.changeCode(value.dialCode);
                  },
                ),
                const SizedBox(height: 16,),
                accountCreate(context, "address", address),
                const SizedBox(height: 16,),
                accountCreate(context, "county", county),
                const SizedBox(height: 16,),
                accountCreate(context, "zipCode", zipcode),
                const SizedBox(height: 16,),
                accountCreate(context, "city", city),
                const SizedBox(height: 16,),
                accountCreate(context, "state", state),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChangeNotifierProvider<LocationProvider>(
                        create: (_)=>LocationProvider(),
                        child: Consumer<LocationProvider>(
                          builder: (context,value,_){

                            return ElevatedButton(
                              style: elevatedButtonStyle(context),
                              onPressed: () async{
                                await value.getLocationDetails(context);
                                zipcode.text = value.locationDetails["zipcode"] ?? "";
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
                      ),
                      ElevatedButton(
                        style: elevatedButtonStyle(context),
                        onPressed: () async{
                          bool acceptedTerms = await checkTerms(context);

                          if (acceptedTerms) {
                            User user = User(name: "${firstNameController.text.toString()} ${lastNameController.text.toString()}",firstname: firstNameController.text,lastname: lastNameController.text,birthday: dateInput.text,
                              email: emailController.text.toLowerCase(),address: address.text, username: firstNameController.text,
                              city: city.text,zipcode: zipcode.text,phone: formatPhoneNumber(phoneNumber.text,viewModel.cCountryCode), state: state.text,country: country.text, county: county.text,);

                            RegisterUser register = await UserVM.register(
                                context,
                                user,
                                passwordController.text,
                                passwordController.text,
                                selectedRoles.join(', '),
                                distributorCodeController.text,
                                selectedImage);
                            if (register.loginUser != null) {
                              User userDetail = await UserVM.getUserDetail(context);

                              if (userDetail.id != null) {
                                Navigator.pushNamed(context, '/${PageName.loginPage}');
                              }
                            }
                          } else {
                            snackBarDesign(context, StringUtil.error, "pleaseAgreeTerm".tr());
                          }
                        },
                        child:  Text("createAccount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
