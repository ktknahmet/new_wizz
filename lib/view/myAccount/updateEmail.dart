import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class UpdateEmail extends BaseStatefulPage {
   const UpdateEmail(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _UpdateEmailState();
}
class _UpdateEmailState extends BaseStatefulPageState<UpdateEmail>{
  TextEditingController currentEmail = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController emailAgain = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget design() {

    return Column(
      children: [
        const SizedBox(height: 16,),
        Align(
            alignment: Alignment.centerLeft,
            child: Text("email".tr(),style: CustomTextStyle().semiBold12(ColorUtil()
                .getColor(context, ColorEnums.textTitleLight),),)
        ),
        const SizedBox(height: 4,),
        TextField(
          readOnly: true,
          controller: currentEmail,
          keyboardType: TextInputType.multiline,
          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
          decoration: textFieldTextDesign(context,"email"),
          cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
          onChanged: (value){

          },
        ),
        const SizedBox(height: 16,),
        accountCreate(context,"newEmail",email),
        const SizedBox(height: 16,),
        accountCreate(context,"reEmail",emailAgain),

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
                    child:Text("updateEmail".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  ),
                ),
                const SizedBox(height: 16,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


