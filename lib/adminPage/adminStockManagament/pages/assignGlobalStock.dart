import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/poolDistributor/poolDistributor.dart';
import 'package:wizzsales/adminPage/adminVm/stockVm.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import '../../../constants/AppColors.dart';
import '../../../constants/ColorsUtil.dart';
import '../../../utils/style/ColorEnums.dart';
import '../../../utils/style/CustomTextStyle.dart';
import '../../../utils/style/WidgetStyle.dart';
import '../../../widgets/Constant.dart';
import '../../../widgets/Extension.dart';
import '../../../widgets/WidgetExtension.dart';
import '../../adminModel/stockModel/pool/poolListDetails.dart';
import '../../adminModel/stockModel/product/StockProduct.dart';
// ignore_for_file: use_build_context_synchronously
class AssignGlobalStock extends BaseStatefulPage {
  const AssignGlobalStock(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AssignGlobalStockState();
}

class _AssignGlobalStockState extends BaseStatefulPageState<AssignGlobalStock> {
  StockVm viewModel = StockVm();
  ScrollController controller = ScrollController();

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
          if(viewModel.organisations == null){
            return spinKit(context);
          }else{
            return  SingleChildScrollView(
              child: Column(

                children: [
                  if (viewModel.status!.isGranted) SizedBox(
                    height: sizeWidth(context).height*0.12,
                    width: sizeWidth(context).width*0.8,
                    child: GestureDetector(
                      onTap: ()async{
                        await viewModel.checkStockBefore(context, "12344322");
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: QRView(
                              key: viewModel.qrKey,
                              onQRViewCreated: (controller) {
                                viewModel.checkBeforeScan(context, controller);
                              },
                              overlay: QrScannerOverlayShape(
                                borderColor: ColorUtil().getColor(context, ColorEnums.error),
                                borderRadius: 24,
                                borderLength: 30,
                                borderWidth: 10,)
                          )
                      ),
                    ),
                  ) else Column(
                    children: [
                      spinKit(context),
                      Text("redirectSettingsForCamera".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      const SizedBox(height: 8,),
                      ElevatedButton(
                        onPressed: (){
                          openAppSettings();
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("givePermission".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: sizeWidth(context).width*0.3,
                        child: TextField(
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                          cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          decoration: dateInputDecoration(context,"selectDist"),
                          controller: viewModel.distributorId,
                          readOnly: true,
                          onTap: () async{
                            barcodeSetDist(context,viewModel);
                          },
                        ),
                      ),
                      SizedBox(
                        width: sizeWidth(context).width*0.3,
                        child: TextField(
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                          cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          decoration: dateInputDecoration(context,"selectWarehouse"),
                          controller: viewModel.distWarehouseName,
                          readOnly: true,
                          onTap: () async{
                            if(viewModel.distId !=null){
                              await showProgress(context, true);
                              await getWarehouses(viewModel.distId);
                              await showProgress(context, false);
                            }else{
                              snackBarDesign(context, StringUtil.error, "You must select distributor");
                            }
                            if(viewModel.warehouseList!.isNotEmpty){
                              Map<String,dynamic> warehouseMap ={};
                              warehouseMap = await selectWarehouseList(context,viewModel);


                              if(warehouseMap["distId"] !=null){
                                viewModel.setAllDistIdWith(warehouseMap["warehouseName"],warehouseMap["distId"]);
                              }
                            }else{
                              viewModel.clearDistWarehouseName();
                              snackBarDesign(context, StringUtil.warning, "You must add warehouse.");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: sizeWidth(context).width*0.3,
                        child: TextField(
                          onSubmitted: (String value){
                            if(value.length ==8){
                              //tüm poollarda arama yapacak ve ekleme yapacak
                            }else{

                            }
                          },
                          decoration: searchTextDesign(context, "search"),
                          cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 4,),
                  Card(
                    shape: cardShape(context),
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                value: true,
                                groupValue: viewModel.isPaid,
                                onChanged: (value) async{
                                  viewModel.setPaid();
                                },
                              ),
                              Text("paid".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                value: false,
                                groupValue: viewModel.isPaid,
                                onChanged: (value) async{
                                  viewModel.setPaid();
                                },
                              ),
                              Text("unPaid".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  RefreshIndicator(
                    onRefresh: getList,
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: SizedBox(
                      height: sizeWidth(context).height*0.70,
                      child: RawScrollbar(
                        thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                        thumbVisibility: true,
                        thickness: 1,
                        trackVisibility: true,
                        controller: controller,
                        child: ListView.builder(
                          controller: controller,
                          itemCount:  viewModel.poolList.length,
                          itemBuilder: (context,index){
                            PoolListDetails value = viewModel.poolList[index];

                              return Dismissible(
                                background: Container(
                                  color: ColorUtil().getColor(context, ColorEnums.error),
                                  child: const Icon(Icons.delete,color: AppColors.white,),
                                ),
                                key: UniqueKey(),
                                onDismissed: (DismissDirection direction){
                                  viewModel.deletePoolListItem(viewModel.poolList, index);
                                },
                                child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Card(
                                      shape: cardShape(context),
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("enterSerialNumber".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                Text(value.serialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                              ],
                                            ),
                                            const SizedBox(height: 4,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("product".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                Text(value.productName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                              ],
                                            ),
                                            const SizedBox(height: 4,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("distributor".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                Text(getOrganisationName(viewModel.organisations!,value.distributorId!) ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                              ],
                                            ),
                                            const SizedBox(height: 4,),
                                            if(value.distributorId !=0)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("distWarehouse".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                                  value.distWarehouseId !=null ?
                                                  SizedBox(
                                                    height:30,
                                                    child: ElevatedButton(
                                                      onPressed: ()async{
                                                        await showProgress(context, true);
                                                        await getWarehouses(value.distributorId!);
                                                        await showProgress(context, false);
                                                        if(viewModel.warehouseList!.isNotEmpty){
                                                          Map<String,dynamic> warehouseMap ={};
                                                          warehouseMap = await selectWarehouseList(context,viewModel);


                                                          if(warehouseMap["distId"] !=null){
                                                            viewModel.setDistSpesificWarehouse(index,warehouseMap["distId"],warehouseMap["warehouseName"]);
                                                          }
                                                        }else{
                                                          snackBarDesign(context, StringUtil.warning, "You must add warehouse.");
                                                        }
                                                      },
                                                      style: elevatedButtonStyle(context),
                                                      child:Text("addWarehouse".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    ),
                                                  ):Text(value.distWarehouseName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                                ],
                                              ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("isPaid?".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                Text(value.isPaid ==true ? "Yes" : "No",
                                                  style: value.isPaid ==true ?
                                                  CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.wizzColor))
                                                      :CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.error)),)
                                              ],
                                            ),
                                            const SizedBox(height: 4,),
                                            if(value.isPaid ==true)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("paidDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  Text(mmDDYDate(value.paidDate),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),

                                          ],
                                        ),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.80,
                        child: ElevatedButton(
                          onPressed: () async{
                            await post();
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
    await viewModel.checkCamera();
    await viewModel.getStockProduct(context);
    if(viewModel.organisations ==null){
      await viewModel.getOrganisations(context);
    }
    if(viewModel.stockProduct!.isNotEmpty){
      if(viewModel.products.isEmpty){
        for(int i=0;i<viewModel.stockProduct!.length;i++){
          var value = viewModel.stockProduct![i];
          StockProduct product = StockProduct(productId: value.productId, productName: value.productName);
          viewModel.addProducts(product);
        }
      }
      viewModel.setProductId(viewModel.stockProduct![0].productId!);
    }

  }
  post() async{

    for(int i=0;i<viewModel.poolList.length;i++){
      PoolListDetails value = viewModel.poolList[i];
      if(value.assignedToDistributor ==false && value.distributorId !=0){
        PoolDistributor  pool = PoolDistributor(
            serialNumber: value.serialNumber,
            distributorId: value.distributorId,
            distWarehouseId: value.distWarehouseId
        );
        viewModel.postList.add(pool);
      }else{
        viewModel.postList.removeWhere((element) =>
        element.serialNumber == value.serialNumber);
      }
    }
    if(viewModel.postList.isNotEmpty){
      await viewModel.postDistributors(context,viewModel.postList);
    }else{
      snackBarDesign(context, StringUtil.error, "pleaseAssignDist".tr());
    }

  }

  Future<void> getWarehouses(int? id)async{
    await showProgress(context, true);
    await viewModel.getWarehouse(context,id);
    await showProgress(context, false);
  }
}
