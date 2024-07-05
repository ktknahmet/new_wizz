import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../../adminPage/adminModel/commissionModel/commissionWinner.dart';
import '../../../model/OLD/Sale.dart';
import '../../../model/OLD/register/LoginUser.dart';
import '../../../utils/function/SharedPref.dart';
import '../../../utils/res/SharedUtils.dart';
import '../../../utils/style/ColorEnums.dart';
import '../../../utils/style/CustomTextStyle.dart';
import '../../../utils/style/WidgetStyle.dart';
import '../../../viewModel/SalesVm.dart';
import '../../../widgets/Constant.dart';

class DealerComDetails extends StatefulWidget {
  final Sale sale;
  const DealerComDetails(this.sale,{super.key});

  @override
  State<StatefulWidget> createState() => _DealerComDetailsState();
}

class _DealerComDetailsState extends State<DealerComDetails> {
  SalesVm viewModel = SalesVm();
  List<CommissionWinner> winner=[];
  LoginUser? loginUser;
  int index=0;
  dynamic taxPrice;
  @override
  void initState() {
    getList();
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
      appBar: DefaultAppBar(name: "seeWinner".tr(),),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<SalesVm>(
          builder: (context,value,_){
            if(viewModel.commissionDetails == null){
              return spinKit(context);
            }else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16,),
                    Card(
                      color: ColorUtil().getColor(context, ColorEnums.background),
                      shape: cardShape(context),
                      child:Column(
                        children: [
                          Text("paymentDetails".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("paymentMethod".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(financeType(widget.sale.finance ?? 10),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                              ],

                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("salesPrice".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("\$${widget.sale.price ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("${context.tr("salesTax")} ${widget.sale.tax ?? "0.0"}%",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("\$${getDecimalPlaces(taxPrice, 2)}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("totalPrice".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("\$${widget.sale.netprice ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("down".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("\$${widget.sale.down ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("otherDeduction".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("\$${widget.sale.otherDeductions ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ) ,
                    ),
                    winner.isNotEmpty && winner[0].isCommPaid == true ?
                    Card(
                      shape: cardShape(context),
                      color: ColorUtil().getColor(context, ColorEnums.background),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("comDetails".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            const SizedBox(height: 8,),
                            if(winner[0].isCommPaid == true)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("payDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(mmDDYDate(winner[0].payAt ?? ""),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("salesRole".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(upperFirstLetter(winner[0].eligibleRoleName ?? ""),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("comAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text("\$${winner[0].commAmount ?? "0.00"}",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),



                                ],
                              )

                          ],
                        ),
                      ),
                    ):Column(
                      children: [
                        SizedBox(
                          width: sizeWidth(context).width,
                          child: Card(
                            shape: cardShape(context),
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            child: Column(
                              children: [
                                Text("comDetails".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                const SizedBox(height: 16,),
                                Text("comPending".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                const SizedBox(height: 8,),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }


  Future<void>getList()async{
    if(widget.sale.price !=null){
      taxPrice = (double.parse(widget.sale.price ?? "0.00") * double.parse(widget.sale.tax ?? "0.0")) / 100;
    }else{
      taxPrice ="";
    }
    SharedPref pref = SharedPref();
    int index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    await viewModel.getComDetails(context, widget.sale.id);
    winner.clear();
    if(viewModel.commissionDetails !=null){
      for(int i=0;i<viewModel.commissionDetails!.length;i++){
        print("aktekin ${loginUser!.name}  -- ${viewModel.commissionDetails![i].userName } -- ${loginUser!.profiles![index].salesrolename!.contains(viewModel.commissionDetails![i].profileMenurole!)}");
        if(loginUser!.name ==viewModel.commissionDetails![i].userName && loginUser!.profiles![index].salesrolename!.contains(viewModel.commissionDetails![i].profileMenurole!)){
          winner.add(viewModel.commissionDetails![i]);
        }
      }
    }
  }
}
