import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Container(
                            decoration: containerDecoration(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("total".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  Text("${viewModel.distStockList!.length}",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ),
                        ),
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
                        const SizedBox(width: 2,),
                        Padding(
                          padding: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Container(
                            decoration: containerDecoration(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("totalInHouse".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  Text("${viewModel.distStockList!.length-dealerHands!}",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 2,),
                        Padding(
                          padding: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Container(
                            decoration: containerDecoration(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("totalInDealerHands".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  Text("$dealerHands",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 2,),
                        Padding(
                          padding: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Container(
                            decoration: containerDecoration(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("pickUp".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  Text("$pickUp",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: sizeWidth(context).width*0.5,
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
                                    Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(indices[index].toString(),style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),)),
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
                                            Text("selectWarehouse".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
                                                child:  Text("selectWarehouse".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
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
                                        const SizedBox(height: 4,),
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
                                            const SizedBox(height: 4,),
                                            Align(
                                              alignment:Alignment.centerRight,
                                              child: SizedBox(
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
                                            )
                                          ],
                                        ):Container()
                                      ],
                                    ) else Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("checkOut".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                        SizedBox(
                                          height: 30,
                                          child: ElevatedButton(
                                            onPressed: (){
                                              showDealerList(context,viewModel,model.serialNumber!,model.poolDetailId!);
                                            },
                                            style: elevatedButtonStyle(context),
                                            child:  Text("inHouseMachine".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          ),
                                        )

                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    if(model.isHistory == true)
                                      SizedBox(
                                        width: sizeWidth(context).width*0.8,
                                        height: 30,
                                        child: ElevatedButton(
                                          onPressed: (){
                                            Navigator.pushNamed(context, '/${PageName.stockHistory}',arguments: {"poolId":model.poolDetailId});

                                          },
                                          style: elevatedButtonStyle(context),
                                          child:  Text("inventoryHistory".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
