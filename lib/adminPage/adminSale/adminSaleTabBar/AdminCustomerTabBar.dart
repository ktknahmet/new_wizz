import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wizzsales/adminPage/adminSale/adminCustomer/AdminCustomerApproved.dart';
import 'package:wizzsales/adminPage/adminSale/adminCustomer/AdminCustomerCancel.dart';
import 'package:wizzsales/adminPage/adminSale/adminCustomer/AdminCustomerPending.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Sale.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/view/sale/officeSalePages/officeTotalSale.dart';
import 'package:wizzsales/viewModel/OLD/SalelistMobx.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AdminCustomerSaleTab extends StatefulWidget {
  final String? type;
  const AdminCustomerSaleTab(this.type,{super.key});

  @override
  State<AdminCustomerSaleTab> createState() => _AdminCustomerSaleTabState();
}

class _AdminCustomerSaleTabState extends State<AdminCustomerSaleTab> {
  SaleOfficeMobx saleListMobx = SaleOfficeMobx();
  final List<Sale> sales=[];
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
      body: DefaultTabController(
          initialIndex: 0,
          length: 4,
          child: Observer(
            builder: (_){
              if(saleListMobx.pendingSale == null || saleListMobx.approvedSale ==null){
                return spinKit(context);
              }else{
                return Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(sizeWidth(context).height*0.12),
                    child: AppBar(
                      elevation: 0.0,
                      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                      leading: BackButton(
                          color: ColorUtil().getColor(context, ColorEnums.textTitleLight)
                      ),
                      title: Text("customerDetails".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      actions: [
                        IconButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/${PageName.addSale}',arguments: {'demoId':null});

                          },
                          icon: Icon(Icons.add, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                          ,
                        )
                      ],
                      bottom: TabBar(
                        isScrollable:true,
                        dividerColor: AppColors.transparant,
                        labelStyle: CustomTextStyle().semiBold12(AppColors.wizzColor),
                        unselectedLabelStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                        indicatorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                        labelColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                        unselectedLabelColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                        tabs:  [
                          Tab(child: Text(context.tr("totalCustomer"),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                          Tab(child: Text(context.tr("approvedCustomer"),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                          Tab(child: Text(context.tr("pendingCustomer"),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                          Tab(child: Text(context.tr("cancel"),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),

                        ],
                      ),
                    ),
                  ),
                  body: Container(
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    child:   TabBarView(
                      children: [
                        OfficeTotalSale(sales),
                        AdminCustomerApproved(widget.type),
                        AdminCustomerPending(widget.type),
                        AdminCustomerCancel(widget.type),

                      ],
                    ),
                  ),

                );
              }
            },
          )
      ),
    );
  }
  Future<void> getList()async{
    await saleListMobx.getPendingSale(context,1);
    await saleListMobx.getApprovedSale(context,1);

    sales.addAll(saleListMobx.approvedSale!.data!+saleListMobx.pendingSale!.data!);
    print("veriler :${saleListMobx.approvedSale!.total} -- ${saleListMobx.pendingSale!.total}");
  }
}