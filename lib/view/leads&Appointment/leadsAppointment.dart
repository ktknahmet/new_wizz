import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/leads&Appointment/leadView.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

import '../../model/OLD/AllLeads.dart';

class LeadsAppointment extends BaseStatefulPage {
  const LeadsAppointment(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _LeadsAppointmentState();
}

class _LeadsAppointmentState extends BaseStatefulPageState<LeadsAppointment> {
  List<AllLeads> leads = [];
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
  Widget design() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline,
              color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),
            ),
            const SizedBox(width: 8,),
            SizedBox(
              width: sizeWidth(context).width*0.85,
              child: Text(
                "pleaseSelectLeads".tr(),
                style: CustomTextStyle().semiBold12(
                  ColorUtil().getColor(context, ColorEnums.textDefaultLight),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16,),
        SizedBox(
          height: sizeWidth(context).height*0.70,
          child: RefreshIndicator(
            onRefresh: getList,
            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
            child: ListView.builder(
              itemCount: leads.length,
              itemBuilder: (context,index){
                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          SaleVM.getQuestions(context, leads[index].id!)
                              .then((value) {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LeadView(
                                        leads[index].id!,
                                        leads[index].name.toString(),
                                        leads[index].type!,
                                        value)));
                            setState(() {});
                          });
                        },
                        child: Card(
                          shape: cardShape(context),
                          color: ColorUtil().getColor(context, ColorEnums.background),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8,right: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(leads[index].name!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );

  }
  Future<void> getList() async{
    return SaleVM.getAllLeads(context).then((value) {
      var json = jsonDecode(value);
      setState(() {
        var tagObjsJson = json as List;
        leads = tagObjsJson.map((tagJson) => AllLeads.fromJson(tagJson)).toList();
      });
    });
  }

}
