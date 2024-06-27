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
import 'package:wizzsales/view/quickSalesEnterValue/step/dateStep.dart';
import 'package:wizzsales/view/quickSalesEnterValue/step/infoStep.dart';
import 'package:wizzsales/view/quickSalesEnterValue/step/priceInfoStep.dart';
import 'package:wizzsales/view/quickSalesEnterValue/step/teamStep.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import '../../model/OLD/Sale.dart';


class QuickSaleValue extends StatefulWidget {
  Sale sale = Sale();
  QuickSaleValue(this.sale,{super.key} );

  @override
  State<StatefulWidget> createState() => _QuickSaleValueState();
}

class _QuickSaleValueState extends State<QuickSaleValue> {
  final ScrollController _controller = ScrollController();
  int _customCounter = 0;
  final int _stepCount = 4;

  List<Widget> pages = [];
  String totalPageCount = "4";

  @override
  void initState() {


    pages = [
      SerialStep(continueClick: _incrementCustomStepper,step: "1", totalStepCount: totalPageCount),
      DateStep(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step: "2", totalStepCount: totalPageCount),
      InfoStep(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step: "3", totalStepCount: totalPageCount),
      TeamStep(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step: "4", totalStepCount: totalPageCount),
      PriceInfoStep(page: setPage,continueClick: _incrementCustomStepper,step: "5", totalStepCount: totalPageCount),

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
        appBar: DefaultAppBar(name: "quickSale".tr(),),
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
