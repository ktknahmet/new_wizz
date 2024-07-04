import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Sale.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';

class AdminSaleDetails extends StatefulWidget {
  final Sale sale;

  const AdminSaleDetails(this.sale,{super.key});

  @override
  State<AdminSaleDetails> createState() => _AdminSaleDetailsState();
}

class _AdminSaleDetailsState extends State<AdminSaleDetails> {
  dynamic taxPrice;
  @override
  void initState() {
    getValue();
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
      appBar: DefaultAppBar(name: "saleDetails".tr()),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
                    children: [
                      Card(
                        shape:cardShape(context),
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
                                      child: Text("cName".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(widget.sale.cname ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                      child: Text("cPhone".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                  GestureDetector(
                                    onTap: ()async{
                                      if(widget.sale.cphone !=null){
                                        openDialPad(widget.sale.cphone!);
                                      }
                                    },
                                    child:   Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                              width: sizeWidth(context).width*0.20,
                                              child: Text(widget.sale.cphone ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          SizedBox(
                                            width: sizeWidth(context).width*0.20,
                                            child: Divider(
                                              thickness: 2,
                                              color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                            ),
                                          )
                                        ],
                                      ),
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
                                      child: Text("enterSerialNumber".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(widget.sale.serialid ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Card(
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        shape: cardShape(context),
                        child:Column(
                          children: [
                            Text("paymentInfo".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width:sizeWidth(context).width*0.40,
                                              child: Text("salePrice".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                           Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text("\$${widget.sale.netprice ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                              child: Text("${context.tr("salesTax")} ${widget.sale.tax ?? "0.00"}%",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text("\$${getDecimalPlaces(taxPrice.toString(), 2)}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                              child: Text("netPrice".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                           Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text("\$${widget.sale.price ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                              child: Text("down".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(widget.sale.down ?? "0.00",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                              child: Text("otherDeduction".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                           Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(widget.sale.otherDeductions ?? "0.00",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                              child: Text("paymentMethod".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                           Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(financeType(widget.sale.finance ?? 10),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                              ],

                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                            ),
                          ],
                        ) ,
                      ),
                    ],
                  ),
            ),
          ),


    );
  }
  getValue()async{

    if(widget.sale.price !=null){
      taxPrice = (double.parse(widget.sale.price ?? "0.00") * double.parse(widget.sale.tax ?? "0.0")) / 100;
    }else{
      taxPrice ="";
    }
  }
}
