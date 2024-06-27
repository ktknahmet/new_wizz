import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/model/OLD/Sale.dart';
import 'package:wizzsales/utils/notification/NotificationUtils.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/viewModel/OLD/SalelistMobx.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/OldViewUtis.dart';
import '../../../constants/colorsUtil.dart';
// ignore_for_file: use_build_context_synchronously

class CompleteSale extends StatefulWidget {
   final void Function(int)? page;

   const CompleteSale({super.key,this.page});

  @override
  State<CompleteSale> createState() => _CompleteSaleState();
}

class _CompleteSaleState extends State<CompleteSale> {
  SaleOfficeMobx mobx = SaleOfficeMobx();

  String finance = "";
  String leadType = "";
  String downType = "";
  String calculatedTax = "";
  String financeAmount = "";

  bool visibilityDownFinance = false;
  bool visibilityMoreFinance = false;

  @override
  void initState() {
    userInfo();
    if (ViewUtil.finance.isNotEmpty && SaleVM.addSaleModel.finance != null) {
      finance = ViewUtil.finance.where((element) => element.id == SaleVM.addSaleModel.finance).first.name ?? "";
    } else {
      finance = "N / A";
    }
    if (ViewUtil.leadtype.isNotEmpty && SaleVM.addSaleModel.leadtype != null) {
      leadType = ViewUtil.leadtype.where((element) => element.id == SaleVM.addSaleModel.leadtype).first.name ?? "";
    } else {
      leadType = "N / A";
    }
    if (ViewUtil.downtype.isNotEmpty && SaleVM.addSaleModel.downType != null) {
      downType = ViewUtil.downtype.where((element) => element.id == SaleVM.addSaleModel.downType).first.name ?? "";
    } else {
      downType = "N / A";
    }

    if (SaleVM.addSaleModel.price != null &&
        SaleVM.addSaleModel.tax != null &&
        SaleVM.addSaleModel.tax!.isNotEmpty) {
      String price = SaleVM.addSaleModel.price!;
      price = price.replaceAll(",", "");
      double pri = double.parse(price);
      double taxval = double.parse(SaleVM.addSaleModel.tax!.replaceAll("%", ""));
      double val = (pri * taxval) / 100;
      calculatedTax = '\$${val.toStringAsFixed(2)}';
    }

    _changevisibility();
    if (visibilityMoreFinance && SaleVM.addSaleModel.totalPrice != null) {
      String totalPrice = SaleVM.addSaleModel.totalPrice!.replaceAll("\$", "");
      totalPrice = totalPrice.replaceAll(",", "");
      if (SaleVM.addSaleModel.down != null && SaleVM.addSaleModel.down!.isNotEmpty) {
        String val1 = SaleVM.addSaleModel.down!.replaceAll("\$", "");
        val1 = val1.replaceAll(",", "");
        financeAmount = (double.parse(totalPrice) - double.parse(val1)).toString();
      } else {
        financeAmount = totalPrice;
      }
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  SingleChildScrollView(
        child: Column(
                  children: [
                    SizedBox(
                        width: sizeWidth(context).width*0.25,
                        height: sizeWidth(context).height*0.12,
                        child:SaleVM.addSaleModel.imageFile != null ?
                        ClipOval(
                            child:Image.file(SaleVM.addSaleModel.imageFile!,fit: BoxFit.fill,height: 96,)
                        ) : ClipOval(
                            child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                        )
                    ),
                    const SizedBox(height: 16,),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 12,
                              width: 12,
                              child: Icon(Icons.date_range,
                                color: ColorUtil().getColor(context, ColorEnums.wizzColor),),),
                            const SizedBox(width: 16,),
                            Text(DateFormat('MMM d,y HH:mm').format(DateTime.parse(SaleVM.addSaleModel.date!)),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 12,
                              width: 12,
                              child: Icon(Icons.person,
                                color: ColorUtil().getColor(context, ColorEnums.wizzColor),),),
                            const SizedBox(width: 16,),
                            Text(leadType,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                          ],
                        ),
        
                      ],
                    ),
                    const SizedBox(height: 16,),
        
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("customerInfo".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
                    Divider(
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    ),
                    const SizedBox(height: 4,),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                          VerticalDivider(
                            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            thickness: 1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("customer".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(height: 4,),
                              Text("${SaleVM.addSaleModel.cfirstname ?? ""} ${SaleVM.addSaleModel.clastname ?? ""}",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.email_outlined,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                          VerticalDivider(
                            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            thickness: 1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("email".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(height: 4,),
                              Text(SaleVM.addSaleModel.cemail ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8,),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.phone,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                          VerticalDivider(
                            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            thickness: 1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("phone".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(height: 4,),
                              Text(SaleVM.addSaleModel.cphone ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("spouseInfo".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
                    Divider(
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    ),
                    const SizedBox(height: 4,),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                          VerticalDivider(
                            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            thickness: 1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("customer".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(height: 4,),
                              Text("${SaleVM.addSaleModel.sfirstname ?? ""} ${SaleVM.addSaleModel.slastname ?? ""}",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4,),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.email_outlined,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                          VerticalDivider(
                            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            thickness: 1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("email".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(height: 4,),
                              Text(SaleVM.addSaleModel.semail ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4,),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.phone,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                          VerticalDivider(
                            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            thickness: 1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("phone".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(height: 4,),
                              Text(SaleVM.addSaleModel.sphone ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("financialInfo".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
                    Divider(
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    ),
                    Column(
                      children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("paymentType".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                               const SizedBox(height: 2,),
        
                               Text(finance,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                             ],
                           ),
                         ],
                       ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("salesPrice".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
        
                                Text("\$ ${SaleVM.addSaleModel.price ?? "0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("tax".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
        
                                Text(SaleVM.addSaleModel.tax ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("totalPrice".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
        
                                Text("\$ ${SaleVM.addSaleModel.totalPrice ?? "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("tax".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
        
                                Text(calculatedTax,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("fee1".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
        
                                Text("\$ ${SaleVM.addSaleModel.fee1 != null && SaleVM.addSaleModel.fee1!.isNotEmpty ? SaleVM.addSaleModel.fee1 : "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("fee2".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
        
                                Text("\$ ${SaleVM.addSaleModel.fee2 != null && SaleVM.addSaleModel.fee2!.isNotEmpty ? SaleVM.addSaleModel.fee2 : "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("otherDeduction".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
        
                                Text("\$ ${SaleVM.addSaleModel.otherDeductions != null && SaleVM.addSaleModel.otherDeductions!.isNotEmpty ? SaleVM.addSaleModel.otherDeductions : "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("estimatedPayout".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
        
                                Text("\$ ${SaleVM.addSaleModel.netprice ?? "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("estimatedCommission".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
        
                                Text("\$ ${SaleVM.addSaleModel.comision ?? "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
        
                              ],
                            ),
        
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("salesNote".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
                    Divider(
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    ),
                    SizedBox(
                      width: sizeWidth(context).width*0.80,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:Text(SaleVM.addSaleModel.note ?? "",style: CustomTextStyle().regular14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("addressInformation".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
                    Divider(
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    ),
                    Container(
                      width: sizeWidth(context).width,
                      margin: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(SaleVM.addSaleModel.czipcode ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              const SizedBox(width: 8,),
                              Text(SaleVM.addSaleModel.caddress ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            ],
                          ),
                          Text("${SaleVM.addSaleModel.ccity ?? ""}, ${SaleVM.addSaleModel.ccounty ?? ""}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          Text(SaleVM.addSaleModel.ccountry ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                        ],
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("salesTeam".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
                    Divider(
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    ),
                     Wrap(
                           spacing: sizeWidth(context).width*0.10,
                          children: [
                            Column(
                              children: [
                                ClipOval(
                                    child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                ),
                                const SizedBox(height: 4,),
                                Text("-",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                                const SizedBox(height: 2,),
                                Text("DST",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                              ],
                            ),
                            Column(
        
                              children: [
                                ClipOval(
                                    child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                ),
                                const SizedBox(height: 4,),
                                Text(SaleVM.addSaleModel.sm != null ? SaleVM.addSaleModel.sm!.name ?? "" : "-",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
                                Text("SM",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        
                              ],
                            ),
                            Column(
        
                              children: [
                                ClipOval(
                                    child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                ),
                                const SizedBox(height: 4,),
                                Text(SaleVM.addSaleModel.dps != null ? SaleVM.addSaleModel.dps!.name ?? "" : "-",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
                                Text("DPS",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              ],
                            ),
                          ],
                        ),
        
        
                    const SizedBox(height: 8,),
                    Wrap(
                      spacing: sizeWidth(context).width*0.10,
                      children: [
                        Column(
                          children: [
                            ClipOval(
                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                            ),
                            const SizedBox(height: 4,),
                            Text(SaleVM.addSaleModel.leader != null ? SaleVM.addSaleModel.leader!.name ?? "" : "-",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            const SizedBox(height: 2,),
                            Text("TL",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          ],
                        ),
                        Column(
                          children: [
                            ClipOval(
                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                            ),
                            const SizedBox(height: 4,),
                            Text(SaleVM.addSaleModel.dealer != null ? SaleVM.addSaleModel.dealer!.name ?? "" : "-",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            const SizedBox(height: 2,),
                            Text("DL",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          ],
                        ),
                        Column(
                          children: [
                            ClipOval(
                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                            ),
                            const SizedBox(height: 4,),
                            Text(SaleVM.addSaleModel.da != null ? SaleVM.addSaleModel.da!.name ?? "" : "-",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            const SizedBox(height: 2,),
                            Text("DA",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: sizeWidth(context).width,
                      height: sizeWidth(context).height*0.10,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              widget.page!(8);
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("edit".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          ElevatedButton(
                            onPressed: () async{
                              await save();
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("complete".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          )
                        ],
                      ),
                    ),
        
        
          ],
        ),

    );
  }
  save()async{


    String salee =saleToJson(SaleVM.addSaleModel);
    print("salemodel :$salee  -- saleImage : ${SaleVM.addSaleModel.imageFile}");
   int saleId = await SaleVM.qualifySale(context, SaleVM.addSaleModel, SaleVM.addSaleModel.imageFile, SaleVM.addSaleModel.drawCode ?? "");

    print("saleId :$saleId");
    if(saleId !=0){
        NotificationUtil().showNotification(title: "Successful",body: "saleRegistered".tr());
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/${PageName.mainHome}',
              (Route<dynamic> route) => false,
        );
    }
  }

  userInfo() async{
    await mobx.getUserInfo(context);
    print("user bilgileri :${mobx.user!}");
  }
  void _changevisibility() {
    if (finance == 'Financed') {
      visibilityMoreFinance = true;
      visibilityDownFinance = true;
    } else if ((finance == 'Credit Card') ||
        (finance == 'Check')) {
      visibilityMoreFinance = false;
      visibilityDownFinance = true;
    } else {
      visibilityMoreFinance = false;
      visibilityDownFinance = false;
    }
  }
}
