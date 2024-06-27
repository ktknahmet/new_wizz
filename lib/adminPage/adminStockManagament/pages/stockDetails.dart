import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/organisations/allOrganisations.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/pool/poolListDetails.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/poolDistributor/poolDistributor.dart';
import 'package:wizzsales/adminPage/adminModel/stockPayModel/postStockPay.dart';
import 'package:wizzsales/adminPage/adminVm/stockVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously
class StockDetails extends StatefulWidget {
  final int id;
  final int assign;
  final int total;
  const StockDetails(this.id,this.assign,this.total,{super.key});

  @override
  State<StatefulWidget> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  StockVm viewModel = StockVm();
  ScrollController controller = ScrollController();
  LoginUser? loginUser;
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
      appBar: DefaultAppBar(name: "seeDetails".tr(),),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<StockVm>(
            builder: (context,value,_){
              if(viewModel.organisations == null || viewModel.poolList == null){
                return spinKit(context);
              }else if(viewModel.poolList!.isEmpty){
                return emptyView(context, "youMustAssignProduct");
              }else{
                return  SingleChildScrollView(
                  child: Column(
                    children: [
                      viewModel.status!.isGranted ?
                      SizedBox(
                        height: sizeWidth(context).height*0.12,
                        width: sizeWidth(context).width*0.8,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: QRView(
                                key: viewModel.qrKey,
                                onQRViewCreated: (controller) {
                                  viewModel.checkProductControl(context, controller, viewModel.poolList!);
                                },
                                overlay: QrScannerOverlayShape(
                                  borderColor: ColorUtil().getColor(context, ColorEnums.error),
                                  borderRadius: 24,
                                  borderLength: 30,
                                  borderWidth: 10,)
                            )
                        ),
                      ):Column(
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

                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              height: 40,
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
                              width: sizeWidth(context).width*0.4,
                              height: 40,
                              child: TextField(
                                onChanged: (value){
                                  viewModel.setQuery(value);
                                  viewModel.searchProduct(viewModel.poolList!,viewModel.query);
                                },
                                decoration: searchTextDesign(context, "search"),
                                cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ),
                          ],
                        ),
                      ),

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
                              itemCount:  viewModel.searchProduct(viewModel.poolList!,viewModel.query).length,
                              itemBuilder: (context,index){
                                PoolListDetails value = viewModel.searchProduct(viewModel.poolList!,viewModel.query)[index];

                                return  Padding(
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
                                                  value.assignedToDistributor == true ?
                                                  Text(getOrganisationName(viewModel.organisations!,value.distributorId!) ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                                      :Column(
                                                    children: [
                                                      Align(
                                                        alignment:Alignment.centerRight,
                                                        child: DropdownButton<AllOrganisations?>(
                                                          isDense: true,
                                                          underline: const SizedBox(),
                                                          dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                                          value: viewModel.organisations!.firstWhere(
                                                                (org) => org.id == value.distributorId,
                                                          ),
                                                          onChanged: (AllOrganisations? newValue) {
                                                            if (newValue != null) {
                                                              viewModel.setDistId(index, newValue.id!);
                                                            }
                                                          },
                                                          items: viewModel.organisations!.map<DropdownMenuItem<AllOrganisations>>((AllOrganisations organisation) {
                                                            return DropdownMenuItem<AllOrganisations>(
                                                              value: organisation,
                                                              child: Text(
                                                                organisation.name!,
                                                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                              ),
                                              const SizedBox(height: 4,),
                                              if(value.distributorId !=0)
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("distWarehouse".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                                    value.distId ==null ?
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
                                                              value.distId = warehouseMap["distId"];
                                                              value.distWarehouseName = warehouseMap["warehouseName"];

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
                                              if(value.distributorId !=0)
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8),
                                                  child: SizedBox(
                                                    width: sizeWidth(context).width*0.8,
                                                    height: 30,
                                                    child: ElevatedButton(
                                                      onPressed: () async{
                                                        bool check = await areYouSure(context);
                                                        if(check){
                                                          await postPay(value.poolDetailId!,index);
                                                        }

                                                      },
                                                      style: elevatedButtonStyle(context),
                                                      child:  Text("paid".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
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
        ),
      ),
    );
  }
  Future<void>getList()async{
    await viewModel.checkCamera();
    if(viewModel.organisations ==null){
      await viewModel.getOrganisations(context);
    }
   await viewModel.getStockList(context,widget.id);
  }
  post() async{

    for(int i=0;i<viewModel.poolList!.length;i++){
      PoolListDetails value = viewModel.poolList![i];
      if(value.assignedToDistributor ==false && value.distributorId !=0){
        PoolDistributor  pool = PoolDistributor(
            poolDetailId: value.poolDetailId,
            distributorId: value.distributorId,
            distWarehouseId: value.distId
        );
        viewModel.postList.add(pool);
      }else{
        viewModel.postList.removeWhere((element) =>
            element.poolDetailId == value.poolDetailId);
      }
    }
    if(viewModel.postList.isNotEmpty){
      await viewModel.postDistributors(context,viewModel.postList);
    }else{
      snackBarDesign(context, StringUtil.error, "pleaseAssignDist".tr());
    }

  }
  postPay(int id,int index)async{
    PostStockPay pay = PostStockPay(poolDetailId: id);
    await viewModel.postPay(context, pay,widget.id,index);
  }

  Future<void> getWarehouses(int id)async{
    await viewModel.getWarehouse(context,id);
  }

}
