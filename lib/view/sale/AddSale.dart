
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/view/sale/saleStep/completeSale.dart';
import 'package:wizzsales/view/sale/saleStep/eighthSale.dart';
import 'package:wizzsales/view/sale/saleStep/fifthSale.dart';
import 'package:wizzsales/view/sale/saleStep/firstSale.dart';
import 'package:wizzsales/view/sale/saleStep/fourthSale.dart';
import 'package:wizzsales/view/sale/saleStep/secondSale.dart';
import 'package:wizzsales/view/sale/saleStep/seventhSale.dart';
import 'package:wizzsales/view/sale/saleStep/sixthSale.dart';
import 'package:wizzsales/view/sale/saleStep/thirdSale.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

import '../../model/OLD/Sale.dart';

class AddSale extends StatefulWidget {
    Sale sale = Sale();

    AddSale(this.sale,{super.key} );

  @override
  State<StatefulWidget> createState() => _AddSaleState();
}

class _AddSaleState extends State<AddSale> {
  int _customCounter = 0;
  final int _stepCount = 8;
  final ScrollController _controller = ScrollController();
  List<Widget> pages = [];
  String totalPageCount = "8";

  @override
  void initState() {

    SaleVM.addSaleModel = widget.sale;
    pages = [
      FirstSale(continueClick: _incrementCustomStepper,step: "1", totalStepCount: totalPageCount),
      SecondSale(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step: "2", totalStepCount: totalPageCount),
      ThirdSale(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper, step: "3", totalStepCount: totalPageCount),
      FourthSale(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step:"4", totalStepCount: totalPageCount),
      FifthSale(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step:"5", totalStepCount: totalPageCount),
      SixthSale(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step:"6", totalStepCount: totalPageCount),
      SeventhSale(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step:"7", totalStepCount: totalPageCount),
      EighthSale(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper,step:"8", totalStepCount: totalPageCount),
      CompleteSale(page: setPage,),
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
