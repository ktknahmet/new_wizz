import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/utils/function/providerFunc/AppStateNotifier.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class MyAccount extends BaseStatefulPage {

   const MyAccount(super.appBarName,{super.key});

   @override
   State<StatefulWidget> createState() => _MyAccountState();

}

class _MyAccountState extends BaseStatefulPageState<MyAccount>{
  String? selectedLanguage;
  @override
  Widget design(){
    return ChangeNotifierProvider(
      create: (_)=>AppStateNotifier(),
      child: Consumer<AppStateNotifier>(
        builder: (context,value,_){
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("changeLanguage".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<String>(
                          dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                          underline: const SizedBox(),
                          hint: Row(

                            children: [
                              Text("language".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              const SizedBox(width: 8,),
                              Image.asset("assets/flag/${context.tr("photoPath")}",height: 24,)
                            ],
                          ),
                          value: selectedLanguage,
                          onChanged: (newValue) async{
                            value.setLanguage(context, newValue!);
                          },
                          items: modelList.map((model) {
                            return DropdownMenuItem<String>(
                              value: model.value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(model.key,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                  const SizedBox(width: 8,),
                                  Image.asset("assets/flag/${model.imagePath}",height: 24,)
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/${PageName.uploadPhoto}');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("updatePicture".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      const Icon(Icons.arrow_forward_outlined,color: Colors.grey,)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/${PageName.updateEmail}');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("updateEmail".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      const Icon(Icons.arrow_forward_outlined,color: Colors.grey,)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/${PageName.updatePassword}');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("updatePass".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      const Icon(Icons.arrow_forward_outlined,color: Colors.grey,)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/${PageName.updateAddress}');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("updateAddress".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      const Icon(Icons.arrow_forward_outlined,color: Colors.grey,)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/${PageName.updateSocial}');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("socialMedia".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      const Icon(Icons.arrow_forward_outlined,color: Colors.grey,)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: (){
                    //deleteUser();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("deleteMyAccount".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      const Icon(Icons.arrow_forward_outlined,color: Colors.grey,)
                    ],
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}



