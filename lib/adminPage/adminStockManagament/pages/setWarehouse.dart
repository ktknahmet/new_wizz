import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseDelete.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseList.dart';
import 'package:wizzsales/adminPage/adminVm/warehouseVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
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

import '../../../model/OLD/User.dart';

class SetWarehouses extends BaseStatefulPage {
  const SetWarehouses(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _SetWarehousesState();
}

class _SetWarehousesState extends BaseStatefulPageState<SetWarehouses> {
  WarehouseVm viewModel = WarehouseVm();
  ScrollController controller = ScrollController();
  LoginUser? loginUser;
  User? user;
  int index=0;
  SharedPref pref = SharedPref();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<WarehouseVm>(
        builder: (context,value,_){
          if(viewModel.warehouseList == null){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.6,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);
              
                              viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: ()async{
                          showProgress(context, true);
                          await getList();
                          showProgress(context, false);
                        },
                        icon: Icon(Icons.refresh,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                      )
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: getList,
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: SizedBox(
                      height: justList(context, sizeWidth(context).height),
                      child: RawScrollbar(
                        controller: controller,
                        thumbVisibility: true,
                        thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        thickness: 1,
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query).length,
                          itemBuilder: (context,index){
                            WarehouseList item = viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query)[index];
                            return Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    if(item.orgName !=null)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: sizeWidth(context).width*0.4,
                                              child: Text("distributor".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(item.orgName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.4,
                                            child: Text("type".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(upperFirstLetter(item.warehouseType ?? ""),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.4,
                                            child: Text("warehouseName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.warehouseName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.3,
                                            child: Text("address".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.warehouseAdress ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.4,
                                            child: Text("city".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.warehouseCity ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.4,
                                            child: Text("state".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.warehouseState ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        )
              
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.4,
                                            child: Text("zipCode".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.warehouseZipcode ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.4,
                                            child: Text("contact".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.warehouseSpocname ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.4,
                                            child: Text("email".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.warehouseEmail ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.4,
                                            child: Text("phone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.warehousePhone ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.4,
                                          child: ElevatedButton(
                                            style: elevatedButtonStyle(context),
                                            onPressed: () async{
                                              Navigator.pushNamed(context, '/${PageName.updateWarehousePage}',arguments: {"warehouse":item});
                                            },
                                            child:  Text("edit".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ),
                                        ),
                                        SizedBox(
                                          width: sizeWidth(context).width*0.4,
                                          child: ElevatedButton(
                                            style: elevatedButtonStyle(context),
                                            onPressed: () async{
                                              bool check = await areYouSure(context);
                                              if(check){
                                                delete(item.warehouseId!);
                                              }
                                            },
                                            child:  Text("delete".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ),
                                        ),
                                      ],
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
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16,top: 8),
                        child: SizedBox(
                          width:sizeWidth(context).width*0.80,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/${PageName.addWarehouse}');
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("add".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
              

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

  Future<void> getList()async{

    await viewModel.getWarehouse(context);
  }
  delete(int warehouseId)async{
    WarehouseDelete delete = WarehouseDelete(
      warehouseId: warehouseId
    );
    await viewModel.deleteWarehouse(context, delete);
  }
}
