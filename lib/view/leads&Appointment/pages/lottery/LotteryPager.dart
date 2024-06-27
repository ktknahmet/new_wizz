import 'package:flutter/material.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/view/leads&Appointment/step/addressInfoStep.dart';
import 'package:wizzsales/view/leads&Appointment/step/appointmentStep.dart';
import 'package:wizzsales/view/leads&Appointment/step/customerInfoStep.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class LotteryPager extends StatefulWidget {
  final String? questions;
  const LotteryPager({super.key,this.questions});

  @override
  State<LotteryPager> createState() => _LotteryPagerState();
}

class _LotteryPagerState extends State<LotteryPager> {
  int _customCounter = 0;
  final int _stepCount = 2;
  Size? size;
  List<Widget> pages = [];
  String totalPageCount = "3";
  @override
  void initState() {
    super.initState();

    pages = [
      CustomerInfoStep(continueClick: _incrementCustomStepper, step: "1", totalStepCount: totalPageCount),
      AddressInfoStep(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper, step: "2", totalStepCount: totalPageCount),
      AppointmentStep(continueClick: _incrementCustomStepper, previousClick: _decrementCustomStepper, step: "3", totalStepCount: totalPageCount),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _incrementCustomStepper() {
    setState(() {
      _customCounter++;
    });
  }

  void setPage(int page) {
    setState(() {
      _customCounter = _customCounter - page;
    });
  }

  void _decrementCustomStepper() {
    setState(() {
      if (_customCounter != 0) {
        _customCounter--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProgressStepper(
          width: sizeWidth(context).width,
          height: 4,
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
        const SizedBox(height: 8,),
        Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                  width: sizeWidth(context).width,
                  child: Center(
                    child: pages[_customCounter],
                  )
              ),
            )
        ),
      ],
    );
  }
}
