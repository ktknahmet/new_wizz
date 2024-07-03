import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Distributor.dart';
import 'package:wizzsales/model/OLD/Sale.dart';
import 'package:wizzsales/model/OLD/register/DistributorSubType.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/OLDLibrary.dart';
import 'package:wizzsales/widgets/OldViewUtis.dart';
import 'package:wizzsales/widgets/WizzTextField.dart';

import '../../../utils/style/WidgetStyle.dart';

class SeventhSale extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? step;
  final String? totalStepCount;
  const SeventhSale({super.key, required this.continueClick,this.previousClick,this.step, this.totalStepCount});

  @override
  State<SeventhSale> createState() => _SeventhSaleState();
}

class _SeventhSaleState extends State<SeventhSale> {
  Distributor? distributor;
  TextEditingController salesPriceController = TextEditingController();
  TextEditingController salesTaxController = TextEditingController();
  TextEditingController salestotalPriceController = TextEditingController();
  TextEditingController salesTotalTaxController = TextEditingController();

  TextEditingController salesFee1Controller = TextEditingController();
  TextEditingController salesFee2Controller = TextEditingController();
  TextEditingController salesOtherDeductionsController = TextEditingController();
  TextEditingController salesDownController = TextEditingController();
  TextEditingController salesFinancepercentageController = TextEditingController();
  TextEditingController salesFinancebyController = TextEditingController();
  TextEditingController salesReserveController = TextEditingController();
  TextEditingController salesFinancedAmountController = TextEditingController();
  TextEditingController salesNetpriceController = TextEditingController();
  TextEditingController salesComisionController = TextEditingController();

  TextEditingController editingController = TextEditingController();
  String selectedFinance = "Select";
  String selectedPaymentType = "Select";
  String selectedLeadType = "Select";

  bool visibilityDownFinance = false;
  bool visibilityMoreFinance = false;
  @override
  void initState() {
    UserVM.getDistributors(context).then((value) {

      if (value != null) {
        distributor = value;
        ViewUtil.leadtype = distributor!.leadtype!;
        ViewUtil.downtype = distributor!.downtype!;
        ViewUtil.finance = distributor!.finance!;

        if (SaleVM.addSaleModel.finance != null) {
          DistributorSubType paymentType = distributor!.finance!.where((element) {
            return element.id == SaleVM.addSaleModel.finance;
          }).first;

          selectedFinance = paymentType.name ?? "";
        }
        print("aktekin ${SaleVM.addSaleModel.finance}");

        if (SaleVM.addSaleModel.leadtype != null) {
          DistributorSubType leadType = distributor!.leadtype!.where((element) {
            return element.id == SaleVM.addSaleModel.leadtype;
          }).first;

          selectedLeadType = leadType.name ?? "";
        }

        if (SaleVM.addSaleModel.downType != null) {
          DistributorSubType downType = distributor!.downtype!.where((element) {
            return element.id == SaleVM.addSaleModel.downType;
          }).first;
          selectedPaymentType = downType.name ?? "";
        }

        salesFinancepercentageController.text =
        SaleVM.addSaleModel.financepercentage != null
            ? '${SaleVM.addSaleModel.financepercentage!}%'
            : "";
        salesTaxController.text =
        SaleVM.addSaleModel.tax != null ? '${SaleVM.addSaleModel.tax!}%' : "";
        if (SaleVM.addSaleModel.down != null) {
          salesDownController.text = '\$${SaleVM.addSaleModel.down!}';
          String down = SaleVM.addSaleModel.down!;
          down = down.replaceAll(",", "");
        }
        if (SaleVM.addSaleModel.otherDeductions != null) {
          salesOtherDeductionsController.text =
          '\$${SaleVM.addSaleModel.otherDeductions!}';
          String oded = SaleVM.addSaleModel.otherDeductions!;
          oded = oded.replaceAll(",", "");
        }
        if (SaleVM.addSaleModel.fee1 != null) {
          salesFee1Controller.text = '\$${SaleVM.addSaleModel.fee1!}';
          String fee1 = SaleVM.addSaleModel.fee1!;
          fee1 = fee1.replaceAll(",", "");
        }
        if (SaleVM.addSaleModel.fee2 != null) {
          salesFee2Controller.text = '\$${SaleVM.addSaleModel.fee2!}';
          String fee2 = SaleVM.addSaleModel.fee2!;
          fee2 = fee2.replaceAll(",", "");
        }
        if (SaleVM.addSaleModel.price != null) {
          salesPriceController.text = '\$${SaleVM.addSaleModel.price!}';
          String price = SaleVM.addSaleModel.price!;
          price = price.replaceAll(",", "");
          double pri = double.parse(price);
          double taxval = double.parse(salesTaxController.text.replaceAll("%", ""));
          double val = (pri * taxval) / 100;
          salesTotalTaxController.text = '\$${val.toStringAsFixed(2)}';
          double totalprice = pri + val;
          salestotalPriceController.text = '\$${totalprice.toStringAsFixed(2)}';

          double val2 = 0;
          if (salesDownController.text != "" && salesDownController.text != "\$") {
            val2 = double.parse(salesDownController.text
                .replaceAll("\$", "")
                .replaceAll(",", ""));
          }
          double financedAmount = totalprice - val2;
          salesFinancedAmountController.text =
          '\$${financedAmount.toStringAsFixed(2)}';
        }
        salesFinancebyController.text = SaleVM.addSaleModel.financeby ?? "";
        if (SaleVM.addSaleModel.reserve != null) {
          salesReserveController.text = '\$${SaleVM.addSaleModel.reserve!}';
          String reserve = SaleVM.addSaleModel.reserve!;
          reserve = reserve.replaceAll(",", "");
        }
        if (SaleVM.addSaleModel.netprice != null) {
          salesNetpriceController.text = '\$${SaleVM.addSaleModel.netprice!}';
          String netprice = SaleVM.addSaleModel.netprice!;
          netprice = netprice.replaceAll(",", "");
        }
        if (SaleVM.addSaleModel.comision != null) {
          salesComisionController.text = '\$${SaleVM.addSaleModel.comision!}';
          String comision = SaleVM.addSaleModel.comision!;
          comision = comision.replaceAll(",", "");
        }
        _changevisibility();
        calculatePayout();
        setState(() {});
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SingleChildScrollView(
            child: Column(
              children: [
                Text("priceInfo".tr(),style: CustomTextStyle().black20(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                Text("fillInformation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${"step".tr()} 7/${widget.totalStepCount!}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                ),
                const SizedBox(height: 16,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("leadType".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
                const SizedBox(height: 4,),
                GestureDetector(
                  onTap: (){
                    clearFocus(context);
                    showPickerDialog(distributor!.leadtype ?? [], "LEADTYPE");
                  },
                  child: Container(
                    width: sizeWidth(context).width,
                    height: 50,
                    decoration: containerDecoration(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(selectedLeadType,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    ),
                  ),
                ),

                const SizedBox(height: 16,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("paymentType".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
                const SizedBox(height: 4,),
                GestureDetector(
                  onTap: (){
                    clearFocus(context);
                    showPickerDialog(distributor!.finance ?? [], "FINANCE");
                  },
                  child: Container(
                    width: sizeWidth(context).width,
                    height: 50,
                    decoration: containerDecoration(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(selectedFinance,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                    children: [
                       SizedBox(
                         width: sizeWidth(context).width*0.40,
                         child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("salesPrice".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(height: 4,),
                              WizzTextField(
                                hint: "salesPrice",
                                textEditingController: salesPriceController,
                                hintTextColor: ColorEnums.textDefaultLight,
                                hintTextSize: 14,
                                borderColor: ColorEnums.shadowDefaultLight,
                                borderWidth: 1.0,
                                textColor: ColorEnums.textDefaultLight,
                                isObsecure: null,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatter: [
                                  CurrencyTextInputFormatter(
                                    symbol: '\$',
                                    decimalDigits: 2,
                                  )
                                ],
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    //salesTaxController.clear();
                                    salestotalPriceController.clear();
                                  } else if (salesTaxController.text != "" &&
                                      salesTaxController.text != '%') {
                                    String price = value.replaceAll("\$", "");
                                    price = price.replaceAll(",", "");
                                    double pri = double.parse(price);
                                    double taxval = double.parse(salesTaxController.text.replaceAll("%", ""));
                                    double val = (pri * taxval) / 100;
                                    salesTotalTaxController.text = '\$${val.toStringAsFixed(2)}';
                                    double totalprice = pri + val;
                                    salestotalPriceController.text =
                                    '\$${totalprice.toStringAsFixed(2)}';
                                  } else {
                                    salestotalPriceController.text = value;
                                  }
                                  calculatePayout();
                                },
                              ),
                            ],
                          ),
                       ),
                       const SizedBox(width: 16,),
                       Expanded(
                         child: SizedBox(
                           width: sizeWidth(context).width*0.50,
                           child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("tax".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  const SizedBox(height: 4,),
                                  WizzTextField(
                                    hint: "tax",
                                    textEditingController: salesTaxController,
                                    hintTextColor: ColorEnums.textDefaultLight,
                                    hintTextSize: 14,
                                    borderColor: ColorEnums.shadowDefaultLight,
                                    borderWidth: 1.0,
                                    textColor: ColorEnums.textDefaultLight,
                                    isObsecure: null,
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp(r"""
[0-9.]""")),
                                      TextInputFormatter.withFunction((oldValue, newValue) {
                                        try {
                                          final text = newValue.text;
                                          if (text.isNotEmpty) double.parse(text);
                                          return newValue.copyWith(
                                              text: "${newValue.text}%",
                                              selection: newValue.selection,
                                              composing: newValue.composing);
                                        } catch (e) {}
                                        return oldValue;
                                      }),
                                    ],
                                    onChanged: (value) {
                                      if (value != '%' &&
                                          salesPriceController.text != "") {
                                        String price = salesPriceController.text.replaceAll("\$", "");
                                        price = price.replaceAll(",", "");
                                        double pri = double.parse(price);
                                        double taxval = double.parse(value.replaceAll("%", ""));
                                        double val = (pri * taxval) / 100;
                                        salesTotalTaxController.text = '\$${val.toStringAsFixed(2)}';
                                        double totalprice = pri + val;
                                        salestotalPriceController.text =
                                        '\$${totalprice.toStringAsFixed(2)}';
                                      } else {
                                        salesTotalTaxController.text = '';
                                        salestotalPriceController.text = salesPriceController.text;
                                      }
                                      calculatePayout();
                                    },
                                  ),
                                ],
                              ),
                         ),
                       )

                    ],

                ),
                const SizedBox(height: 16,),
                Row(
                  children: [
                     SizedBox(
                       width: sizeWidth(context).width*0.40,
                       child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("totalPrice".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            const SizedBox(height: 4,),
                            WizzTextField(
                              hint: "totalPrice",
                              textEditingController: salestotalPriceController,
                              hintTextColor: ColorEnums.textDefaultLight,
                              hintTextSize: 14,
                              borderColor: ColorEnums.shadowDefaultLight,
                              borderWidth: 1.0,
                              textColor: ColorEnums.textDefaultLight,
                              isObsecure: null,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatter: [CurrencyTextInputFormatter(symbol: '\$')],
                              onChanged: (text) {
                              },
                            ),
                          ],
                        ),
                     ),
                    const SizedBox(width: 16,),
                     Expanded(
                       child: SizedBox(
                         width: sizeWidth(context).width*0.50,
                         child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("salesTax".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                                WizzTextField(
                                  hint: "salesTax",
                                  textEditingController: salesTotalTaxController,
                                  hintTextColor: ColorEnums.textDefaultLight,
                                  hintTextSize: 14,
                                  borderColor: ColorEnums.shadowDefaultLight,
                                  borderWidth: 1.0,
                                  textColor: ColorEnums.textDefaultLight,
                                  isObsecure: null,
                                  onChanged: (text) {
                                  },
                                ),
                              ],
                            ),
                       ),
                     )
                  ],
                ),
                const SizedBox(height: 16,),
                Visibility(
                  visible: visibilityDownFinance,
                  child:  Row(
                        children: [
                         SizedBox(
                           width:sizeWidth(context).width*0.40,
                           child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("downPayment".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  const SizedBox(height: 4,),
                                  WizzTextField(
                                    hint: "downPayment",
                                    textEditingController: salesDownController,
                                    hintTextColor: ColorEnums.textDefaultLight,
                                    hintTextSize: 14,
                                    borderColor: ColorEnums.shadowDefaultLight,
                                    borderWidth: 1.0,
                                    textColor: ColorEnums.textDefaultLight,
                                    isObsecure: null,
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    inputFormatter: [CurrencyTextInputFormatter(symbol: '\$')],
                                    onChanged: (text) {
                                      calculatePayout();
                                    },
                                  ),
                                ],
                              ),
                         ),
                          const SizedBox(width: 16,),
                          Expanded(
                              child: SizedBox(
                                width: sizeWidth(context).width*0.50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("downPaymentType".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
                                    const SizedBox(height: 4,),
                                    GestureDetector(
                                      onTap: (){
                                        clearFocus(context);
                                        showPickerDialog(distributor!.downtype ?? [], "DOWNTYPE");
                                      },
                                      child: Container(
                                        width: sizeWidth(context).width,
                                        decoration: containerDecoration(context),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(selectedPaymentType,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              )
                          )
                        ],
                      )
                  ),
                const SizedBox(height: 16,),

                Visibility(
                  visible: visibilityMoreFinance,
                  child:  Column(
                        children: [
                          Row(
                            children: [
                               SizedBox(
                                 width:sizeWidth(context).width*0.40,
                                 child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("financeAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                        const SizedBox(height: 4,),
                                        WizzTextField(
                                          hint: "financeAmount",
                                          textEditingController: salesFinancedAmountController,
                                          hintTextColor: ColorEnums.textDefaultLight,
                                          hintTextSize: 14,
                                          borderColor: ColorEnums.shadowDefaultLight,
                                          borderWidth: 1.0,
                                          textColor: ColorEnums.textDefaultLight,
                                          isObsecure: null,
                                          isEnabled: false,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          inputFormatter: [CurrencyTextInputFormatter(symbol: '\$')],
                                          onChanged: (value) {
                                          },
                                        ),
                                      ],
                                    ),
                               ),

                              const SizedBox(width: 16,),
                              Expanded(
                                child: SizedBox(
                                  width: sizeWidth(context).width*0.50,
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("financeBy".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                      const SizedBox(height: 4,),
                                      WizzTextField(
                                        hint: "financeBy",
                                        textEditingController: salesFinancebyController,
                                        hintTextColor: ColorEnums.textDefaultLight,
                                        hintTextSize: 14,
                                        borderColor: ColorEnums.shadowDefaultLight,
                                        borderWidth: 1.0,
                                        textColor: ColorEnums.textDefaultLight,
                                        isObsecure: null,
                                        onChanged: (text) {
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                           const SizedBox(height: 16,),
                           Row(
                              children: [
                                SizedBox(
                                  width: sizeWidth(context).width*0.4,
                                  child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("approvedFinance".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          const SizedBox(height: 4,),
                                          WizzTextField(
                                            hint: "approvedFinance",
                                            textEditingController: salesFinancepercentageController,
                                            hintTextColor: ColorEnums.textDefaultLight,
                                            hintTextSize: 14,
                                            borderColor: ColorEnums.shadowDefaultLight,
                                            borderWidth: 1.0,
                                            textColor: ColorEnums.textDefaultLight,
                                            isObsecure: null,
                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                            inputFormatter: [
                                              FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                              TextInputFormatter.withFunction((oldValue, newValue) {
                                                try {
                                                  final text = newValue.text;
                                                  if (text.isNotEmpty) double.parse(text);
                                                  return newValue.copyWith(
                                                      text: "${newValue.text}%",
                                                      selection: newValue.selection,
                                                      composing: newValue.composing);
                                                } catch (e) {}
                                                return oldValue;
                                              }),
                                            ],
                                            onChanged: (value) {
                                              calculatePayout();
                                            },
                                          ),
                                        ],
                                      ),
                                ),

                                const SizedBox(width: 16,),
                                Expanded(
                                  child: SizedBox(
                                    width: sizeWidth(context).width*0.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("reserve".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                        const SizedBox(height: 4,),
                                        WizzTextField(
                                          hint: "reserve",
                                          textEditingController: salesReserveController,
                                          hintTextColor: ColorEnums.textDefaultLight,
                                          hintTextSize: 14,
                                          borderColor: ColorEnums.shadowDefaultLight,
                                          borderWidth: 1.0,
                                          textColor: ColorEnums.textDefaultLight,
                                          isObsecure: null,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          inputFormatter: [CurrencyTextInputFormatter(symbol: '\$')],
                                          onChanged: (text) {
                                            calculatePayout();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 16,),
                          Row(
                            children: [
                               SizedBox(
                                 width: sizeWidth(context).width*0.4,
                                 child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("fee1".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                      const SizedBox(height: 4,),
                                      WizzTextField(
                                        hint: "fee1",
                                        textEditingController: salesFee1Controller,
                                        hintTextColor: ColorEnums.textDefaultLight,
                                        hintTextSize: 14,
                                        borderColor: ColorEnums.shadowDefaultLight,
                                        borderWidth: 1.0,
                                        textColor: ColorEnums.textDefaultLight,
                                        isObsecure: null,
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        inputFormatter: [CurrencyTextInputFormatter(symbol: '\$')],
                                        onChanged: (text) {
                                          calculatePayout();
                                        },
                                      ),
                                    ],

                                 ),
                               ),
                              const SizedBox(width: 16,),
                              Expanded(
                                  child: SizedBox(
                                    width: sizeWidth(context).width*0.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("fee2".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                        const SizedBox(height: 4,),
                                        WizzTextField(
                                          hint: "fee2",
                                          textEditingController: salesFee2Controller,
                                          hintTextColor: ColorEnums.textDefaultLight,
                                          hintTextSize: 14,
                                          borderColor: ColorEnums.shadowDefaultLight,
                                          borderWidth: 1.0,
                                          textColor: ColorEnums.textDefaultLight,
                                          isObsecure: null,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          inputFormatter: [CurrencyTextInputFormatter(symbol: '\$')],
                                          onChanged: (text) {
                                            calculatePayout();
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                              )
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("otherDeduction".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                    const SizedBox(height: 4,),
                                    WizzTextField(
                                      hint: "otherDeduction",
                                      textEditingController: salesOtherDeductionsController,
                                      hintTextColor: ColorEnums.textDefaultLight,
                                      hintTextSize: 14,
                                      borderColor: ColorEnums.shadowDefaultLight,
                                      borderWidth: 1.0,
                                      textColor: ColorEnums.textDefaultLight,
                                      isObsecure: null,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      inputFormatter: [CurrencyTextInputFormatter(symbol: '\$')],
                                      onChanged: (text) {
                                        calculatePayout();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16,),
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("estimatedWoTax".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                      const SizedBox(height: 4,),
                                      WizzTextField(
                                        hint: "estimatedWoTax",
                                        textEditingController: salesNetpriceController,
                                        hintTextColor: ColorEnums.textDefaultLight,
                                        hintTextSize: 14,
                                        borderColor: ColorEnums.shadowDefaultLight,
                                        borderWidth: 1.0,
                                        textColor: ColorEnums.textDefaultLight,
                                        isObsecure: null,
                                        onChanged: (text) {
                                        },
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("estimatedCommission".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(height: 4,),
                              WizzTextField(
                                hint: "estimatedCommission",
                                textEditingController: salesComisionController,
                                hintTextColor: ColorEnums.textDefaultLight,
                                hintTextSize: 14,
                                borderColor: ColorEnums.shadowDefaultLight,
                                borderWidth: 1.0,
                                textColor: ColorEnums.textDefaultLight,
                                isObsecure: null,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatter: [CurrencyTextInputFormatter(symbol: '\$')],
                                onChanged: (text) {
                                },
                              ),
                            ],
                          ),

                        ],
                      )
                  ),
                const SizedBox(height: 16,),

              ],
            ),
          ),

         Align(
              alignment: Alignment.bottomCenter,
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
                       nextPage();
                    },
                    style: elevatedButtonStyle(context),
                    child: Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  )
                ],
              ),

        ),
      ],
    );
  }
  nextPage(){
    String price = salesPriceController.text.replaceAll("\$", "");
    price = price.replaceAll(",", "");
    String totalPrice = salestotalPriceController.text.replaceAll("\$", "");
    totalPrice = totalPrice.replaceAll(",", "");
    String salesTax = salesTaxController.text.replaceAll("%", "");
    if(selectedLeadType.isNotEmpty && selectedLeadType !="Select" && price.isNotEmpty && totalPrice.isNotEmpty){
      String reserve = salesReserveController.text.replaceAll("\$", "");
      reserve = reserve.replaceAll(",", "");
      SaleVM.addSaleModel.reserve = reserve;
      String otherDeductions = salesOtherDeductionsController.text.replaceAll("\$", "");
      otherDeductions = otherDeductions.replaceAll(",", "");
      SaleVM.addSaleModel.otherDeductions = otherDeductions;
      String netprice = salesNetpriceController.text.replaceAll("\$", "");
      netprice = netprice.replaceAll(",", "");
      SaleVM.addSaleModel.netprice = netprice;
      String comision = salesComisionController.text.replaceAll("\$", "");
      comision = comision.replaceAll(",", "");
      SaleVM.addSaleModel.comision = comision;
      SaleVM.addSaleModel.price = price;
      String down = salesDownController.text.replaceAll("\$", "");
      down = down.replaceAll(",", "");
      SaleVM.addSaleModel.down = down;
      String fee1 = salesFee1Controller.text.replaceAll("\$", "");
      fee1 = fee1.replaceAll(",", "");
      SaleVM.addSaleModel.fee1 = fee1;
      String fee2 = salesFee2Controller.text.replaceAll("\$", "");
      fee2 = fee2.replaceAll(",", "");
      SaleVM.addSaleModel.fee2 = fee2;
      String tax = salesTaxController.text.replaceAll("%", "");
      tax = tax.replaceAll(",", "");
      SaleVM.addSaleModel.tax = tax;
      String percentage = salesFinancepercentageController.text.replaceAll("%", "");
      percentage = percentage.replaceAll(",", "");
      SaleVM.addSaleModel.financepercentage = percentage;
      SaleVM.addSaleModel.financeby = salesFinancebyController.text;
      SaleVM.addSaleModel.totalPrice = totalPrice.replaceAll(",", "");
      widget.continueClick!();
    }else{
      snackBarDesign(context, StringUtil.error, "requiredPriceAndLead".tr());
    }
  }

  calculatePayout() {
    double resvp = 0;
    double pri = 0;
    double tPri = 0;
    double per = 0;
    double oded = 0;
    double fee1 = 0;
    double fee2 = 0;
    double down = 0;
    double val2 = 0;

    if ((salesPriceController.text != "") &&
        (salesPriceController.text != "\$")) {
      String price = salesPriceController.text.replaceAll("\$", "");
      price = price.replaceAll(",", "");
      pri = double.parse(price);
    }
    if ((salesOtherDeductionsController.text != "") &&
        (salesOtherDeductionsController.text != "\$")) {
      String val1 = salesOtherDeductionsController.text.replaceAll("\$", "");
      val1 = val1.replaceAll(",", "");
      oded = double.parse(val1);
    }
    if ((salesFee1Controller.text != "") &&
        (salesFee1Controller.text != "\$")) {
      String val1 = salesFee1Controller.text.replaceAll("\$", "");
      val1 = val1.replaceAll(",", "");
      fee1 = double.parse(val1);
    }
    if ((salesFee2Controller.text != "") &&
        (salesFee2Controller.text != "\$")) {
      String val1 = salesFee2Controller.text.replaceAll("\$", "");
      val1 = val1.replaceAll(",", "");
      fee2 = double.parse(val1);
    }
    if ((salesDownController.text != "") &&
        (salesDownController.text != "\$")) {
      String val1 = salesDownController.text.replaceAll("\$", "");
      val1 = val1.replaceAll(",", "");
      down = double.parse(val1);
    }
    if ((salestotalPriceController.text != "") &&
        (salestotalPriceController.text != "\$")) {

      String totalPrice = salestotalPriceController.text.replaceAll("\$", "");
      totalPrice = totalPrice.replaceAll(",", "");
      tPri = double.parse(totalPrice);
    }
    if ((salesFinancepercentageController.text != null) &&
        (salesFinancepercentageController.text != "") &&
        (salesFinancepercentageController.text != "%")) {

      //financed percantage
      per = double.parse(salesFinancepercentageController.text.replaceAll("%", ""));
    }
    if ((salesReserveController.text != "") &&
        (salesReserveController.text != "\$")) {
      String reserve = salesReserveController.text.replaceAll("\$", "");
      reserve = reserve.replaceAll(",", "");
      resvp = double.parse(reserve);
    }

    if (selectedFinance == 'Financed') {
      //tpri = totalPrice
      // down = downPayment
      double val = tPri - down;
      //financed amount
      salesFinancedAmountController.text = '\$${val.toStringAsFixed(2)}';



      //tpri = totalPrice
      // down = downPayment
      //pri = salesprices
      //per = Financed Percantage
      //resvp = reserve
      //fee1 = fee1
      //fee2 = fee2
      //oded = Other Deductions

      if (per > 0) {
        val2 = pri - ((tPri - down) * (100 - per) / 100) - resvp - fee1 - fee2 - oded;
        // 2240 + down - 240
        //val2 = ((tPri - down) * (per / 100))+down - salesTax;
      } else {
        val2 = pri - resvp - fee1 - fee2 - oded;
      }

      //estimated payout
      salesNetpriceController.text = '\$${val2.toStringAsFixed(2)}';

    } else if ((selectedFinance == 'Credit Card') ||
        (selectedFinance == 'Check')) {
      double val = pri - fee1 - fee2 - oded;
      salesNetpriceController.text = '\$${val.toStringAsFixed(2)}';
    } else {
      double val = pri - fee1 - fee2 - oded;
      salesNetpriceController.text = '\$${val.toStringAsFixed(2)}';
    }
  }
  void _changevisibility() {
    if (selectedFinance == 'Financed') {
      visibilityMoreFinance = true;
      visibilityDownFinance = true;
      calculatePayout();
    } else if ((selectedFinance == 'Credit Card') ||
        (selectedFinance == 'Check')) {
      visibilityMoreFinance = false;
      visibilityDownFinance = true;
      calculatePayout();
    } else {
      visibilityMoreFinance = false;
      visibilityDownFinance = false;
      calculatePayout();
    }
  }
  showPickerDialog(List<DistributorSubType> list, String type) {
    ViewUtil.showCustomDialog(
        context,
        MyDialog(
            list,
            type,
            context,
            reloadContext
        )
    );
  }

  reloadContext(String selectedValue, String type) {
    setState(() {
      if (type == "DOWNTYPE") {
        selectedPaymentType = selectedValue;
      } else if (type == "LEADTYPE") {
        selectedLeadType = selectedValue;
      } else if (type == "FINANCE") {
        selectedFinance = selectedValue;
      }
      _changevisibility();
    });
  }


}
class MyDialog extends StatefulWidget {
  List<DistributorSubType> list = [];
  String type;
  BuildContext mcontext;
  void Function(String, String)? callBack;

  MyDialog(this.list, this.type, this.mcontext, this.callBack, {super.key});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController editingController = TextEditingController();

  List<DistributorSubType> tempList = [];
  List<DistributorSubType> liste = [];

  Sale? qualifySale;
  String? type;

  @override
  Widget build(BuildContext context) {
    qualifySale = SaleVM.addSaleModel;
    type = widget.type;
    liste = widget.list;

    var title = "";
    if (widget.type == "FINANCE" ||
        widget.type == "LEADTYPE" ||
        widget.type == "DOWNTYPE") {
      title = "Other";
    } else {
      title = "None";
    }
    if (liste.where((element) => element.name == title).isEmpty) {
      DistributorSubType subtype = DistributorSubType();
      subtype.id = 0;
      subtype.name = title;
      liste.add(subtype);
    }

    if (tempList.isEmpty) {
      tempList.addAll(liste);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          height: 44,
          child:  WizzTextField(
            hint: "search",
            textEditingController: editingController,
            hintTextColor: ColorEnums.textDefaultLight,
            hintTextSize: 14,
            borderColor: ColorEnums.textDefaultLight,
            borderWidth: 1.0,
            textColor: ColorEnums.textDefaultLight,
            leadingIconColor: ColorEnums.textDefaultLight,
            onChanged: (value) {
              tempList.clear();
              if (value.isNotEmpty) {
                for (var item in liste) {
                  if (item.name != null ? item.name!.toLowerCase().contains(value.toLowerCase()) : false) {
                    tempList.add(item);
                  }
                }
                setState(() {});
              } else {
                setState(() {
                  tempList.clear();
                  tempList.addAll(liste);
                });
              }
            },
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: tempList.length,
                itemBuilder: (BuildContext context, int index) {
                  DistributorSubType item = tempList[index];
                  return InkWell(
                      onTap: () {
                        int? itemId;
                        if (item.id != null) {
                          itemId = item.id;
                        }
                        if (type == "DOWNTYPE") {
                          if (itemId != null) {
                            qualifySale!.downType = itemId;
                          } else {
                            qualifySale!.downType = null;
                          }
                        } else if (type == "LEADTYPE") {
                          if (itemId != null) {
                            qualifySale!.leadtype = itemId;
                          } else {
                            qualifySale!.leadtype = null;
                          }
                        } else if (type == "FINANCE") {
                          if (itemId != null) {
                            qualifySale!.finance = itemId;
                          } else {
                            qualifySale!.finance = null;
                          }
                        }
                        widget.callBack!(item.name ?? "Select", type ?? "");
                        Navigator.pop(widget.mcontext);
                      },
                      child: ListTile(
                        title: Text(item.name ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      ));
                })
        )
      ],
    );
  }
}