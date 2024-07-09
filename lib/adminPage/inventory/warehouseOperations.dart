import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';

import '../../constants/AppColors.dart';
import '../../constants/ColorsUtil.dart';
import '../../model/OLD/User.dart';
import '../../model/OLD/register/LoginUser.dart';
import '../../utils/res/PageName.dart';
import '../../utils/style/ColorEnums.dart';
import '../../utils/style/CustomTextStyle.dart';
import '../../utils/style/WidgetStyle.dart';
import '../../widgets/Constant.dart';
import '../../widgets/WidgetExtension.dart';
import '../adminModel/stockModel/distStockList/DistStockList.dart';
import '../adminVm/stockVm.dart';

class WarehouseOperations extends BaseStatefulPage {
  const WarehouseOperations(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _WarehouseOperationsState();
}

class _WarehouseOperationsState extends BaseStatefulPageState<WarehouseOperations> {
  StockVm viewModel = StockVm();
  ScrollController controller = ScrollController();

  int? dealerHands;
  int? pickUp;
  int totalPaid=0;
  int totalUnPaid=0;
  int pending=0;
  LoginUser? loginUser;
  User? user;
  int index=0;
  List<String> wName=[];
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design(){
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<StockVm>(
        builder: (context,value,_){
          if(viewModel.distStockList ==null || viewModel.stockDealer == null){
            return spinKit(context);
          }else if(viewModel.distStockList!.isEmpty){
            return emptyView(context, "youDoNotHaveInventory");
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
                              SizedBox(
                                child:  Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Column(
                                      children: [
                                        Text("total".tr(), style: CustomTextStyle().semiBold14(AppColors.white)),
                                        Text("${viewModel.searchWarehouseOperation(viewModel.distStockList!, viewModel.stockQuery).length}", style: CustomTextStyle().bold12(AppColors.white)),

                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Column(
                                      children: [
                                        Text("totalInHouse".tr(), style: CustomTextStyle().semiBold14(AppColors.white)),
                                        Text("${viewModel.searchWarehouseOperation(viewModel.distStockList!, viewModel.stockQuery).length-dealerHands!}", style: CustomTextStyle().bold12(AppColors.white)),

                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Column(
                                      children: [
                                        Text("totalInDealerHands".tr(), style: CustomTextStyle().semiBold14(AppColors.white)),
                                        Text("$dealerHands", style: CustomTextStyle().bold12(AppColors.white)),

                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Column(
                                      children: [
                                        Text("pickUp".tr(), style: CustomTextStyle().semiBold14(AppColors.white)),
                                        Text("$pickUp", style: CustomTextStyle().bold12(AppColors.white)),
                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Column(
                                      children: [
                                        Text("pending".tr(), style: CustomTextStyle().semiBold14(AppColors.white)),
                                        Text("$pending", style: CustomTextStyle().bold12(AppColors.white)),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
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
                            Text(viewModel.stockQuery,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ],
                        ),
                        value: viewModel.stockQuery,
                        onChanged: (newValue) async{
                          viewModel.setStockQuery(newValue!);
                          await getValues();

                        },
                        items: wName.map((value) {
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
                  const SizedBox(height: 8,),
                  RawScrollbar(
                    thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    thumbVisibility: true,
                    thickness: 1,
                    trackVisibility: true,
                    controller: controller,
                    child: RefreshIndicator(
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      onRefresh: getList,
                      child: SizedBox(
                        height: justList(context, sizeWidth(context).height),
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.searchWarehouseOperation(viewModel.distStockList!, viewModel.stockQuery).length,
                          itemBuilder: (context,index){
                            DistStockList model = viewModel.searchWarehouseOperation(viewModel.distStockList!, viewModel.stockQuery)[index];
                            int startIndex = ((viewModel.searchWarehouseOperation(viewModel.distStockList!, viewModel.stockQuery).length == 1) ? 1 : viewModel.searchWarehouseOperation(viewModel.distStockList!, viewModel.stockQuery).length);
                            List<int> indices = List.generate(viewModel.searchWarehouseOperation(viewModel.distStockList!, viewModel.stockQuery).length, (index) => startIndex - index);
                            return Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(indices[index].toString(),style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                        Text(indices[index].toString(),style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                        if(model.assignedToDealer==true)
                                          Text("totalInDealerHands".tr(),style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),)
                                        else
                                          Text("totalInHouse".tr(),style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                        if(model.inSaleProgress=="Pick Up")
                                          Text("pickUp".tr(),style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.30,
                                          child: Text("enterSerialNumber".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.serialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.40,
                                          child: Text("receiveDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(mmDDYDate(model.stockDate ?? ""),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("warehouseName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                        Text(model.warehouseName ?? "None",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)))
                                      ],
                                    ),
                                    if (model.assignedToDealer==true) Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("checkOutTo".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                            Text(model.dealerName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)))
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("assignDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                            Text(mmDDYDateTime(model.assignedToDealerAt ?? ""),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)))

                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        model.isPaid == true ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("paidDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                Text(mmDDYDate(model.payDate!),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                              ],
                                            ),

                                          ],
                                        ):Container()
                                      ],
                                    ) ,
                                    const SizedBox(height: 8,),
                                    if(model.isHistory == true)
                                      Align(
                                        alignment:Alignment.centerRight,
                                        child: GestureDetector(
                                            onTap:(){
                                              Navigator.pushNamed(context, '/${PageName.stockHistory}',arguments: {"poolId":model.poolDetailId});

                                            },
                                            child: SizedBox(
                                              width: sizeWidth(context).width*0.2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("history".tr(),style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  Divider(
                                                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                  )
                                                ],
                                              ),
                                            )

                                        ),
                                      )

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

    await viewModel.getStock(context);
    await viewModel.getDealerList(context);
    await getValues();
  }
  getValues()async{
    wName.clear();
    wName.add("All");
    wName.add("None Assign");
    dealerHands=0;
    pickUp=0;
    totalPaid=0;
    totalUnPaid=0;


    if(viewModel.stockQuery.isEmpty){
      viewModel.setStockQuery("All");
    }
    if(viewModel.distStockList !=null){
       for(int j=0;j<viewModel.distStockList!.length;j++){
         DistStockList item = viewModel.distStockList![j];
         if(item.warehouseName !=null){
           if(wName.contains(item.warehouseName) == false){
             wName.add(item.warehouseName!);
           }
         }
       }
      for(int i=0;i<viewModel.searchWarehouseOperation(viewModel.distStockList!, viewModel.stockQuery).length;i++){
        DistStockList item = viewModel.searchWarehouseOperation(viewModel.distStockList!, viewModel.stockQuery)[i];

        if(item.assignedToDealer==true){
          dealerHands = dealerHands!+1;
        }
        if(item.inSaleProgress=="Pick Up"){
          pickUp = pickUp!+1;
        }
        if(item.isPaid==true){
          totalPaid = totalPaid+1;
        }else{
          totalUnPaid = totalUnPaid+1;
        }
      }
    }
  }
}
