import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseList.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseUpdate.dart';
import 'package:wizzsales/adminPage/adminVm/warehouseVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class UpdateWarehouse extends StatefulWidget {
  final WarehouseList warehouseList;
  const UpdateWarehouse(this.warehouseList,{super.key});

  @override
  State<UpdateWarehouse> createState() => _UpdateWarehouseState();
}

class _UpdateWarehouseState extends State<UpdateWarehouse> {
  WarehouseVm viewModel = WarehouseVm();
  TextEditingController warehouseName = TextEditingController();
  TextEditingController warehouseEmail = TextEditingController();
  TextEditingController warehousePhone = TextEditingController();
  TextEditingController warehouseSpocName = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController address = TextEditingController();

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
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: DefaultAppBar(name: "updateWarehouse".tr(),),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<WarehouseVm>(
            builder: (context,value,_){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                          child:  Text("update".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        ),
                      ),
                      ],
                     ),
                   ]
                 ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getList()async{
    warehouseName.text = widget.warehouseList.warehouseName ?? "";
    warehouseSpocName.text = widget.warehouseList.warehouseSpocname ?? "";
    warehouseEmail.text = widget.warehouseList.warehouseEmail ?? "";
    city.text = widget.warehouseList.warehouseCity ?? "";
    zipcode.text = widget.warehouseList.warehouseZipcode ?? "";
    address.text = widget.warehouseList.warehouseAdress ?? "";
    state.text = widget.warehouseList.warehouseState ?? "";
    warehousePhone.text = extractPhoneNumber(widget.warehouseList.warehousePhone ?? "");
  }
  post()async{

    if(warehouseName.text.isEmpty || warehouseEmail.text.isEmpty || warehouseSpocName.text.isEmpty || address.text.isEmpty
        || zipcode.text.isEmpty || city.text.isEmpty || state.text.isEmpty || warehousePhone.text.length !=10){
      snackBarDesign(context, StringUtil.error, "personalInfoMustRequired".tr());
    }else{
      bool mail = isEmail(warehouseEmail.text.toString());
      if(mail){
        String phone = "+${viewModel.cCountryCode ?? "1"}-${warehousePhone.text}";
        WarehouseUpdate update = WarehouseUpdate(
            warehouseId: widget.warehouseList.warehouseId,
            warehouseName: warehouseName.text,
            warehouseAdress:address.text,
            warehouseCity: city.text,
            warehouseState: state.text,
            warehouseZipcode: zipcode.text,
            warehouseSpocName: warehouseSpocName.text,
            warehouseEmail: warehouseEmail.text,
            warehousePhone: phone
        );
        await viewModel.updateWarehouse(context, update);
      }else{
        snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
      }
    }
  }
}
