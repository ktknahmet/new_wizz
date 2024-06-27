import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/viewModel/SalesVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class FirstSale extends StatefulWidget {
  final VoidCallback? continueClick;
  final String? step;
  final String? totalStepCount;
  const FirstSale({super.key, required this.continueClick,this.step, this.totalStepCount});

  @override
  State<FirstSale> createState() => _FirstSaleState();
}

class _FirstSaleState extends State<FirstSale> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  SalesVm viewModel = SalesVm();
  ScrollController controller = ScrollController();
  Barcode? result;

  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  void initState() {
    getList();
    viewModel.checkCamera();
    if (SaleVM.addSaleModel.serialid != null) {
      viewModel.serialIdController.text = SaleVM.addSaleModel.serialid ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<SalesVm>(
        builder: (context,value,_)
    {
      return SizedBox(
        height: sizeWidth(context).height,
        child: Column(
          children: [
            Text("productInformation".tr(), style: CustomTextStyle().black18(
                ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            Text("pleaseScanBarcode".tr(), style: CustomTextStyle().semiBold12(
                ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            const SizedBox(height: 8,),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("${context.tr("step")} 1/${widget.totalStepCount}",
                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(
                      context, ColorEnums.textTitleLight)),)
            ),
            const SizedBox(height: 8),
            viewModel.status == null ?
                spinKit(context)
            : viewModel.status!.isGranted ?
            SizedBox(
              height: sizeWidth(context).height * 0.35,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: QRView(
                      key: qrKey,
                      onQRViewCreated: (controller) => viewModel.onQRViewCreated(context, controller,viewModel.serialIdController),
                      overlay: QrScannerOverlayShape(
                        borderColor: ColorUtil().getColor(context, ColorEnums.error),
                        borderRadius: 24,
                        borderLength: 30,
                        borderWidth: 10,)
                  )
              ),
            ) : Column(
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

             viewModel.assignList == null ? spinKit(context) :
               Column(
                 children: [
                   Align(
                       alignment: Alignment.centerLeft,
                       child: Text("enterSerialNumber".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                   ),
                   const SizedBox(height: 4,),
                   TextField(
                     style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                     maxLength: 8,
                     cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                     decoration: dateInputDecoration(context,"enterSerialNumber"),
                     controller:viewModel.serialIdController,
                     onTap: (){
                       if(viewModel.assignList!.isNotEmpty){
                         selectAssignSerial(context,viewModel);
                       }
                     },

                   ),

                 ],
               ),
             Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("cancel".tr(),
                          style: CustomTextStyle().semiBold12(
                              ColorUtil().getColor(
                                  context, ColorEnums.textDefaultLight)),),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (viewModel.serialIdController.text.length != 8) {
                            snackBarDesign(context, StringUtil.warning,
                                "serialIdMust8".tr());
                          } else {
                            SaleVM.addSaleModel.serialid = viewModel.serialIdController.text;
                            widget.continueClick!();
                          }
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("continue".tr(),
                          style: CustomTextStyle().semiBold12(
                              ColorUtil().getColor(
                                  context, ColorEnums.textDefaultLight)),),
                      )
                    ],
                  ),
                )

          ]
        ),
      );
    }
      )
    );
  }
 getList()async{
   await viewModel.getAssign(context);
 }

}
