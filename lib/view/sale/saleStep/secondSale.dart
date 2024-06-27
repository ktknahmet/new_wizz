import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

import '../../../utils/style/CustomTextStyle.dart';

class SecondSale extends StatefulWidget {
  final VoidCallback? continueClick;
  final String? step;
  final VoidCallback? previousClick;
  final String? totalStepCount;
  const SecondSale({super.key, required this.continueClick,this.previousClick,this.step, this.totalStepCount});

  @override
  State<SecondSale> createState() => _SecondSaleState();
}

class _SecondSaleState extends State<SecondSale> {
  TextEditingController startDate=TextEditingController();
  @override
  void initState() {
    if(SaleVM.addSaleModel.date !=null){
      startDate.text =formatDateString(SaleVM.addSaleModel.date!,"MM-dd-yyyy","yyyy-MM-dd");
    }else{
      startDate.text = mmDDYDate(DateTime.now().toString());
    }

    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: sizeWidth(context).height,
        child: Column(
          children: [
            Text("salesDate".tr(),style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            Text("pleaseSelectDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            const SizedBox(height: 8,),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("${context.tr("step")} 2/${widget.totalStepCount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ),
            const SizedBox(height: 8,),
            TextField(
              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
              cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
              decoration: dateInputDecoration(context,"salesDate"),
              controller: startDate,
              readOnly: true,
              onTap: () async{
                startDate.text = await DatePickerHelper.getDatePicker(context);
              },
            ),
            const SizedBox(height: 8,),
             Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                          if(startDate.text.isNotEmpty){


                            SaleVM.addSaleModel.date = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");

                            widget.continueClick!();
                          }else{
                            snackBarDesign(context, StringUtil.warning, "saleDateCannotEmpty".tr());
                          }
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                      )
                    ],
                  ),
                )
          ],
        ),
    );
  }
}
