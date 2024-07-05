import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../model/OLD/User.dart';
import '../../utils/style/CustomTextStyle.dart';

class BusinessCenter extends BaseStatefulPage {
  const BusinessCenter(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _BusinessCenterState();
}

class _BusinessCenterState extends BaseStatefulPageState<BusinessCenter> {
  AdminOverrideVm viewModel = AdminOverrideVm();
  LoginUser? loginUser;
  User? user;
  int index=0;
  SharedPref pref = SharedPref();
  bool check=false;
  @override
  void initState() {
    getCheck();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AdminOverrideVm>(
        builder: (context,value,_){
          if(viewModel.overrideUserList == null){
            return spinKit(context);
          }else{
            return Column(
              children: [
                /* Card(
          shape: cardShape(context),
          elevation: 2,
          color: ColorUtil().getColor(context, ColorEnums.background),
          child: SizedBox(
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/${PageName.digitalSignature}');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("paperWork".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                     Icon(Icons.arrow_forward_outlined,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                  ],
                ),
              ),
            ),
          ),
        ),*/

                GestureDetector(
                  onTap: (){

                    Navigator.pushNamed(context, '/${PageName.commReport}');
                  },
                  child: Card(
                    shape: cardShape(context),
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("myCommissions".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),

                SizedBox(
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/${PageName.bonusWinnerPage}');
                    },
                    child: Card(
                      shape: cardShape(context),
                      color: ColorUtil().getColor(context, ColorEnums.background),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("myBonuses".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),

                GestureDetector(
                  onTap: () async{

                    Navigator.pushNamed(context, '/${PageName.goalsReport}');
                  },
                  child: Card(
                    shape: cardShape(context),
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("myGoals".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                Card(
                  shape: cardShape(context),
                  color: ColorUtil().getColor(context, ColorEnums.background),
                  child: SizedBox(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/${PageName.expense}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("myExpenses".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            Icon(Icons.arrow_forward_outlined,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 8,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/${PageName.leadReport}');
                  },
                  child: Card(
                    shape: cardShape(context),
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("leadReport".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                GestureDetector(
                  onTap: (){

                    Navigator.pushNamed(context, '/${PageName.appointmentReport}');
                  },
                  child: Card(
                    shape: cardShape(context),
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("appointmentReport".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8,),
                Visibility(
                  visible: check == true ? true : false,
                  child: GestureDetector(
                    onTap: (){

                      Navigator.pushNamed(context, '/${PageName.dealerOverridePage}');
                    },
                    child: Card(
                      shape: cardShape(context),
                      color: ColorUtil().getColor(context, ColorEnums.background),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("overrideWinnerReport".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  getCheck()async{
    user ??=await getUserUser(context);
    int userId = user!.id!;
    await viewModel.getOverrideUser(context);
    if(viewModel.overrideUserList !=null){
      for(int i=0;i<viewModel.overrideUserList!.length;i++){
        if(viewModel.overrideUserList![i].id == userId){
          check = true;
        }
      }
    }
  }
}
