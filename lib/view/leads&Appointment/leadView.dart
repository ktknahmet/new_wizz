
// ignore_for_file: must_be_immutable, unnecessary_import, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/lead.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:intl/intl.dart';
import 'package:wizzsales/view/leads&Appointment/pages/doorCard/doorCardPager.dart';
import 'package:wizzsales/view/leads&Appointment/pages/doorKnocking/doorKnockingPager.dart';
import 'package:wizzsales/view/leads&Appointment/pages/freeVacation/freeVacationPager.dart';
import 'package:wizzsales/view/leads&Appointment/pages/homeShow/homeShowPager.dart';
import 'package:wizzsales/view/leads&Appointment/pages/inDoorQuality/inDoorQualityPager.dart';
import 'package:wizzsales/view/leads&Appointment/pages/lottery/LotteryPager.dart';
import 'package:wizzsales/view/leads&Appointment/pages/personal/personalPager.dart';
import 'package:wizzsales/view/leads&Appointment/pages/registrationBox/registrationBoxPager.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';

import 'pages/newReferral/newReferralPager.dart';

class LeadView extends StatefulWidget {
  int leadid = 0;
  int type = 1;

  int showaddress = 0;
  String title;
  String questions;
  LeadView(this.leadid, this.title, this.type, this.questions, {super.key});

  @override
  _LeadViewState createState() => _LeadViewState();
}

class _LeadViewState extends State<LeadView> with TickerProviderStateMixin {


  Lead lead = Lead();


  @override
  void initState() {
    super.initState();


  }

  @override
  void dispose() {
    deactivate();
    super.dispose();
  }

  ///* switch widget.type
  /// case 1: Door Card Registration - Indoor Air Quality Survey - Door Knocking
  /// case 2: Referral
  /// case 3: Registration Box
  /// case 4: Home Show
  /// case 5: Personal
  ///
  ///* switch widget.leadid
  /// case 1: Door Card Registration
  /// case 2: Referral
  /// case 3: Door Knocking
  /// case 5: Registration Box
  /// case 6: Personal
  /// case 7: Home Show
  /// case 8: Indoor Air Quality Survey
  ///
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
        appBar: DefaultAppBar(name: widget.title,),
        body: getWidget()

    );
  }

  Widget getWidget() {
    SaleVM.addLeadsModel.leadid=0;
    switch (widget.leadid) {
      case 1:
        {
          SaleVM.addLeadsModel.leadid = 1;
          return DoorCardPager(questions: widget.questions);
        }
      case 2:
        {
          SaleVM.addLeadsModel.leadid = 2;
          return NewReferralPager(questions: widget.questions);
        }
      case 3:
        {
          //door knocking
          SaleVM.addLeadsModel.leadid = 3;
          return DoorKnockingPager(questions: widget.questions);
        }
      case 5:
        {
          SaleVM.addLeadsModel.leadid = 5;
          return RegistrationBoxPager(questions: widget.questions);
        }
      case 6:
        {
          SaleVM.addLeadsModel.leadid = 6;
          return PersonalPager(questions: widget.questions);
        }
      case 7:
        {
          SaleVM.addLeadsModel.leadid = 7;
          return HomeShowPager(questions: widget.questions);
        }
      case 8:
        {
          SaleVM.addLeadsModel.leadid = 8;
          return InDoorQualityPager(questions: widget.questions);
        }
      case 10:
        {
          //lottery
          SaleVM.addLeadsModel.leadid = 10;
          return LotteryPager(questions: widget.questions);
        }
      case 11:
        {
          //lottery
          SaleVM.addLeadsModel.leadid = 11;
          return FreeVacationPager(questions: widget.questions);
        }
      default:

        return DoorCardPager(questions: widget.questions);

    }
  }
}

