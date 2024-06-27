import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AddressInfoStep extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? totalStepCount;
  final String? step;
  const AddressInfoStep({super.key, required this.continueClick, this.previousClick, this.step, this.totalStepCount});

  @override
  State<AddressInfoStep> createState() => _AddressInfoStepState();
}

class _AddressInfoStepState extends State<AddressInfoStep> {
  TextEditingController county = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController address = TextEditingController();
  
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      setState(() {
        address.text = SaleVM.addLeadsModel.caddress ?? "";
        city.text = SaleVM.addLeadsModel.ccity ?? "";
        zipcode.text = SaleVM.addLeadsModel.czipcode ?? "";
        county.text = SaleVM.addLeadsModel.ccounty ?? "";
        state.text = SaleVM.addLeadsModel.cstate ?? "";
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
            Text("addressInfo".tr(),style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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

            accountCreate(context,"address",address),
            const SizedBox(height: 8,),
            accountCreate(context,"zipCode",zipcode),
            const SizedBox(height: 8,),
            accountCreate(context,"city",city),
            const SizedBox(height: 8,),
            accountCreate(context,"state",state),
            const SizedBox(height: 8,),
            accountCreate(context,"county",county),

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
                      address.text = value.locationDetails["street"] ?? "";
                      county.text = value.locationDetails["county"] ?? "";
                      state.text = value.locationDetails["state"] ?? "";
                      city.text = value.locationDetails["city"] ?? "";
                    },
                    child:  Text("fillFromLocation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  );
                },
              ),
            ),
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
                                      widget.previousClick!();
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
                                onPressed: ()async {
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
    if(address.text.isNotEmpty  && state.text.isNotEmpty && city.text.isNotEmpty && zipcode.text.isNotEmpty){
      SaleVM.addLeadsModel.caddress = address.text;
      SaleVM.addLeadsModel.ccity = city.text;
      SaleVM.addLeadsModel.czipcode = zipcode.text;
      SaleVM.addLeadsModel.ccounty = county.text;
      SaleVM.addLeadsModel.cstate = state.text;
      SaleVM.addLeadsModel.ccounty = county.text;
      widget.continueClick!();
    }else{
      snackBarDesign(context, StringUtil.error, "personalInfoMustRequired".tr());
    }

  }
}
