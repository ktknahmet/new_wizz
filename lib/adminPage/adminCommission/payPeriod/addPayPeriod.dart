import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPeriod/postPayPeriod.dart';
import 'package:wizzsales/adminPage/adminVm/commissionVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AddPayPeriod extends BaseStatefulPage {
  const AddPayPeriod(super.appBarName, {super.key});
   //payPeriod
  @override
  State<StatefulWidget> createState() => _AddPayPeriodState();
}

class _AddPayPeriodState extends BaseStatefulPageState<AddPayPeriod> {
  CommissionVm viewModel = CommissionVm();
  TextEditingController startDate = TextEditingController();
  TextEditingController payPeriodStartDate = TextEditingController();
  @override
  void initState() {
    getList();
    super.initState();
  }

 @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<CommissionVm>(
        builder: (context,value,_){
          if(viewModel.getPayPeriod == null){
            return spinKit(context);
          }else{
            return Column(
              children: [
                if(viewModel.getPayPeriod!.payPeriod !=null || viewModel.getPayPeriod!.payDate !=null)
                  Card(
                    shape: cardShape(context),
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("payPeriod".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),

                              Text("Every ${viewModel.getPayPeriod!.payPeriod ?? ""}", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("payDate".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),

                              Text(viewModel.getPayPeriod!.payDate ?? "", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                Card(
                  shape: cardShape(context),
                  color: ColorUtil().getColor(context, ColorEnums.background),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              value: "weekly".tr(),
                              groupValue: viewModel.periodType,
                              onChanged: (value) async{
                                viewModel.setPeriodType("weekly".tr());
                              },
                            ),
                            Text("weekly".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              value: "twoWeeks".tr(),
                              groupValue: viewModel.periodType,
                              onChanged: (value) async{
                                viewModel.setPeriodType("twoWeeks".tr());
                              },
                            ),
                            Text("twoWeeks".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                if(viewModel.periodType !=null)

                  Card(
                    shape: cardShape(context),
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    child: Column(
                      children: [
                        Text("payPeriodDay".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),

                        Row(
                          children: [
                            Radio(
                              activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              value: "monday".tr(),
                              groupValue: viewModel.periodDay,
                              onChanged: (value) async{
                                viewModel.setPeriodDay("monday".tr());
                              },
                            ),
                            Text("monday".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              value: "tuesday".tr(),
                              groupValue: viewModel.periodDay,
                              onChanged: (value) async{
                                viewModel.setPeriodDay("tuesday".tr());
                              },
                            ),
                            Text("tuesday".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              value: "wednesday".tr(),
                              groupValue: viewModel.periodDay,
                              onChanged: (value) async{
                                viewModel.setPeriodDay("wednesday".tr());
                              },
                            ),
                            Text("wednesday".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              value: "thursday".tr(),
                              groupValue: viewModel.periodDay,
                              onChanged: (value) async{
                                viewModel.setPeriodDay("thursday".tr());
                              },
                            ),
                            Text("thursday".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              value: "friday".tr(),
                              groupValue: viewModel.periodDay,
                              onChanged: (value) async{
                                viewModel.setPeriodDay("friday".tr());
                              },
                            ),
                            Text("friday".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                          ],
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 4,),
                Card(
                  shape: cardShape(context),
                  color: ColorUtil().getColor(context, ColorEnums.background),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text("payPeriodStartDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        SizedBox(
                          width: sizeWidth(context).width*0.4,
                          child: TextField(
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            decoration: dateInputDecoration(context,"payPeriodStartDate"),
                            controller: payPeriodStartDate,
                            readOnly: true,
                            onTap: () async{
                              payPeriodStartDate.text = await DatePickerHelper.getDatePicker(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4,),
                SizedBox(
                  width: sizeWidth(context).width*0.8,
                  child: ElevatedButton(
                      onPressed: ()async{
                        await post();
                      },
                      style: elevatedButtonStyle(context),
                      child: Text("save".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  getList()async{
    SharedPref pref = SharedPref();
    payPeriodStartDate.text = await pref.getString(context, "payPeriod");
    await viewModel.listPayPeriod(context);
    if(viewModel.getPayPeriod!.payPeriod !=null){
      viewModel.setPeriodType( viewModel.getPayPeriod!.payPeriod!);

    }
    if(viewModel.getPayPeriod!.payDate !=null){
      viewModel.setPeriodDay(viewModel.getPayPeriod!.payDate!);
    }
  }
  post()async{
    SharedPref pref = SharedPref();
    await pref.setString("payPeriod", payPeriodStartDate.text);
    if(viewModel.periodDay ==null || viewModel.periodType == null){
      snackBarDesign(context, StringUtil.error, "selectPeriod".tr());
      return;
    }

    PostPayPeriod period = PostPayPeriod(
      payPeriod: viewModel.periodType!,
      payDate: viewModel.periodDay!
    );
    await viewModel.postPayPeriod(context,period);
  }
}
