import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class UpdateAddress extends BaseStatefulPage {
   const UpdateAddress(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _UpdateAddressState();
}
class _UpdateAddressState extends BaseStatefulPageState<UpdateAddress>{
   TextEditingController country = TextEditingController();
   TextEditingController county = TextEditingController();
   TextEditingController state = TextEditingController();
   TextEditingController city = TextEditingController();
   TextEditingController zipcode = TextEditingController();
   TextEditingController address = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget design(){
    return SingleChildScrollView(
      child: Column(
        children: [
          accountCreate(context,"country",country),
          const SizedBox(height: 8,),
          accountCreate(context,"county",county),

          const SizedBox(height: 8,),
          accountCreate(context,"state",state),
          const SizedBox(height: 8,),
          accountCreate(context,"city",city),
          const SizedBox(height: 8,),
          accountCreate(context,"zipCode",zipcode),
          const SizedBox(height: 8,),
          accountCreate(context,"address",address),
          const SizedBox(height: 48,),

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
                              child: ChangeNotifierProvider<LocationProvider>(
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
                              )
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

                              },
                              child:  Text("updateAddress".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
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
    );
  }
}

