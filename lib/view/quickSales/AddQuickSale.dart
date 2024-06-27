import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/quickSaleModel/quickSaleModel.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/view/quickSales/quickSaleStep/informationStep.dart';
import 'package:wizzsales/view/quickSales/quickSaleStep/priceStep.dart';
import 'package:wizzsales/view/quickSales/quickSaleStep/salesTeamStep.dart';
import 'package:wizzsales/view/quickSales/quickSaleStep/serialStep.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import '../../model/OLD/Sale.dart';


class AddQuickSale extends StatefulWidget {
   Sale sale = Sale();
   final QuickSaleModel? quickSaleModel;
   final int? demoLiveId;
   AddQuickSale(this.sale,this.quickSaleModel,this.demoLiveId, {super.key} );

  @override
  State<StatefulWidget> createState() => _AddSaleState();
}

class _AddSaleState extends State<AddQuickSale> {
  final ScrollController _controller = ScrollController();
  int _customCounter = 0;
  final int _stepCount = 3;

  List<Widget> pages = [];
  String totalPageCount = "3";

  @override
  void initState() {

    SaleVM.addSaleModel = widget.sale;
    SaleVM.addSaleModel.cname = widget.quickSaleModel!.cname ?? "";
    SaleVM.addSaleModel.cfirstname = widget.quickSaleModel!.cname ?? "";
    SaleVM.addSaleModel.clastname = widget.quickSaleModel!.clastname ?? "";
    SaleVM.addSaleModel.cemail = widget.quickSaleModel!.cEmail ?? "";
    SaleVM.addSaleModel.cphone = widget.quickSaleModel!.cphone ?? "";
    SaleVM.addSaleModel.cCode = widget.quickSaleModel!.cCode ?? "";
    SaleVM.addSaleModel.caddress = widget.quickSaleModel!.caddress ?? "";
    SaleVM.addSaleModel.ccounty = widget.quickSaleModel!.ccounty ?? "";
    SaleVM.addSaleModel.ccountry = widget.quickSaleModel!.ccountry ?? "";
    SaleVM.addSaleModel.cstate = widget.quickSaleModel!.cstate ?? "";
    SaleVM.addSaleModel.ccity = widget.quickSaleModel!.ccity ?? "";
    SaleVM.addSaleModel.czipcode = widget.quickSaleModel!.czipcode ?? "";
    SaleVM.addSaleModel.leadtype=widget.quickSaleModel!.leadType;
    pages = [
      SerialStep(continueClick: _incrementCustomStepper,step: "1", totalStepCount: totalPageCount),
      InformationStep(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step: "2", totalStepCount: totalPageCount),
      SalesTeamStep(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step: "3", totalStepCount: totalPageCount),
      PriceStep(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step: "4", totalStepCount: totalPageCount,demoId: widget.demoLiveId,),
    ];
    super.initState();
  }
  void _incrementCustomStepper() {
    setState(() {
      _controller.jumpTo(0);
      _customCounter++;
    });
  }

  void setPage(int page) {
    setState(() {
      _controller.jumpTo(0);
      _customCounter = _customCounter - page;
    });
  }

  void _decrementCustomStepper() {
    setState(() {
      if (_customCounter != 0) {
        _controller.jumpTo(0);
        _customCounter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(name: "addSale".tr(),),
        backgroundColor: ColorUtil().getColor(context,ColorEnums.background),
        body:Column(
          children: [
            ProgressStepper(
              width: sizeWidth(context).width,
              height: 2,
              padding: 0,
              stepCount: _stepCount,
              color: ColorUtil().getColor(context, ColorEnums.borderLight),
              progressColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
              currentStep: _customCounter,
              onClick: (int index) {
                setState(() {
                  _customCounter = index;
                });
              },
            ),
            Expanded(
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: SizedBox(

                        width: sizeWidth(context).width,
                        child: Center(
                          child: pages[_customCounter],
                        )
                    ),
                  ),
                )
            )
          ],
        )

    );
  }
}
