import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionWinner.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/saleDocument/postReceiveAmount.dart';
import 'package:wizzsales/model/saleDocument/saleDeduction.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/SalesVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../model/OLD/Sale.dart';


class CommissionDetails extends StatefulWidget {
  final Sale sale;
  const CommissionDetails(this.sale,{super.key});

  @override
  State<CommissionDetails> createState() => _CommissionDetailsState();
}

class _CommissionDetailsState extends State<CommissionDetails> {
  SalesVm viewModel = SalesVm();
  ScrollController controller = ScrollController();
  TextEditingController receive = TextEditingController();
  TextEditingController fee1 = TextEditingController();
  TextEditingController fee2 = TextEditingController();
  TextEditingController reserve = TextEditingController();
  TextEditingController deduction = TextEditingController();
  TextEditingController financeBy = TextEditingController();
  TextEditingController percentage = TextEditingController();
  TextEditingController financeRecerve = TextEditingController();
  TextEditingController note = TextEditingController();
  String paymentType="";
  dynamic totalComAmount=0;
  dynamic taxPrice;
  dynamic distProfit;

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
      appBar: DefaultAppBar(name: "comDetails".tr(),),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<SalesVm>(
          builder: (context, value, _) {
            if (viewModel.commissionDetails == null || viewModel.productCoast==null) {
              return spinKit(context);
            } else {
              return SizedBox(
                width: sizeWidth(context).width,
                height: sizeWidth(context).height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                         Column(
                            children: [
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
                                          SizedBox(
                                              width:sizeWidth(context).width*0.40,
                                              child: Text("salesPrice".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text("\$${widget.sale.netprice ?? "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                              child: Text("${context.tr("salesTax")} %${widget.sale.tax}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text("\$${getDecimalPlaces(taxPrice.toString(), 2)}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                            width: sizeWidth(context).width * 0.30,
                                            child: Text("totalPrice".tr(),
                                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ),
                                          Text("\$${widget.sale.price ?? "0.00"}", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                                Card(
                                  shape: cardShape(context),
                                  color: ColorUtil().getColor(context, ColorEnums.background),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeWidth(context).width * 0.30,
                                              child: Text("distProfit".tr(),
                                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ),
                                            Text("\$${getDecimalPlaces(distProfit, 2)}", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              Card(
                                shape: cardShape(context),
                                color: ColorUtil().getColor(context, ColorEnums.background),
                                child:   Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: sizeWidth(context).width * 0.40,
                                            child: Text("totalComAmount".tr(),
                                              style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ),
                                          Text("\$${moneyFormat(totalComAmount)}", style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      if(viewModel.commissionDetails!.isNotEmpty)
                                      SizedBox(
                                        height: viewModel.commissionDetails!.length*35,
                                        child: ListView.builder(
                                          itemCount: viewModel.commissionDetails!.length,
                                          itemBuilder: (context,index){
                                            List<CommissionWinner> sortedCommissionDetails = viewModel.commissionDetails!.toList();
                                            sortedCommissionDetails.sort((a, b) {
                                              int aIndex = roleOrder.indexOf(a.eligibleRoleName ?? '');
                                              int bIndex = roleOrder.indexOf(b.eligibleRoleName ?? '');
                                              if (aIndex == -1) aIndex = roleOrder.length; // Eğer a'nın rolü listede yoksa, en sona koy
                                              if (bIndex == -1) bIndex = roleOrder.length; // Eğer b'nin rolü listede yoksa, en sona koy
                                              return aIndex.compareTo(bIndex);
                                            });

                                            CommissionWinner model = sortedCommissionDetails[index];
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: sizeWidth(context).width * 0.75,
                                                      child: Text("${model.eligibleRoleName ?? ""} ${context.tr("comAmount")}",
                                                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                    ),
                                                    Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                          GestureDetector(
                                                                onTap:(){
                                                                  showComAmountDetail(context,viewModel,model,widget.sale.id!);
                                                              },
                                                                child: Text("\$${model.commAmount ?? "0"}", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)))),
                                                            const Divider(
                                                              thickness: 1,
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             Card(
                               shape: cardShape(context),
                               color: ColorUtil().getColor(context, ColorEnums.background),
                               child:
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Column(
                                       children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("paymentType".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text(paymentType, style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("down".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text("\$${widget.sale.down ?? "0.00"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("financeBy".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text(widget.sale.financeby ?? "N/A" , style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("financed".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text("\$${widget.sale.financepercentage ?? "0.00"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("financeReceive".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text("\$${widget.sale.finance ?? "0.00"}.00", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("fee1".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text("\$${widget.sale.fee1 ?? "0.00"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("fee2".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text("\$${widget.sale.fee2 ?? "0.00"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("reserve".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text("\$${widget.sale.reserve ?? "0.00"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("otherDeduction".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text("\$${widget.sale.otherDeductions ?? "0.00"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: sizeWidth(context).width * 0.30,
                                               child: Text("receiveAmount".tr(),
                                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                             ),
                                             Text("\$${moneyFormat(double.parse(widget.sale.receive_amount ?? "0.00"))}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           ],
                                         ),
                                         const SizedBox(height: 4,),
                                         SizedBox(
                                           width:sizeWidth(context).width*0.80,
                                           height:30,
                                           child: ElevatedButton(
                                               onPressed: (){
                                                 viewModel.setOpenComDesign();
                                               },
                                               style: elevatedButtonStyle(context),
                                               child: Text("adjustPayOut".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                               )
                            ],
                          ),
                        const SizedBox(height: 8,),
                        Visibility(
                          visible: viewModel.openComDesign==true ? true : false,
                          child: Column(
                            children: [
                              Visibility(
                                visible: paymentType =="Financed" || paymentType =="Not Selected" ? true : false,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          accountCreate(context, "financeBy", financeBy),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("financePercentage".tr(), style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                          const SizedBox(height: 4,),
                                          TextField(
                                            maxLines: null,
                                            controller: percentage,
                                            keyboardType: TextInputType.number,
                                            style: CustomTextStyle().bold12(
                                                ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                            decoration: textFieldTextDesign(context, "financePercentage"),
                                            cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                            onChanged: (value) {
                                              if(percentage.text.isNotEmpty && widget.sale.price !=null && widget.sale.price!.isNotEmpty){
                                                percentage.text = getDecimalPlaces(value, 2);
                                                percentage.text = percentage.text.replaceAll(",", ".");
                                                if(double.parse(percentage.text)>100){
                                                  percentage.text="100";
                                                }
                                                if(double.parse(percentage.text)<0){
                                                  percentage.text="0";
                                                }
                                                dynamic x = (double.parse(widget.sale.price ?? "0.0")) * (double.parse(percentage.text)/100);
                                                financeRecerve.text = getDecimalPlaces(x, 2);
                                              }else{
                                                financeRecerve.text="";
                                                percentage.text ="";
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //financeRecerve sadece değişecek finanse percentage ve sales amounta göre
                              Visibility(
                                visible: paymentType =="Financed" || paymentType =="Not Selected" ? true : false,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8,),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("financeReceive".tr(), style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                    ),
                                    const SizedBox(height: 4,),
                                    TextField(
                                      maxLines: null,
                                      controller: financeRecerve,
                                      keyboardType: TextInputType.number,
                                      style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                      decoration: textFieldTextDesign(context, "financeReceive"),
                                      cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                      onChanged: (value){

                                        if(financeRecerve.text.isNotEmpty && widget.sale.price !=null && widget.sale.price!.isNotEmpty){
                                          if(double.parse(financeRecerve.text)>double.parse(widget.sale.price!)){
                                            financeRecerve.text=widget.sale.price!;
                                          }
                                          if(int.parse(financeRecerve.text)<0){
                                            financeRecerve.text="0";
                                          }
                                          dynamic x = ((double.parse(financeRecerve.text)*100) / double.parse(widget.sale.price!));
                                          percentage.text = x.toString();
                                        }else{
                                          financeRecerve.text="";
                                          percentage.text ="";
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),


                              Visibility(
                                visible:paymentType != "Cash" ? true : false,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              accountNumber(context, "fee1", fee1),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              accountNumber(context, "fee2", fee2),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              accountNumber(context, "reserve", reserve),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              accountNumber(context, "otherDeduction", deduction),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        accountCreate(context, "receiveAmount", receive),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        accountNumber(context, "note", note),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              SizedBox(
                                width: sizeWidth(context).width * 0.8,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await control();
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("save".tr(),
                                    style: CustomTextStyle().bold12(
                                        ColorUtil().getColor(
                                            context, ColorEnums.textDefaultLight)),),
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void>getList() async {
    paymentType = financeType(widget.sale.finance ?? 10);
    financeBy.text = widget.sale.financeby ?? "";
    reserve.text = widget.sale.reserve ?? "0";
    fee1.text = widget.sale.fee1 ?? "0";
    fee2.text = widget.sale.fee2 ?? "0";
    deduction.text = widget.sale.otherDeductions ?? "0";
    receive.text = widget.sale.receive_amount ?? "0";
    await viewModel.getComDetails(context, widget.sale.id!);
    await viewModel.getProductCoast(context);


    for(int i=0;i<viewModel.commissionDetails!.length;i++){
      totalComAmount +=double.parse(viewModel.commissionDetails![i].commAmount!);
    }

    if(widget.sale.price !=null){
      taxPrice = (double.parse(widget.sale.price!) * double.parse(widget.sale.tax!)) / 100;
    }else{
      taxPrice ="";
    }
    if(viewModel.productCoast!.isNotEmpty){
      distProfit = double.parse(widget.sale.price!) - totalComAmount - double.parse(viewModel.productCoast![0].costAmount!);
    }else{
      distProfit = double.parse(widget.sale.price!) - totalComAmount;
    }
    distProfit = "${distProfit}0";
  }

  post() async {
    SaleDeduction model = SaleDeduction(
        saleId: widget.sale.id!,
        reserve: reserve.text.isNotEmpty ? reserve.text : 0.0,
        fee1: fee1.text.isNotEmpty ? fee1.text : 0.0,
        fee2: fee2.text.isNotEmpty ? fee2.text : 0.0,
        otherDeductions: deduction.text.isNotEmpty ? deduction.text : 0.0,
        financeBy: financeBy.text,
        financePercentage: percentage.text.isNotEmpty ? percentage.text :0.0,
    );
    await viewModel.postDeduction(context, model, widget.sale.id!);
  }

  postAmount() async {
    PostReceiveAmount receiveAmount = PostReceiveAmount(
        saleId: widget.sale.id!,
        receiveAmount: receive.text.replaceAll(",", ".")
    );
    if (receive.text.isNotEmpty) {
      await viewModel.postReceive(context, receiveAmount,widget.sale.id!);
      await post();
    } else {
      snackBarDesign(context, StringUtil.error, "Receive amount must be bigger than 0");
    }
  }

  justPostAmount() async {
    PostReceiveAmount receiveAmount = PostReceiveAmount(
        saleId: widget.sale.id!,
        receiveAmount: receive.text.replaceAll(",", ".")
    );
    if (receive.text.isNotEmpty) {
      await viewModel.postReceive(context, receiveAmount,widget.sale.id!);
    } else {
      snackBarDesign(context, StringUtil.error, "Receive amount must be bigger than 0");
    }
  }

  control() async {
    if (paymentType == "Cash") {
      await justPostAmount();
    } else {
      await postAmount();
    }
  }

}
