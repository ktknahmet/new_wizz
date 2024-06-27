import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/reset/ResetModel.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/login/login_view.dart';
import 'package:wizzsales/viewModel/ResetVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class ResetView extends BaseStatefulPage {
  const ResetView(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _ResetViewState();
}

class _ResetViewState extends BaseStatefulPageState<ResetView> {
  TextEditingController emailController = TextEditingController();
  ResetVm viewModel= ResetVm();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
     value: viewModel,
     child: Consumer<ResetVm>(
       builder: (context,value,_){
         return Column(
           children: [
             SizedBox( height:platformHeight()),
             Text("forgetPassword".tr(),style: CustomTextStyle().black24(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
             const SizedBox(height: 8),
             SizedBox(
                 width: sizeWidth(context).width*0.60,
                 child: Text("willSendCode".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
             ),
             const SizedBox(height: 40),
             mailCreate(context, "email", emailController),
             Expanded(
                 child: Align(
                   alignment: Alignment.bottomCenter,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       SizedBox(
                         width: sizeWidth(context).width * 0.75,
                         height: 44,
                         child: ElevatedButton(
                           style: elevatedButtonStyle(context),
                           onPressed: () {
                             if(emailController.text.isEmpty){
                               snackBarDesign(context, StringUtil.error, "requiredEmail".tr());
                             }else{
                               bool checkEmail = isEmail(emailController.text.toLowerCase());
                               if(checkEmail){
                                 var email = ResetModel(email: emailController.text.toLowerCase());
                                 viewModel.reset(context, email);

                               }else{
                                 snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
                               }
                             }
                           },
                           child: Text("forgotPassword".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                         ),
                       ),
                       const SizedBox(height: 16,),
                       SizedBox(
                         width: sizeWidth(context).width * 0.75,
                         height: 44,
                         child: ElevatedButton(
                           style: elevatedButtonStyle(context),
                           onPressed: () {
                             Navigator.push(
                                 context, MaterialPageRoute(builder: (context) =>  const LoginView(null)));
                           },
                           child: Text("cancel".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                         ),
                       ),
                       const SizedBox(height: 32,)
                     ],
                   ),
                 )
             )
           ],
         );
       },
     ),

    );
  }


}

