import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/model/OLD/Draw.dart';
import 'package:wizzsales/model/demoModel/postLiveDemo.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/LiveDemoVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../constants/colorsUtil.dart';
import '../../utils/res/SharedUtils.dart';
// ignore_for_file: use_build_context_synchronously
class StartDemo extends BaseStatefulPage {
  const StartDemo(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _StartDemoState();
}

class _StartDemoState extends BaseStatefulPageState<StartDemo> {
  LiveDemoVm viewModel = LiveDemoVm();
  LocationProvider provider = LocationProvider();
  ScrollController controller = ScrollController();
  double? latitude;
  double? longitude;
  bool? checkZipcode;
  @override
  void initState() {
    getList();
    super.initState();
  }


  @override
  Widget design() {
    // TODO: implement design
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<LiveDemoVm>(
        builder: (context,value,_){
         if(viewModel.leadList == null){
           return spinKit(context);
         }else{
           return SingleChildScrollView(
             child: Column(
               children: [
                 if(viewModel.leadList!.isNotEmpty)
                   Column(
                     children: [
                       Align(
                           alignment: Alignment.centerLeft,
                           child: Text("selectAppointment".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                       ),
                       const SizedBox(height: 4,),
                       TextField(
                         style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                         cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                         decoration: dateInputDecoration(context,"selectAppointment"),
                         controller: viewModel.appointment,
                         readOnly: true,
                         onTap: (){
                           selectDemo(context,viewModel);
                         },

                       ),
                     ],
                   ),
                 if(viewModel.demoQuery.isNotEmpty && viewModel.leadList!.isNotEmpty)
                   SizedBox(
                     height: sizeWidth(context).height*0.40,
                     child: RawScrollbar(
                       thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                       thumbVisibility: true,
                       thickness: 1,
                       trackVisibility: true,
                       controller: controller,
                       child: ListView.builder(
                         controller: controller,
                         itemCount:  viewModel.searchAppointment(viewModel.leadList!,viewModel.demoQuery).length,
                         itemBuilder: (context,index){
                           Draw model =viewModel.searchAppointment(viewModel.leadList!,viewModel.demoQuery)[index];
                           return Padding(
                             padding: const EdgeInsets.all(4.0),
                             child: GestureDetector(
                               onTap: ()async{
                                 List<String> numaraParcalari = model.cphone!.split("-");
                                 String phone = numaraParcalari.length > 1 ? numaraParcalari[1] : "";
                                 viewModel.setInformation(
                                     model.ccity ?? "",model.czipcode ?? "",model.cstate ?? "",
                                     model.ccounty ?? "",model.cfirstname ?? "",model.clastname ?? "",phone,model.cemail ?? "",
                                     model.caddress ?? "",model.code);
                                 viewModel.setDemoQuery("");
                               },
                               child: Card(
                                   shape: cardShape(context),
                                   color: ColorUtil().getColor(context, ColorEnums.background),
                                   elevation: 2,
                                   child: Padding(
                                     padding: const EdgeInsets.all(4.0),
                                     child: Row(
                                       children: [
                                         Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                         const SizedBox(width: 4,),
                                         Expanded(
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text(model.cname ?? "",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                               const SizedBox(height: 4,),
                                               Text(model.cphone ?? "",style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                               const SizedBox(height: 4,),
                                               Text(model.cemail ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                             ],
                                           ),
                                         ),

                                       ],
                                     ),
                                   )
                               ),
                             ),
                           );
                         },
                       ),
                     ),
                   ),
                 const SizedBox(height: 8,),
                 Align(
                     alignment: Alignment.centerLeft,
                     child: Text("cFirstName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                 ),
                 const SizedBox(height: 4,),
                 TextField(
                   style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                   cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                   decoration: dateInputDecoration(context,"cFirstName"),
                   controller: viewModel.firstName,
                   onChanged: (value){
                     viewModel.setDemoQuery(value);
                     //selectDemo(context,viewModel);
                   },

                 ),
                 const SizedBox(height: 8,),
                 accountCreate(context, "cLastName", viewModel.lastName),
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
                   controller: viewModel.cPhoneNumber,
                   initialCountryCode:viewModel.cCountryCode ?? "US",
                   showDropdownIcon: true,
                   dropdownIconPosition: IconPosition.trailing,
                   onCountryChanged: (code){
                     viewModel.changeCode(code.dialCode);

                   },
                 ),
                 const SizedBox(height: 8,),
                 mailCreate(context, "email", viewModel.emailController),
                 const SizedBox(height: 8,),
                 accountCreate(context, "address", viewModel.address),
                 const SizedBox(height: 8,),
                 accountCreate(context, "zipCode",  viewModel.zipcode),
                 const SizedBox(height: 8,),
                 accountCreate(context, "city",  viewModel.city),
                 const SizedBox(height: 8,),
                 accountCreate(context, "state",  viewModel.state),
                 const SizedBox(height: 8,),
                 accountCreate(context, "county", viewModel.county),

                 const SizedBox(height: 8,),
                     CheckboxListTile(
                       controlAffinity: ListTileControlAffinity.leading,
                       title: Text("arrivedAtCustomer".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                         activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                         checkColor: AppColors.white,
                         value: viewModel.arrivedCustomer,
                         onChanged: (check) async{
                               if(viewModel.zipcode.text.isNotEmpty){
                                 await provider.getLocationDetails(context);
                                 String zipcodeCheck = provider.locationDetails["zipcode"];
                                 print("ahmet :$zipcodeCheck -- ${viewModel.zipcode.text}");
                                 if(zipcodeCheck == viewModel.zipcode.text){
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
                 Padding(
                   padding: const EdgeInsets.only(bottom: 8),
                   child: Row(
                     mainAxisAlignment: viewModel.appointment.text.isNotEmpty ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                     children: [
                       Visibility(
                         visible: viewModel.appointment.text.isEmpty ? true : false,
                         child: ChangeNotifierProvider<LocationProvider>(
                           create: (_)=>LocationProvider(),
                           child: Consumer<LocationProvider>(
                             builder: (context,value,_){
                               return ElevatedButton(
                                 style: elevatedButtonStyle(context),
                                 onPressed: () async{
                                   await value.getLocationDetails(context);
                                   latitude = value.locationDetails["latitude"];
                                   longitude = value.locationDetails["longitude"];
                                   viewModel.address.text = value.locationDetails["street"];
                                   viewModel.county.text = value.locationDetails["county"];
                                   viewModel.country.text = value.locationDetails["country"];
                                   viewModel.city.text = value.locationDetails["city"];
                                   viewModel.state.text = value.locationDetails["state"];
                                   viewModel.zipcode.text = value.locationDetails["zipcode"];

                                 },
                                 child:  Text("fillFromLocation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                               );
                             },
                           ),
                         ),
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
                 )
               ],
             ),
           );
         }
        },
      ),
    );
  }
  getList() async{
    await viewModel.getLeadList(context);
  }
  post() async {

      SharedPref pref = SharedPref();
      int orgId = await pref.getInt(context, SharedUtils.orgId);
      bool check = isEmail(viewModel.emailController.text);
      String cDialCode = viewModel.cCountryCode ?? "1";
      String cLastPhone = viewModel.cPhoneNumber.text;
      String phone = "";

      if(cLastPhone.length !=10){
        phone ="";
      }else{
        phone ="+$cDialCode-$cLastPhone";
      }

        await provider.getLocationDetails(context);
        latitude = provider.locationDetails["latitude"];
        longitude = provider.locationDetails["longitude"];


          if (viewModel.firstName.text.isNotEmpty
              && viewModel.address.text.isNotEmpty
              && viewModel.state.text.isNotEmpty && viewModel.zipcode.text.isNotEmpty
              && viewModel.city.text.isNotEmpty && viewModel.arrivedCustomer==true) {


                PostLiveDemo postLiveDemo = PostLiveDemo(
                    organisationId: orgId,
                    demoCustomerName: viewModel.firstName.text,
                    demoCustomerSurname: viewModel.lastName.text.isNotEmpty ? viewModel.lastName.text : "",
                    demoCustomerPhone: phone,
                    demoCustomerEmail: viewModel.emailController.text.isNotEmpty ? viewModel.emailController.text.toLowerCase() : "",
                    demoAddress: viewModel.address.text,
                    demoRegion: viewModel.region,
                    longitude: longitude,
                    latitude: latitude,
                    leadCode: viewModel.leadCode,
                    demoCity: viewModel.city.text,
                    demoZipcode: viewModel.zipcode.text,
                    demoCounty: viewModel.county.text,
                    demoState: viewModel.state.text,
                    demoCountry: viewModel.country.text
                );
                await viewModel.postStartDemo(context, postLiveDemo);

          } else {
            if (!check) {
              snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
            }
            snackBarDesign(context, StringUtil.error, "required".tr());
          }


  }
  }

