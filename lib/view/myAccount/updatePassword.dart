import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/UpdatePassVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WizzTextField.dart';

class UpdatePassword extends BaseStatefulPage {
  const UpdatePassword(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends BaseStatefulPageState<UpdatePassword> {

  TextEditingController oldPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordAgain = TextEditingController();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider(
      create: (_)=>UpdatePassVm(),
      child: Consumer<UpdatePassVm>(
        builder: (context,value,_){
          return Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("oldPassword".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                ),
                const SizedBox(height: 2,),
                WizzTextField(
                  hint: "oldPassword",
                  textEditingController: oldPassword,
                  hintTextColor: ColorEnums.textDefaultLight,
                  hintTextSize: 14,
                  borderColor: ColorEnums.textDefaultLight,
                  borderWidth: 1.0,
                  textColor: ColorEnums.textDefaultLight,
                  isObsecure: value.oldPassView,
                  isObsecureClicked: () {
                    value.changeOldPass();
                  },
                ),

                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("newPassword".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                    ),
                    const SizedBox(height: 2,),
                    WizzTextField(
                      hint: "writePassword",
                      textEditingController: password,
                      hintTextColor: ColorEnums.textDefaultLight,
                      hintTextSize: 14,
                      borderColor: ColorEnums.textDefaultLight,
                      borderWidth: 1.0,
                      textColor: ColorEnums.textDefaultLight,
                      isObsecure: value.newPassView,
                      isObsecureClicked: () {
                        value.changeNewPass();
                      },
                    ),
                    const SizedBox(height: 16,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("reNewPassword".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                    const SizedBox(height: 2,),
                    WizzTextField(
                      hint:"writePassword",
                      textEditingController: passwordAgain,
                      hintTextColor: ColorEnums.textDefaultLight,
                      hintTextSize: 14,
                      borderColor: ColorEnums.textDefaultLight,
                      borderWidth: 1.0,
                      textColor: ColorEnums.textDefaultLight,
                      isObsecure: value.reNewPassView,
                      isObsecureClicked: () {
                        value.changeReNewPass();
                      },
                    ),
                    const SizedBox(height: 16,),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: sizeWidth(context).width*0.75,
                          child: ElevatedButton(
                            style: elevatedButtonStyle(context),
                            onPressed: () async{
                            },
                            child:  Text("updatePass".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ]
          );
        },
      ),
    );
  }


}
