import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Sale.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/view/sale/mySalePages/mySaleApproved.dart';
import 'package:wizzsales/view/sale/mySalePages/mySalePending.dart';
import 'package:wizzsales/view/sale/mySalePages/mySaleTotalSale.dart';
import 'package:wizzsales/viewModel/OLD/SalelistMobx.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../../utils/style/CustomTextStyle.dart';

class MySaleTab extends StatefulWidget {
  final int initialIndex;
  const MySaleTab(this.initialIndex,{super.key});

  @override
  State<MySaleTab> createState() => _MySaleTabState();
}

class _MySaleTabState extends State<MySaleTab> {
  SaleOfficeMobx saleListMobx = SaleOfficeMobx();
  List<Sale> sales=[];
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
        initialIndex: widget.initialIndex,
        length: 3,
        child:Observer(
          builder: (_){
            if(saleListMobx.approvedMySale == null || saleListMobx.pendingMySale ==null){
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
                    title: Text("mySale".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    actions: [
                      IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/${PageName.addSale}',arguments: {'demoId':null});

                        },
                        icon: Icon(Icons.add, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                        ,
                      )
                    ],
                    bottom:TabBar(
                      dividerColor: AppColors.transparant,
                      labelStyle: CustomTextStyle().semiBold12(AppColors.wizzColor),
                      unselectedLabelStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                      indicatorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                      labelColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                      unselectedLabelColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                      tabs:  [

                        Tab(child: Text("${context.tr("totalSales")}: ${saleListMobx.approvedMySale!.total!+saleListMobx.pendingMySale!.total!}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                        Tab(child: Text(context.tr("approved"),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                        Tab(child: Text("${context.tr("pending")}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),

                      ],
                    ),
                  ),
                ),
                body: Container(
                  color: ColorUtil().getColor(context, ColorEnums.background),
                  child:   TabBarView(
                    children: [
                      MySaleTotalSale(sales),
                      const MySaleApproved(),
                      const MySalePending(),

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
    await saleListMobx.getApprovedMySale(context,1);
    await saleListMobx.getPendingMySale(context,1);

    sales.addAll(saleListMobx.approvedMySale!.data!+saleListMobx.pendingMySale!.data!);


  }
}
