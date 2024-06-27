import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehousePost.dart';
import 'package:wizzsales/adminPage/adminVm/warehouseVm.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../../constants/colorsUtil.dart';

class AddWarehouse extends BaseStatefulPage {
  const AddWarehouse(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AddWarehouseState();
}

class _AddWarehouseState extends BaseStatefulPageState<AddWarehouse> {
  TextEditingController warehouseName = TextEditingController();
  TextEditingController warehouseEmail = TextEditingController();
  TextEditingController warehousePhone = TextEditingController();
  TextEditingController warehouseSpocName = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController address = TextEditingController();
  WarehouseVm viewModel = WarehouseVm();


  SharedPref pref = SharedPref();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<WarehouseVm>(
        builder: (context,value,_){
          if(viewModel.loginUser == null || viewModel.user ==null){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  if(viewModel.user!.roleType =="SUPERADMIN")
                    Column(
                      children: [
                        Card(
                          shape: cardShape(context),
                          color: ColorUtil().getColor(context, ColorEnums.background),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                      value: 0,
                                      groupValue: viewModel.type,
                                      onChanged: (value) async{
                                        viewModel.setType(0);
                                        if(viewModel.organisations == null){
                                          await showProgress(context, true);
                                          await getDistList();
                                          await showProgress(context, false);
                                          await selectDistWarehouse(context,viewModel);
                                        }else{
                                         await selectDistWarehouse(context,viewModel);
                                        }


                                      },
                                    ),
                                    Text("distributor".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                      value: 1,
                                      groupValue: viewModel.type,
                                      onChanged: (value) async{
                                        viewModel.setType(1);
                                      },
                                    ),
                                    Text("importer".tr(), style:CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4,),
                        if(viewModel.type ==0)
                          SizedBox(
                            width: sizeWidth(context).width,
                            child: Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("distributor".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),

                                    Text(viewModel.distName ?? "", style:CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),

                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  accountCreate(context, "warehouseName", warehouseName),
                  const SizedBox(height: 8,),
                  mailCreate(context, "warehouseEmail", warehouseEmail),
                  const SizedBox(height: 8,),
                  accountCreate(context, "contact", warehouseSpocName),
                  const SizedBox(height: 8,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child:Text("warehousePhone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                    controller: warehousePhone,
                    initialCountryCode:viewModel.cCountryCode ?? "US",
                    showDropdownIcon: true,
                    dropdownIconPosition: IconPosition.trailing,
                    onCountryChanged: (code){
                      viewModel.changeCode(code.dialCode);
                    },
                  ),
                  const SizedBox(height: 8,),
                  accountCreate(context, "address", address),
                  const SizedBox(height: 8,),
                  accountCreate(context, "zipCode", zipcode),
                  const SizedBox(height: 8,),
                  accountCreate(context, "city", city),
                  const SizedBox(height: 8,),
                  accountCreate(context, "state", state),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChangeNotifierProvider<LocationProvider>(
                        create: (_)=>LocationProvider(),
                        child: Consumer<LocationProvider>(
                          builder: (context,value,_){

                            return SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child: ElevatedButton(
                                style: elevatedButtonStyle(context),
                                onPressed: () async{
                                  await value.getLocationDetails(context);
                                  zipcode.text = value.locationDetails["zipcode"] ?? "";
                                  state.text = value.locationDetails["state"] ?? "";
                                  city.text = value.locationDetails["city"] ?? "";
                                  address.text = value.locationDetails["street"] ?? "";

                                },
                                child:  Text("fillFromLocation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: sizeWidth(context).width*0.4,
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
            );
          }
        },
      ),
    );
  }
  getList()async{
    await viewModel.getUserInfo(context);

    if(viewModel.user!.roleType !="SUPERADMIN"){
      viewModel.distId = viewModel.loginUser!.profiles![viewModel.index].organisation_id!;
    }
  }
  getDistList()async{
    await viewModel.getOrganisations(context);
  }
  post()async{

    if(warehouseName.text.isEmpty || warehouseEmail.text.isEmpty || warehouseSpocName.text.isEmpty || address.text.isEmpty
    || zipcode.text.isEmpty || city.text.isEmpty || state.text.isEmpty || warehousePhone.text.length !=10){
      snackBarDesign(context, StringUtil.error, "personalInfoMustRequired".tr());
    }else{
      bool mail = isEmail(warehouseEmail.text.toString());
      if(mail){
        String phone = "+${viewModel.cCountryCode ?? "1"}-${warehousePhone.text}";
        WarehousePost warehousePost = WarehousePost(
          distributorId: viewModel.distId,
          warehouseName: warehouseName.text,
          warehouseAdress:address.text,
          warehouseCity: city.text,
          warehouseState: state.text,
          warehouseZipcode: zipcode.text,
          warehouseSpocName: warehouseSpocName.text,
          warehouseEmail: warehouseEmail.text,
          warehousePhone: phone
        );
        await viewModel.postWarehouse(context, warehousePost);
      }else{
        snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
      }

    }
  }
}
