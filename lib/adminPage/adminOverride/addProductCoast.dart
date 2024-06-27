import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/postProductCoast.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../constants/ColorsUtil.dart';

class AddProductCoast extends BaseStatefulPage {
  const AddProductCoast(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AddProductCoastState();
}

class _AddProductCoastState extends BaseStatefulPageState<AddProductCoast> {
  AdminOverrideVm viewModel = AdminOverrideVm();
  TextEditingController amount = TextEditingController();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AdminOverrideVm>(
        builder: (context,value,_){
          if(viewModel.organisations == null){
            return spinKit(context);
          }else{
            return Column(
              children: [
                TextField(
                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                  cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                  decoration: dateInputDecoration(context,"selectDist"),
                  controller: viewModel.distName,
                  readOnly: true,
                  onTap: () async{

                    if(viewModel.organisations!.isNotEmpty){
                      showOrgList(context,viewModel);
                    }else{
                      snackBarDesign(context, StringUtil.warning, "userListEmpty".tr());
                    }
                  },
                ),
                const SizedBox(height: 8,),
                accountNumber(context, "amount", amount),
                const SizedBox(height: 8,),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: ()async{
                            await post();
                          },
                          style: elevatedButtonStyle(context),
                          child:Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
  getList() async{
    await viewModel.getOrganisations(context);
  }
  post()async{
    if(amount.text.isNotEmpty && viewModel.distId !=null){
      PostProductCoast post = PostProductCoast(
          productId: 1,
          distributorId: viewModel.distId,
          costAmount: amount.text
      );
      await viewModel.postProductCoast(context, post);
    }else{
      snackBarDesign(context, StringUtil.error, "allAreaMustRequired".tr());
    }
  }
}
