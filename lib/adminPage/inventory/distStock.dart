import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/distStockList/DistStockList.dart';
import 'package:wizzsales/adminPage/adminVm/stockVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/stockCheckIn/returnStock.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../constants/AppColors.dart';

class DistStock extends BaseStatefulPage {
  const DistStock(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _DistStockState();
}

class _DistStockState extends BaseStatefulPageState<DistStock> {
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
                                        Text("${viewModel.distStockList!.length}", style: CustomTextStyle().bold12(AppColors.white)),

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
                                        Text("${viewModel.distStockList!.length-dealerHands!}", style: CustomTextStyle().bold12(AppColors.white)),

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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: [
                        /* const SizedBox(width: 2,),
                        Padding(
                          padding: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Container(
                            decoration: containerDecoration(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("paid".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  Text("$totalPaid",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ),
                        ),*/
                        /* const SizedBox(width: 2,),
                        Padding(
                          padding: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Container(
                            decoration: containerDecoration(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("unPaid".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  Text("$totalUnPaid",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: sizeWidth(context).width*0.3,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setStockQuery(value);
                              viewModel.searchStockList(viewModel.distStockList!,viewModel.stockQuery);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                        SizedBox(
                          width:sizeWidth(context).width*0.3,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/${PageName.inventoryReportPage}');
                                //inventory report
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("seeReport".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                          ),
                        ),
                        SizedBox(
                          width:sizeWidth(context).width*0.3,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/${PageName.warehouseOperationsPage}');
                                //inventory report
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("inventoryLocation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                          ),
                        ),
                      ],
                    ),
                  ),
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
                          itemCount: viewModel.searchStockList(viewModel.distStockList!, viewModel.stockQuery).length,
                          itemBuilder: (context,index){
                            DistStockList model = viewModel.searchStockList(viewModel.distStockList!, viewModel.stockQuery)[index];
                            int startIndex = ((viewModel.searchStockList(viewModel.distStockList!, viewModel.stockQuery).length == 1) ? 1 : viewModel.searchStockList(viewModel.distStockList!, viewModel.stockQuery).length);
                            List<int> indices = List.generate(viewModel.searchStockList(viewModel.distStockList!, viewModel.stockQuery).length, (index) => startIndex - index);
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
                                    if (model.warehouseName ==null) Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("inventoryLocation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                            SizedBox(
                                              height:30,
                                              child: ElevatedButton(
                                                onPressed: ()async{
                                                  if(viewModel.warehouseList == null){
                                                    showProgress(context, true);
                                                    await getWarehouse();
                                                    showProgress(context, false);
                                                  }
                                                  showDistInventoryWarehouse(context,viewModel,model.poolDetailId!,getList);
                                                },
                                                style: elevatedButtonStyle(context),
                                                child:  Text("selectStockRoom".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                      ],
                                    ) else Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("warehouseName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                            Text(model.warehouseName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)))
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
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
                                            const SizedBox(height: 8,),
                                            SizedBox(
                                              width: sizeWidth(context).width*0.8,
                                              height: 30,
                                              child: ElevatedButton(
                                                onPressed: ()async{
                                                  bool check = await showReturnToDist(context);
                                                  if(check){
                                                    post(model.poolDetailId!);
                                                  }
                                                },
                                                style: elevatedButtonStyle(context),
                                                child:  Text("returnDist".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                              ),
                                            ),
                                          ],
                                        ):Container()
                                      ],
                                    ) else SizedBox(
                                      width: sizeWidth(context).width*0.8,
                                      height: 30,
                                      child:  ElevatedButton(
                                          onPressed: (){
                                            showDealerList(context,viewModel,model.serialNumber!,model.poolDetailId!);
                                          },
                                          style: elevatedButtonStyle(context),
                                          child:  Text("checkOut".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                        ),

                                    ),
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
    dealerHands=0;
    pickUp=0;
    await viewModel.getStock(context);
    await viewModel.getDealerList(context);
    if(viewModel.distStockList !=null){
      for(int i=0;i<viewModel.distStockList!.length;i++){

        if(viewModel.distStockList![i].assignedToDealer==true){
          dealerHands = dealerHands!+1;
        }
        if(viewModel.distStockList![i].inSaleProgress=="Pick Up"){
          pickUp = pickUp!+1;
        }
        if(viewModel.distStockList![i].isPaid==true){
          totalPaid = totalPaid+1;
        }else{
          totalUnPaid = totalUnPaid+1;
        }
      }
    }
  }
  post(int id)async{
    ReturnStock stock = ReturnStock(
        poolDetailId: id
    );
    await viewModel.returnProduct(context, stock);
  }
  Future<void> getWarehouse()async{
    int? distId;
    SharedPref pref = SharedPref();
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    user ??= await getUserUser(context);

    if(user!.roleType !="SUPERADMIN"){
      distId = loginUser!.profiles![index].organisation_id!;
    }
    await viewModel.getWarehouse(context,distId);
  }
}
