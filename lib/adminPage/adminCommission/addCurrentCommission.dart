import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/checkComAdd.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comAmount.dart';
import 'package:wizzsales/adminPage/adminVm/commissionVm.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AddCurrentCommission extends StatefulWidget {
  final int? poolId;
  const AddCurrentCommission(this.poolId,{super.key});

  @override
  State<AddCurrentCommission> createState() => _AddCurrentCommissionState();
}

class _AddCurrentCommissionState extends State<AddCurrentCommission> {
  ScrollController controller = ScrollController();
  CommissionVm viewModel = CommissionVm();
  TextEditingController startAmount = TextEditingController();
  TextEditingController endAmount = TextEditingController();
  TextEditingController commission = TextEditingController();
  Amount? amount;
  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: DefaultAppBar(name:"addCommission".tr()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: sizeWidth(context).width,
            height: sizeWidth(context).height,
            child: ChangeNotifierProvider.value(
              value: viewModel,
              child: Consumer<CommissionVm>(
                builder: (context,value,_){
                  return SingleChildScrollView(
                    child: Column(

                      children: [
                        Text("selectComType".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("pleaseChoseOne".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                        ),
                        Card(
                          shape: cardShape(context),
                          color: ColorUtil().getColor(context, ColorEnums.background),
                          child:Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                      value: 0,
                                      groupValue: viewModel.comtype,
                                      onChanged: (value) async{
                                        viewModel.setComType(0);
                                      },
                                    ),
                                    Text("flatRate".tr(), style: TextStyle(color: ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                      value: 1,
                                      groupValue: viewModel.comtype,
                                      onChanged: (value) async{
                                        viewModel.setComType(1);

                                      },
                                    ),
                                    Text("percentage".tr(), style: TextStyle(color: ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                          Column(
                            children: [

                              SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: accountNumber(context, "minAmount", startAmount),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          accountNumber(context, "maxAmount", endAmount),
                                        ],

                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              const SizedBox(height: 8,),
                              viewModel.comtype==0 ?
                              accountNumber(context, "comAmount", commission)
                                  :accountNumber(context, "percentageNetSale", commission),
                              const SizedBox(height: 8,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: sizeWidth(context).width*0.5,
                                    child: ElevatedButton(
                                      onPressed: ()async{
                                        if(startAmount.text.isEmpty || endAmount.text.isEmpty || commission.text.isEmpty){
                                          snackBarDesign(context, StringUtil.error, "requiredAmountArea".tr());
                                        }else{
                                          double startNumber = double.parse(startAmount.text);
                                          double endNumber = double.parse(endAmount.text);
                                          double comNumber = double.parse(commission.text);

                                          int parsedStart = startNumber.toInt();
                                          int parsedEnd = endNumber.toInt();
                                          int parsedCom = comNumber.toInt();
                                          if(parsedStart>parsedEnd){
                                            snackBarDesign(context, StringUtil.error, "startAmountLess".tr());
                                            return;
                                          }
                                          if(viewModel.comtype==0){
                                            amount = Amount(
                                                amountLevel1: parsedStart,
                                                amountLevel2: parsedEnd,
                                                commAmount: parsedCom,
                                                comPercentage: null
                                            );
                                          }else{
                                            amount = Amount(
                                                amountLevel1: parsedStart,
                                                amountLevel2: parsedEnd,
                                                commAmount: null,
                                                comPercentage: parsedCom
                                            );
                                          }
                                            CheckComAdd checkComAdd = CheckComAdd(
                                                calcPoolId: widget.poolId,
                                                amountLevel1:parsedStart,
                                                amountLevel2: parsedEnd
                                            );
                                            await viewModel.checkCommissionAdd(context, checkComAdd,amount!);
                                            startAmount.clear();
                                            endAmount.clear();
                                            commission.clear();



                                        }
                                      },
                                      style: elevatedButtonStyle(context),
                                      child: Text("addCommission".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                    ),
                                  ),

                                  SizedBox(
                                    width: sizeWidth(context).width*0.4,
                                    child: ElevatedButton(
                                      onPressed: ()async{
                                        await post();
                                      },
                                      style: elevatedButtonStyle(context),
                                      child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                    ),
                                  ),
                                ],
                              ),
                              RawScrollbar(
                                thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                thumbVisibility: true,
                                thickness: 1,
                                trackVisibility: true,
                                controller: controller,
                                child: SizedBox(
                                  height: sizeWidth(context).height*0.35,
                                  child: ListView.builder(
                                    controller: controller,
                                    itemCount: viewModel.amounts.length,
                                    itemBuilder: (context,index){
                                      Amount item = viewModel.amounts[index];
                                      return Dismissible(
                                        background: Container(
                                          color: ColorUtil().getColor(context, ColorEnums.error),
                                          child: const Icon(Icons.delete,color: AppColors.white,),
                                        ),
                                        key: UniqueKey(),
                                        onDismissed: (DismissDirection direction){
                                          viewModel.deleteList(index);
                                        },
                                        child:  Card(
                                          shape: cardShape(context),
                                          color: ColorUtil().getColor(context, ColorEnums.background),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width:sizeWidth(context).width*0.40,
                                                        child: Text("minAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text("\$${item.amountLevel1}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width:sizeWidth(context).width*0.40,
                                                        child: Text("maxAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text("\$${item.amountLevel2}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width:sizeWidth(context).width*0.40,
                                                        child:viewModel.comtype == 0 ?
                                                        Text("comAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                            :
                                                        Text("perAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          viewModel.amounts[index].commAmount == null ?
                                                          Text("%${viewModel.amounts[index].comPercentage}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                              :
                                                          Text("\$${viewModel.amounts[index].commAmount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)                                                              ],
                                                      ),
                                                    ),
                                                  ],
                                                ),



                                              ],
                                            ),
                                          ),
                                        ),

                                      );
                                    },
                                  ),
                                ),
                              ),


                            ],
                          )
                      ],
                    ),
                  );
                },
              ),
            )
        ),
      ),
    );
  }

  post()async{
      if(viewModel.amounts.isEmpty){
        snackBarDesign(context, StringUtil.error, "youMustAddAmount".tr());
        return;
      }
      ComAmount post = ComAmount(
          calcPoolId: widget.poolId,
          amounts: viewModel.amounts
      );
      await viewModel.postComAmount(context, post);


  }


}
