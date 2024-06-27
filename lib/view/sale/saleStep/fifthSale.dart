import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../../utils/style/CustomTextStyle.dart';

class FifthSale extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? step;
  final String? totalStepCount;
  const FifthSale({super.key, required this.continueClick,this.previousClick,this.step, this.totalStepCount});

  @override
  State<FifthSale> createState() => _FifthSaleState();
}

class _FifthSaleState extends State<FifthSale> {

  TextEditingController county = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    address.text = SaleVM.addSaleModel.caddress ?? "";
    city.text = SaleVM.addSaleModel.ccity ?? "";
    zipcode.text = SaleVM.addSaleModel.czipcode ?? "";
    county.text = SaleVM.addSaleModel.ccounty ?? "";
    state.text = SaleVM.addSaleModel.cstate ?? "";
    super.initState();

  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeWidth(context).height,
      child: Column(
        children: [
          Text("addressInformation".tr(),style: CustomTextStyle().black20(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
          Text("fillInformation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("${"step".tr()} 5/${widget.totalStepCount!}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
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
          ChangeNotifierProvider<LocationProvider>(
            create: (_)=>LocationProvider(),
            child: Consumer<LocationProvider>(
              builder: (context,value,_){

                return ElevatedButton(
                  style: elevatedButtonStyle(context),
                  onPressed: () async{
                    await value.getLocationDetails(context);
                    zipcode.text = value.locationDetails["zipcode"] ?? "";
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
           Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        widget.previousClick!();
                      },
                      style: elevatedButtonStyle(context),
                      child: Text("previous".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        nextPage();
                      },
                      style: elevatedButtonStyle(context),
                      child: Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    )
                  ],
                ),

          ),
        ],
      ),
    );
  }
  nextPage(){
    if(address.text.isNotEmpty && zipcode.text.isNotEmpty && city.text.isNotEmpty && state.text.isNotEmpty){
      SaleVM.addSaleModel.caddress = address.text;
      SaleVM.addSaleModel.ccity = city.text;
      SaleVM.addSaleModel.czipcode = zipcode.text;
      SaleVM.addSaleModel.ccounty = county.text;
      SaleVM.addSaleModel.cstate = state.text;
      widget.continueClick!();
    }else{
      snackBarDesign(context, StringUtil.warning, "addressRequired".tr());
    }
  }
}
