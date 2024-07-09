import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import '../../adminPage/adminModel/commissionModel/commissionWinner.dart';
import '../../adminPage/adminVm/commissionVm.dart';
import '../../constants/AppColors.dart';
import '../../constants/ColorsUtil.dart';
import '../../utils/res/PageName.dart';
import '../../utils/style/ColorEnums.dart';
import '../../utils/style/CustomTextStyle.dart';
import '../../utils/style/WidgetStyle.dart';
import '../../widgets/Constant.dart';
import '../../widgets/WidgetExtension.dart';

class MyCommission extends BaseStatefulPage {
  const MyCommission(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _MyCommissionState();
}

class _MyCommissionState extends BaseStatefulPageState<MyCommission> {
  CommissionVm viewModel = CommissionVm();
  ScrollController controller = ScrollController();
  double totalSalesPrice=0.0;
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
          if(viewModel.commissionWinner == null || viewModel.comDetails == null){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        border: Border.all(color: ColorUtil().getColor(context,ColorEnums.wizzColor), width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  viewModel.setPaidUnPaidCom(0);
                                },
                                child:  Container(
                                  color:viewModel.currentDay=="daily".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("daily".tr(), style: CustomTextStyle().bold10(AppColors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  viewModel.setPaidUnPaidCom(1);
                                },
                                child:  Container(
                                  color:viewModel.currentDay=="weekly".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("weekly".tr(), style:
                                      CustomTextStyle().bold10(AppColors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  viewModel.setPaidUnPaidCom(2);
                                },
                                child:  Container(
                                  color:viewModel.currentDay=="monthly".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("monthly".tr(), style:
                                      CustomTextStyle().bold10(AppColors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  viewModel.setPaidUnPaidCom(3);
                                },
                                child:  Container(
                                  color:viewModel.currentDay=="annual".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("annual".tr(), style:
                                      CustomTextStyle().bold10(AppColors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: sizeWidth(context).width*0.3,
                                child: Column(
                                  children: [
                                    Text("approvedComm".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    Text("\$${moneyFormat(viewModel.totalPaid)}",style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: sizeWidth(context).width*0.3,
                                child: Column(
                                  children: [
                                    Text("pendingComm".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    Text("\$${moneyFormat(viewModel.totalUnPaid)}",style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: sizeWidth(context).width*0.3,
                                child: Column(
                                  children: [
                                    Text("total".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    Text("\$${moneyFormat(totalSalesPrice)}",style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                  ],
                                ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: sizeWidth(context).width*0.6,
                        child: TextField(
                          onChanged: (newValue){
                            viewModel.setQuery(newValue);
                            viewModel.searchAllCom(viewModel.commissionWinner!,viewModel.query);
                          },
                          decoration: searchTextDesign(context, "search"),
                          cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/${PageName.commReport}');
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("seeReport".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                      )
                    ],
                  ),


                  const SizedBox(height: 4,),
                  RefreshIndicator(
                    onRefresh:getList,
                    color:ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: RawScrollbar(
                      thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      thumbVisibility: true,
                      thickness: 1,
                      trackVisibility: true,
                      controller: controller,
                      child: SizedBox(
                        height: justList(context, sizeWidth(context).height),
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.searchAllCom(viewModel.commissionWinner!,viewModel.query).length,
                          itemBuilder: (context,index){
                            int startIndex = (viewModel.searchAllCom(viewModel.commissionWinner!,viewModel.query).length == 1) ? 1 : viewModel.searchAllCom(viewModel.commissionWinner!,viewModel.query).length;
                            List<int> indices = List.generate(viewModel.searchAllCom(viewModel.commissionWinner!,viewModel.query).length, (index) => startIndex - index);
                            CommissionWinner model = viewModel.searchAllCom(viewModel.commissionWinner!,viewModel.query)[index];
                            return Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(indices[index].toString(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("commCalcDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(mmDDYDateTime(model.commCalculatedAt),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("cName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.userName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("repName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.userName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("role".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.eligibleRoleName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.6,
                                          child: Text("enterSerialNumber".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.saleSerialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("salesPrice".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text("\$${model.salePrice ?? "0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),


                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.4,
                                          child: Text("comAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        model.comType =="AMOUNT" ?

                                        Text("\$${model.commAdjustAmount ?? model.commAmount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            :
                                        Text("\$${model.commAdjustAmount ?? model.commAmount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("isPaid?".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.isCommPaid == true ? "Paid" :"UnPaid",style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    if(model.isCommPaid ==true)
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.3,
                                                child: Text("payDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(mmDDYDate(model.payAt ?? ""),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),



                                  ],
                                ),
                            ]
                              ),
                            ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  Future<void>getList()async{
    await viewModel.getComWinner(context,null,null,null);
    await viewModel.getComReport(context);

    totalSalesPrice =0.0;

    for(int i=0;i<viewModel.commissionWinner!.length;i++){
      CommissionWinner winner = viewModel.commissionWinner![i];
      totalSalesPrice +=double.parse(winner.salePrice ?? "0.00");
    }
    dynamic y=0.0;
    dynamic z=0.0;

    for(int i=0;i<viewModel.commissionWinner!.length;i++){
      totalSalesPrice +=double.parse(viewModel.commissionWinner![i].salePrice ?? "0.00");
      if(viewModel.commissionWinner![i].isCommPaid == true){
        y +=double.parse(viewModel.commissionWinner![i].commAdjustAmount ?? viewModel.commissionWinner![i].commAmount ?? "0.00");
      }
      else{
        z +=double.parse(viewModel.commissionWinner![i].commAdjustAmount ?? viewModel.commissionWinner![i].commAmount ?? "0.00");
      }
    }
    viewModel.setPaidCom(y, z);
  }

}
