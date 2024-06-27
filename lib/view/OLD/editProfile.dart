import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/distType/Type.dart';
import 'package:wizzsales/utils/function/helper/PhotoHelper.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WizzTextField.dart';
import 'package:wizzsales/widgets/multiSelect/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:wizzsales/widgets/multiSelect/util/multi_select_item.dart';
import 'package:wizzsales/widgets/multiSelect/util/multi_select_list_type.dart';
import '../../utils/function/helper/DatepickerHelper.dart';
import '../../utils/style/CustomTextStyle.dart';
import '../../widgets/WidgetExtension.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Map<String, dynamic> photoMap = {};
  File? selectedImage;
  TextEditingController dateInput = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController address = TextEditingController();
  String countryCode = "US";
  bool hidePass = false;
  String imageUrl = "";
  User? user;
  List<MultiSelectItem>? _items = [];
  List<Types>? _selectedRoles = [];
  List<Types> roleList = [
    //Types(id: 5, name: AppLocalizations.translate("distributor")),
    Types(id: 8, name: "Sales Manager"),
    Types(id: 7, name: "DPS"),
    Types(id: 2, name: "Team Leader"),
    Types(id: 3, name: "Dealer"),
    Types(id: 6, name: "DA")
  ];

  @override
  void dispose() {
    deactivate();
    super.dispose();
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(name: "Edit Profile",),
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height,
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      SizedBox(
                          width: sizeWidth(context).width * 0.25,
                          height: sizeWidth(context).height * 0.12,
                          child:selectedImage != null ?
                          ClipOval(
                              child: Image.file(
                                selectedImage!, fit: BoxFit.fill, height: 96,)
                          ) : imageUrl.isNotEmpty ? ClipOval(
                            child: SizedBox.fromSize(
                                size: const Size.fromRadius(32),
                                // Image radius
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.gif',
                                  image: imageUrl,
                                  fit: BoxFit.cover,
                                )),
                          ) :  ClipOval(
                              child: Image.asset(
                                "assets/uploadPhoto.webp", height: 64,)
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
                              selectedImage = photoMap["image"];
                            });
                          }
                        },
                        icon: Icon(Icons.photo_camera, size: 24.0,
                          color: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),),
                        label: Text("updatePicture".tr(),
                          style: CustomTextStyle().semiBold16(
                              ColorUtil().getColor(context,
                                  ColorEnums.textDefaultLight)),), // <-- Text
                      ),
                      const SizedBox(height: 16,),
                      Visibility(
                          visible: selectedImage == null ? false : true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    await PhotoHelper.deletePhoto(
                                        context, selectedImage);
                                    setState(() {
                                      selectedImage = null;
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
                      const SizedBox(height: 8,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("birthDay".tr(),
                            style: CustomTextStyle().semiBold12(
                                ColorUtil().getColor(
                                    context, ColorEnums.textDefaultLight)),)),
                      const SizedBox(
                        height: 4,
                      ),
                      TextField(
                        style: CustomTextStyle().semiBold12(
                            ColorUtil().getColor(
                                context, ColorEnums.textTitleLight)),
                        cursorColor: ColorUtil().getColor(
                            context, ColorEnums.wizzColor),
                        decoration: dateInputDecoration(
                            context, "selectBirthday"),
                        controller: dateInput,
                        readOnly: true,
                        onTap: () async {
                          dateInput.text =
                          await DatePickerHelper.getDatePicker(context);
                        },
                      ),
                      const SizedBox(height: 8,),
                      mailCreate(context, "email", emailController),
                      const SizedBox(height: 8,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("password".tr(),
                            style: CustomTextStyle().semiBold12(
                                ColorUtil().getColor(
                                    context, ColorEnums.textDefaultLight)),),
                          const SizedBox(height: 4,),
                          WizzTextField(
                              hint: "password",
                              textEditingController: passwordController,
                              hintTextColor: ColorEnums.textDefaultLight,
                              hintTextSize: 14,
                              textColor: ColorEnums.textDefaultLight,
                              isObsecure: hidePass,
                              isObsecureClicked: () {
                                setState(() {
                                  hidePass = !hidePass;
                                });
                              }
                          ),
                          const SizedBox(height: 8,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("phone".tr(),
                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                          ),
                          const SizedBox(height: 4,),
                          IntlPhoneField(
                            decoration: phoneDecoration(context),
                            flagsButtonMargin: const EdgeInsets.only(left: 20),
                            disableLengthCheck: true,
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            dropdownTextStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [maskFormatter],
                            showCountryFlag: true,
                            cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            controller: phoneNumber,
                            initialCountryCode: countryCode,
                            showDropdownIcon: true,
                            dropdownIconPosition: IconPosition.trailing,
                            onChanged: (change) {
                              setState(() {
                                countryCode = change.countryCode;
                              });
                            },
                            onCountryChanged: (value) {
                              setState(() {
                                countryCode = value.dialCode;
                              });
                            },

                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Container(
                        decoration: containerDecoration(context),
                        child: MultiSelectBottomSheetField(
                          backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                          initialChildSize: 0.4,
                          listType: MultiSelectListType.chip,
                          searchable: false,
                          initialValue: _selectedRoles,
                          buttonText: Text("rolesOrganisation".tr(),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          title: Column(
                            children: [
                              Text("rolesOrganisation".tr(),
                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(height: 10,),
                            ],
                          ),
                          selectedItemsTextStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                          itemsTextStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                          items: _items,
                          onConfirm: (values) {
                            _selectedRoles = List<Types>.from(values);
                          },
                          selectedItem: (value) {},
                          onSelectionChanged: (values) {},

                        ),
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
                      Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ChangeNotifierProvider<LocationProvider>(
                                  create: (_) => LocationProvider(),
                                  child: Consumer<LocationProvider>(
                                    builder: (context, value, _) {
                                      return ElevatedButton(
                                        style: elevatedButtonStyle(context),
                                        onPressed: () async {
                                          await value.getLocationDetails(context);
                                          zipcode.text = value.locationDetails["zipcode"] ?? "";
                                          country.text = value.locationDetails["country"] ?? "";
                                          county.text = value.locationDetails["county"] ?? "";
                                          state.text = value.locationDetails["state"] ?? "";
                                          city.text = value.locationDetails["city"] ?? "";
                                          address.text = value.locationDetails["street"] ?? "";
                                        },
                                        child: Text("fillFromLocation".tr(),
                                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: sizeWidth(context).width * 0.40,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await save(context);
                                    },
                                    style: elevatedButtonStyle(context),
                                    child: Text("save".tr(),
                                      style: CustomTextStyle().semiBold12(
                                          ColorUtil().getColor(context,
                                              ColorEnums.textTitleLight)),),
                                  ),
                                ),
                              ]
                          )
                      ),

                    ]
                ),
              )
          )
      ),
    );
  }

  getInfo() async {
    user = await getUserUser(context);


    if (user != null) {
      if (_items!.isEmpty) {
        _items =
            roleList.map((mod) => MultiSelectItem<Types>(mod, mod.name!))
                .toList();
      }
      if (user!.role2 != null && user!.role2!.isNotEmpty) {
        for (var element in user!.role2!) {
          print("gelen roller :$element");
          for (var elements in roleList) {
            if (elements.name == element.tr()) {
              _selectedRoles!.add(elements);
            }
          }
        }
      }
      List<String> roleList2 = [];
      for (var element in _selectedRoles!) {
        roleList2.add(element.id.toString());
      }


      dateInput.text = mmDDYDate(user!.birthday!.toString());
      emailController.text = user!.email!.toLowerCase();
      address.text = user!.address!.toString();
      city.text = user!.city!.toString();
      state.text = user!.state.toString();
      zipcode.text = user!.zipcode!.toString();
      county.text = user!.county ?? "";
      country.text = user!.country.toString();
      phoneNumber.text = extractPhoneNumber(user!.phone ?? "");


      setState(() {
        imageUrl = user!.image ?? "";
      });

      print("image :$imageUrl");
    }
  }

  save(BuildContext context) async {
    List<String> roleList = [];
    for (var element in _selectedRoles!) {
      roleList.add(element.id.toString());
    }
    String roles = roleList.join(', ');
    print("seçilen rol :$roles");

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty) {
      UserVM.updateUser(
          context, user!, passwordController.text, passwordController.text,
          roles, selectedImage)
          .then((String value) {
        if (value == "OK") {
          snackBarDesign(context, StringUtil.success, "updateInfo".tr());
          Navigator.pushNamed(context, '/${PageName.mainHome}');
        }
      });
    } else {
      snackBarDesign(
          context, StringUtil.error, "personalInfoMustRequired".tr());
    }
  }
}
