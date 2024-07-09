import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionWinner.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPost.dart';
import 'package:wizzsales/adminPage/adminVm/commissionVm.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../constants/AppColors.dart';
import '../../constants/colorsUtil.dart';

class SearchCommission extends BaseStatefulPage {
  const SearchCommission(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _SearchCommissionState();
}

class _SearchCommissionState extends BaseStatefulPageState<SearchCommission> {
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
            if(viewModel.commissionWinner == null){
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
                                Text("totalPaidCom".tr(), style: CustomTextStyle().semiBold12(AppColors.white)),
                                Text("\$${moneyFormat(viewModel.paidCom)}", style: CustomTextStyle().bold12(AppColors.white)),
                              ],
                            ),
                            const SizedBox(height: 4,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("totalUnPaidCom".tr(), style: CustomTextStyle().semiBold12(AppColors.white)),
                                Text("\$${moneyFormat(viewModel.unPaidCom)}", style: CustomTextStyle().bold12(AppColors.white)),
                              ],
                            ),
                            const SizedBox(height: 4,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("saleTotal".tr(), style: CustomTextStyle().semiBold12(AppColors.white)),
                                Text("${viewModel.commissionWinner!.length}", style: CustomTextStyle().bold12(AppColors.white)),
                              ],
                            ),
                            const SizedBox(height: 4,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("totalRevenue".tr(), style: CustomTextStyle().semiBold12(AppColors.white)),
                                Text("\$${moneyFormat(totalSalesPrice)}", style: CustomTextStyle().bold12(AppColors.white)),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: sizeWidth(context).width*0.7,
                          height: 50,
                          child: TextField(
                            onSubmitted: (newValue){
                              if(newValue.isNotEmpty){
                                viewModel.setQuery(newValue);
                                viewModel.searchAllCom(viewModel.commissionWinner!,viewModel.query);
                                getComValues();
                              }
                            },
                            decoration: searchTextDesign(context, "searchByNamePosition"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                        Container(
                          width: sizeWidth(context).width*0.2,
                          decoration: containerDecoration(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("total".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                Text(viewModel.searchAllCom(viewModel.commissionWinner!, viewModel.query).length.toString(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Container(
                      height: 40,
                      decoration: containerDecoration(context),
                      width: sizeWidth(context).width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                          underline: const SizedBox(),
                          hint: Row(
                            children: [
                              Text(viewModel.paidUnPaid,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ],
                          ),
                          value: viewModel.paidUnPaid,
                          onChanged: (newValue) async{
                            viewModel.setPaidUnpaid(newValue!);
                            viewModel.setQuery(newValue);
                            viewModel.searchAllCom(viewModel.commissionWinner!, newValue);
                            getComValues();

                          },
                          items: viewModel.paidUnPaidList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,

                              child: Row(
                                children: [
                                  Text(value,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
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
                              List<int> indices = List.generate(viewModel.commissionWinner!.length, (index) => startIndex - index);
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
                                          GestureDetector(
                                            onTap:()async{
                                              await getSaleDetails(model.saleSerialNumber!);
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                    child: Text(model.saleSerialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                                SizedBox(
                                                  width: sizeWidth(context).width*0.12,
                                                  child: Divider(
                                                    thickness: 2,
                                                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                  ),
                                                )
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

                                            SizedBox(
                                              width:sizeWidth(context).width*0.80,
                                              child: ElevatedButton(
                                                  onPressed: ()async{
                                                    bool check = await returnPaidQuestion(context);
                                                    if(check){
                                                      await returnPost(model.comSaleId!);
                                                    }
                                                  },
                                                  style: elevatedButtonStyle(context),
                                                  child: Text("returnPay".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                              ),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 4),
                                      const Divider(
                                        thickness: 0.5,
                                      ),
                                      const SizedBox(height: 4,),
                                      if(model.isCommPaid !=true)
                                        SizedBox(
                                          width:sizeWidth(context).width*0.80,
                                          child: ElevatedButton(
                                              onPressed: (){

                                                showAdjust(context,viewModel,model.comSaleId!);
                                              },
                                              style: elevatedButtonStyle(context),
                                              child: Text("adjust".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                          ),
                                        ),
                                      if(model.isCommPaid ==false)
                                        SizedBox(
                                          width:sizeWidth(context).width*0.80,
                                          child: ElevatedButton(
                                              onPressed: ()async{
                                                bool check = await paidQuestion(context);
                                                if(check){
                                                  await post(model.comSaleId!);
                                                }
                                              },
                                              style: elevatedButtonStyle(context),
                                              child: Text("approve".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                          ),
                                        ),
                                    ],
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
       viewModel.addComDetail(viewModel.commissionWinner!.length);
       await getComValues();
  }
  getComValues() async{
    totalSalesPrice =0.0;
    dynamic y=0.0;
    dynamic z=0.0;

    for(int i=0;i<viewModel.searchAllCom(viewModel.commissionWinner!, viewModel.query).length;i++){
      CommissionWinner winner = viewModel.searchAllCom(viewModel.commissionWinner!, viewModel.query)[i];
      totalSalesPrice +=double.parse(winner.salePrice ?? "0.0");
      if(winner.isCommPaid == true){
        y +=double.parse(winner.commAdjustAmount ?? winner.commAmount ?? "0.0");
      }
      else{
        z +=double.parse(winner.commAdjustAmount ?? winner.commAmount ?? "0.0");
      }
    }
    viewModel.setPaidCom(y, z);
  }
  Future<void> getSaleDetails(String serial)async{
    await viewModel.getSaleDetails(context, serial);

    if (viewModel.saleDetails!.isNotEmpty){
      showComSaleDetails(context,viewModel.saleDetails!);
    }
  }
  post(int id) async{
    //eğer adjust edilen varsa adjust olacak yoksa com amount pay edilecek
    PayPost post = PayPost(calcPoolSaleId: id);
    await viewModel.postComPay(context,post,getList);

  }
  returnPost(int id) async{
    PayPost post = PayPost(calcPoolSaleId: id);
    await viewModel.postComPay(context,post,getList);

  }
}
