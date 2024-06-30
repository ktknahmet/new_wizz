import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/organisations/allOrganisations.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postPool/poolProductSave.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postPool/poolStockProduct.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/product/StockProduct.dart';
import 'package:wizzsales/adminPage/adminVm/stockVm.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously
class ScanStockBarcode extends StatefulWidget {
  final int id;
  final int assign;
  final dynamic total;
  final String? beginSerial;
  final String? endSerial;
  const ScanStockBarcode(this.id,this.assign,this.total,this.beginSerial,this.endSerial,{super.key});

  @override
  State<StatefulWidget> createState() => _ScanStockBarcodeState();
}

class _ScanStockBarcodeState extends State<ScanStockBarcode> {
  ScrollController controller = ScrollController();

  TextEditingController serialIdController = TextEditingController();
  StockVm viewModel = StockVm();


  @override
  void initState() {
    getProduct();

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
      appBar:DefaultAppBar(name: "scanProduct".tr(),),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<StockVm>(
            builder: (context,view,_){

               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       if (viewModel.productId == null) spinKit(context) else viewModel.status == null
                           ? spinKit(context)
                           : viewModel.status!.isGranted ?
                       SizedBox(
                         height: sizeWidth(context).height*0.18,
                         child: ClipRRect(
                             borderRadius: BorderRadius.circular(24),
                             child: QRView(
                                 key: viewModel.qrKey,
                                 onQRViewCreated: (controller) {
                                   viewModel.onQRViewCreated(context, controller, viewModel.productId!,widget.assign,widget.total.toString());

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

                       const SizedBox(height: 8,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: SizedBox(
                               width: sizeWidth(context).width*0.40,
                               height: 40,
                               child: TextField(
                                 onChanged: (value){
                                   viewModel.setQuery(value);
                                   viewModel.searchProduct(viewModel.poolList,viewModel.query);
                                 },
                                 decoration: searchTextDesign(context, "search"),
                                 cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                                 style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                               ),
                             ),
                           ),
                           Container(
                             decoration: containerDecoration(context),
                             width: sizeWidth(context).width*0.50,
                             height: 40,
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child:   DropdownButton<StockProduct>(
                                 dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                 underline: const SizedBox(),
                                 hint: Text("selectProduct".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                 value: viewModel.productId != null && viewModel.products.any((product) => product.productId == viewModel.productId)
                                     ? viewModel.products.firstWhere((element) => element.productId == viewModel.productId)
                                     : null,
                                 onChanged: (StockProduct? newValue) {
                                   viewModel.setProductId(newValue!.productId!);

                                 },
                                 items: viewModel.products.map<DropdownMenuItem<StockProduct>>((StockProduct stock) {
                                   return DropdownMenuItem<StockProduct>(
                                     value: stock,
                                     child: Text(stock.productName!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                   );
                                 }).toList(),
                               ),
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(height: 4,),
                       TextField(
                         style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                         cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                         decoration: dateInputDecoration(context,"selectWarehouse"),
                         controller: viewModel.importerWarehouse,
                         readOnly: true,
                         onTap: () async{


                           if(viewModel.warehouseList == null){
                             await getWarehouses(null);
                              await showImporterWarehouse(context,viewModel);
                           }

                           if(viewModel.warehouseList!.isEmpty){
                             snackBarDesign(context, StringUtil.warning, "You must add warehouse.");
                           }else{
                             await showImporterWarehouse(context,viewModel);


                           }
                         },
                       ),
                       const SizedBox(height: 4,),

                       Column(
                         children: [
                           Text("${context.tr("total")} ${viewModel.postResponse !=null ?
                           viewModel.postResponse!.totalSavedStockOfPool! :
                           widget.assign +viewModel.poolStock.length}/${widget.total}",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                           const SizedBox(height: 4,),
                           SizedBox(
                             height: sizeWidth(context).height*0.53,
                             child: RawScrollbar(
                               thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                               thumbVisibility: true,
                               thickness: 1,
                               trackVisibility: true,
                               controller: controller,
                               child: ListView.builder(
                                 controller: controller,
                                 itemCount: viewModel.searchScanProduct(viewModel.poolStock,viewModel.query).length,
                                 itemBuilder: (context,index){
                                   PoolStockProduct value = viewModel.searchScanProduct(viewModel.poolStock,viewModel.query)[index];
                                   return Dismissible(
                                     background: Container(
                                       color: ColorUtil().getColor(context, ColorEnums.error),
                                       child: const Icon(Icons.delete,color: AppColors.white,),
                                     ),
                                     key: UniqueKey(),
                                     onDismissed: (DismissDirection direction){
                                       viewModel.deleteItem(viewModel.searchScanProduct(viewModel.poolStock,viewModel.query), index);
                                     },
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
                                                     Text(value.productSerialNumber!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                                   ],
                                                 ),
                                                 Divider(
                                                   color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                 ),

                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text("product".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                     Text(stockProductName(viewModel.productId!,viewModel.stockProduct!),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                                   ],
                                                 ),
                                                 Divider(
                                                   color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                 ),

                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text("distributor".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                                     viewModel.organisations !=null ?
                                                             DropdownButton<AllOrganisations>(

                                                                   isDense: true,
                                                                   underline: const SizedBox(),
                                                                   dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                                                   value: viewModel.organisations!.firstWhere((org) => org.id == value.distributorId!),
                                                                   onChanged: (AllOrganisations? newValue) {
                                                                     viewModel.setDistIdPoolStock(index,newValue!.id!);

                                                                   },
                                                                items: viewModel.organisations!.map<DropdownMenuItem<AllOrganisations>>((AllOrganisations organisation) {
                                                                  return DropdownMenuItem<AllOrganisations>(
                                                                    value: organisation,
                                                                    child: Text(organisation.name!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                                                  );
                                                                }).toList(),

                                                            ) :spinKit(context)
                                                   ],
                                                 ),

                                                 Divider(
                                                   color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                 ),

                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text("distWarehouse".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                     SizedBox(
                                                       width: sizeWidth(context).width*0.30,
                                                       height: 30,
                                                       child: ElevatedButton(
                                                         onPressed: ()async{
                                                             if(value.distributorId !=0){
                                                               await getWarehouses(value.distributorId);
                                                               if(viewModel.warehouseList!.isEmpty){
                                                                 snackBarDesign(context, StringUtil.warning, "You must add warehouse.");
                                                               }else{
                                                                 Map<String,dynamic> warehouseMap ={};
                                                                 warehouseMap = await selectWarehouseList(context,viewModel);
                                                                 if(warehouseMap["distName"] !=null){
                                                                   viewModel.setDistWarehouseName(index,warehouseMap["distName"]);

                                                                 }
                                                               }
                                                             }else{
                                                               snackBarDesign(context, StringUtil.warning, "You must select a distributor");
                                                             }


                                                         },
                                                         style: elevatedButtonStyle(context),
                                                         child: Text("add".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                       ),
                                                     ),
                                                   ],
                                                 ),

                                                 Divider(
                                                   color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                 ),
                                                 if(value.importerWarehouseName != null)
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text("importerWarehouse".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                     Text(value.importerWarehouseName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),

                                                   ],
                                                 ),

                                               ],
                                             ),
                                           ),
                                         ),
                                         const SizedBox(height: 8,)
                                       ],
                                     ),
                                   );
                                 },
                               ),
                             ),
                           ),
                         ],
                       ),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 8),
                         child: Align(
                           alignment: Alignment.bottomCenter,
                           child: SizedBox(
                             width: sizeWidth(context).width*0.80,
                             child: ElevatedButton(
                               onPressed: ()async{
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
                 ),

               );
             }

          ),
        ),
      ),
    );
  }
  getProduct()async{
   await viewModel.checkCamera();
   await viewModel.getStockProduct(context);

   if(viewModel.organisations == null){
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
   if(widget.beginSerial !=null && widget.endSerial !=null){
     int number = int.parse(widget.endSerial!) - int.parse(widget.beginSerial!)+1;

     for(int i=0;i<number;i++){
       int serialNum = int.parse(widget.beginSerial!);

       PoolStockProduct poolStockProduct = PoolStockProduct(
           productId: viewModel.stockProduct![0].productId!,
           productSerialNumber: (serialNum+i).toString(),
           stockDate: DateTime.now(),
           distributorId: 0
       );
       viewModel.poolStock.add(poolStockProduct);
     }
   }
  }
post() async{
   if(viewModel.poolStock.isNotEmpty){
     List<PoolStockProduct>  product=[];
     for(int i=0;i<viewModel.poolStock.length;i++){
       var model = PoolStockProduct(
           productId: viewModel.poolStock[i].productId!,
           productSerialNumber:viewModel.poolStock[i].productSerialNumber!,
           stockDate:DateTime.parse(formatDate(DateTime.now().toString())),
           distributorId:viewModel.poolStock[i].distributorId!,
           importerWarehouseId: viewModel.poolStock[i].importerWarehouseId,
           distWarehouseId: viewModel.poolStock[i].distWarehouseId
       );
       product.add(model);
     }
     PoolProductSave productSave = PoolProductSave(
         stockPoolId: widget.id,
         stockProducts:product
     );
     await viewModel.postProduct(context,productSave);
     if(viewModel.postResponse !=null){
       if(viewModel.postResponse!.isSuccess!){
         snackBarDesign(context, StringUtil.success, "successAdded".tr());
         int check = viewModel.postResponse!.totalSavedStockOfPool! +viewModel.searchScanProduct(viewModel.poolStock, viewModel.query).length;

         if(check >=widget.total){
           Navigator.pushNamed(context, '/${PageName.adminStockPages}');
         }
         viewModel.searchScanProduct(viewModel.poolStock,viewModel.query).clear();
       }else{
         snackBarDesign(context, StringUtil.success,viewModel.postResponse!.message!);
       }
     }
   }else{
     snackBarDesign(context, StringUtil.error, "youMustAddProduct".tr());
   }


  }

  Future<void> getWarehouses(int? id)async{
    showProgress(context, true);
    await viewModel.getWarehouse(context,id);
    showProgress(context, false);
  }
}
