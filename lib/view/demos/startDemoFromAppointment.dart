import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/model/demoModel/postLiveDemo.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/LiveDemoVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../constants/colorsUtil.dart';
import '../../model/appointmentModel/Data.dart';
import '../../utils/res/SharedUtils.dart';
// ignore_for_file: use_build_context_synchronously
class StartDemoAppointment extends StatefulWidget {
  final Data data;
  const StartDemoAppointment(this.data, {super.key});

  @override
  State<StatefulWidget> createState() => _StartDemoAppointmentState();
}

class _StartDemoAppointmentState extends State<StartDemoAppointment> {
  LiveDemoVm viewModel = LiveDemoVm();
  LocationProvider provider = LocationProvider();
  double? latitude;
  double? longitude;
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController cPhoneNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController country = TextEditingController();
  bool arrivedCustomer=false;
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
    // TODO: implement build
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar:  DefaultAppBar(name: "startDemo".tr(),),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<LiveDemoVm>(
            builder: (context,value,_){

                return  SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 8,),
                        accountCreate(context, "cFirstName", firstName),
                        const SizedBox(height: 8,),
                        accountCreate(context, "cLastName", lastName),
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
                  
                          },
                        ),
                        const SizedBox(height: 8,),
                        mailCreate(context,"email",emailController),
                        /*const SizedBox(height: 8,),
                        Container(
                  
                          decoration: containerDecoration(context),
                          width: sizeWidth(context).width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                              underline: const SizedBox(),
                  
                              hint: Text("selectRegion".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                              value: viewModel.region,
                              onChanged: (newValue) {
                                viewModel.setType(newValue!);
                  
                              },
                              items: region.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                  
                                  child: Row(
                                    children: [
                                      Text(value,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),*/
                        const SizedBox(height: 8,),
                        accountCreate(context, "address", address),
                        const SizedBox(height: 8,),
                        accountCreate(context, "zipCode", zipcode),
                        const SizedBox(height: 8,),
                        accountCreate(context, "city", city),
                        const SizedBox(height: 8,),
                        accountCreate(context, "state",  state),
                        const SizedBox(height: 8,),
                        accountCreate(context, "county", county),

                        const SizedBox(height: 8,),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text("arrivedAtCustomer".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          checkColor: AppColors.white,
                          value: arrivedCustomer,
                          onChanged: (check) async{
                            if(zipcode.text.isNotEmpty){
                              await provider.getLocationDetails(context);
                              String zipcodeCheck = provider.locationDetails["zipcode"];

                              if(zipcodeCheck == zipcode.text){
                                value.setArrivedCustomer(check!);
                              }else{
                                value.setArrivedCustomer(false);
                                snackBarDesign(context, StringUtil.error, "wrongZipCode".tr());
                              }
                            }else{
                              snackBarDesign(context, StringUtil.error, "requiredZipCode".tr());
                            }
                          },
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: sizeWidth(context).width*0.80,
                              child: ElevatedButton(
                                style: elevatedButtonStyle(context),
                                onPressed: () async{
                                  await post();

                                },
                                child:  Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              ),
                            ),
                          ],
                        )
                      ],
                  
                    ),
                  ),
                );
              }

          ),
        ),
      ),
    );
  }

  getList() async{

    firstName.text = widget.data.cname ?? "";
    lastName.text = widget.data.clastname ?? "";
    cPhoneNumber.text = getRightSideOfPhoneNumber(widget.data.cphone ?? "");
    emailController.text = widget.data.cemail ?? "";
    address.text = widget.data.caddress ?? "";
    county.text = widget.data.ccounty ?? "";
    country.text = widget.data.ccountry ?? "";
    state.text = widget.data.cstate ?? "";
    city.text = widget.data.ccity ?? "";
    zipcode.text = widget.data.czipcode ?? "";
  }
  post() async{
    SharedPref pref = SharedPref();
    int orgId = await pref.getInt(context, SharedUtils.orgId);
    bool check = isEmail(emailController.text);
    String cDialCode = viewModel.cCountryCode ?? "1";
    String cLastPhone = cPhoneNumber.text;
    String phone = "+$cDialCode-$cLastPhone";
    if(latitude == null || longitude == null){
      await provider.getLocationDetails(context);
      latitude = provider.locationDetails["latitude"];
      longitude = provider.locationDetails["longitude"];
    }
    if (firstName.text.isNotEmpty && lastName.text.isNotEmpty && cPhoneNumber.text.isNotEmpty
        && phone.isNotEmpty && address.text.isNotEmpty && state.text.isNotEmpty && zipcode.text.isNotEmpty
        && city.text.isNotEmpty && arrivedCustomer==true) {
      PostLiveDemo postLiveDemo = PostLiveDemo(
          organisationId: orgId,
          demoCustomerName: firstName.text,
          demoCustomerSurname: lastName.text,
          demoCustomerPhone: phone,
          demoCustomerEmail: emailController.text,
          demoAddress: address.text,
          demoRegion: viewModel.region,
          longitude: longitude,
          latitude: latitude,
          demoCity: city.text,
          demoZipcode: zipcode.text,
          demoCounty: county.text,
          demoState: state.text,
          demoCountry: country.text
      );
      await viewModel.postStartDemo(context, postLiveDemo);

    }else{
      if(!check){
        snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
      }
      snackBarDesign(context, StringUtil.error, "required".tr());
    }
  }
}
