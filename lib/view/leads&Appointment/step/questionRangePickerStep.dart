import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/LeadQuestion.dart';
import 'package:wizzsales/model/OLD/Question.dart';
import 'package:wizzsales/model/OLD/leads.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';

class QuestionRangePickerStep extends StatefulWidget {
  VoidCallback? continueClick;
  VoidCallback? previousClick;
  String? step;
  String? totalStepCount;
  String questions = "";
   QuestionRangePickerStep({super.key, required this.continueClick, required this.previousClick, this.step, this.totalStepCount, required this.questions});

  @override
  State<QuestionRangePickerStep> createState() => _QuestionRangePickerStepState();
}

class _QuestionRangePickerStepState extends State<QuestionRangePickerStep> {
  int? questionId;
  Map<int, String> questionMap = {};
  final List<int> iddd =[];
  List<int> questionKeys =[];
  List<LeadsQuestion> salesQuestion =[];
  final List<String> _verticalGroupValue = List.generate(200, (i) => "");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        questionKeys = SaleVM.addLeadsModel.questionKeys!;

        questionKeys = SaleVM.addLeadsModel.questionKeys!;

        for(var element in SaleVM.addLeadsModel.listQuestion!.entries){
          questionMap.putIfAbsent(element.key, () => element.value);
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [
            Text("oneMoreQuestion".tr(),style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("pleaseSelector".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("${context.tr("step")} ${widget.step}/${widget.totalStepCount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ),

            const SizedBox(height: 20,),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(32, 24, 32, 24),
                  child: Text("indoorAirQuality".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(32, 72, 32, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: getQuestions(),
                  ),
                ),
            const SizedBox(height: 16,),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child:  Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: 44,
                              child: Center(
                                child: ElevatedButton(
                                  style: elevatedButtonStyle(context),
                                  onPressed: () {
                                    widget.previousClick!();
                                  },
                                  child:  Text("previous".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex:1,
                          child: SizedBox(
                            height: 44,
                            child: Center(
                              child: ElevatedButton(
                                style: elevatedButtonStyle(context),
                                onPressed: ()async {
                                  if (widget.step == widget.totalStepCount) {
                                    await postLeads();

                                  } else {
                                    SaleVM.addLeadsModel.questionKeys = questionKeys;
                                    widget.continueClick!();
                                  }

                                },
                                child:  Text(widget.step == widget.totalStepCount ? "complete".tr() : "continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]
    ),
      ),
    );
  }
  List<Widget> getQuestions() {

    List<Widget> questions = <Widget>[];
    questions.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text("poor1".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ),
            Expanded(
              child: Text("neutral".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)

            ),
            Expanded(
              child: Text("excellent10".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            )
          ],
        )
    );
    var json = jsonDecode(widget.questions);
    var tagObjsJson = json as List;
    List<Question> datas2 = tagObjsJson.map((tagJson) => Question.fromJson(tagJson)).toList();
    for (var element in datas2) {
      if (element.type == 0 && element.name != null && element.name!.contains('1 – 10')) {
        questions.add(
          questionText(element.name, element.id!),
        );
        if(iddd.isEmpty){
          iddd.add(element.id!);
        }
        questionId = element.id;

      }
    }
    return questions;
  }

  Widget questionText(name, int id) {
    return SfSlider(
      min: 0,
      max: 10,
      value: double.parse(_verticalGroupValue[id].isNotEmpty ? _verticalGroupValue[id] : "0"),
      interval: 1,
      stepSize: 1,
      enableTooltip: true,
      showDividers: true,
      inactiveColor: ColorUtil().getColor(context, ColorEnums.borderLight),
      activeColor: ColorUtil().getColor(context, ColorEnums.borderLight),
      thumbIcon: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtil().getColor(context, ColorEnums.wizzColor))
      ),
      minorTicksPerInterval: 1,
      onChanged: (dynamic value){
        setState(() {
          _verticalGroupValue[id] = value.toString();
        });
      },
    );
  }
   postLeads() async{
    for(var i in SaleVM.addLeadsModel.listQuestion!.entries){
      if(!questionMap.containsKey(i.key)){
        questionKeys.add(questionId!);
        questionMap.putIfAbsent(questionId!, () => _verticalGroupValue[questionId!]);
      }else{
        questionMap.remove(i.key);
        questionMap.putIfAbsent(questionId!, () => _verticalGroupValue[questionId!]);
      }
    }
    SaleVM.addLeadsModel.listQuestion!.addAll(questionMap);
    SaleVM.addLeadsModel.questionKeys = questionKeys;

    print("son question :${SaleVM.addLeadsModel.listQuestion}-- ${SaleVM.addLeadsModel.listQuestion!.length}");

    List<Questions> listQuestion =[];
    for(var i in SaleVM.addLeadsModel.listQuestion!.entries){

      var xx = <String,String>{};
      xx["\"${i.key}\" "] = "\"${i.value}\"";
      var x = Questions(id:i.key,answer: i.value);
      listQuestion.add(x);
    }
    for(var i in listQuestion){
      print("listee :${i.id} -- ${i.answer}");
    }

    int appointment =0;
    if(SaleVM.addLeadsModel.appointment==0){
      appointment=0;

      SaleVM.addLeadsModel.appointment=0;
      SaleVM.addLeadsModel.adate = "";
      SaleVM.addLeadsModel.atime="";
    }else{
      appointment=1;
      SaleVM.addLeadsModel.appointment=1;
      DateTime tempDate = DateFormat("yyyy-MM-dd").parse(SaleVM.addLeadsModel.adate.toString());
      DateTime tempTime = DateFormat("hh").parse(SaleVM.addLeadsModel.atime.toString());
      String formatterDate = DateFormat("yyyy-MM-dd").format(tempDate);
      String formatterTime = DateFormat("hh").format(tempTime);

      SaleVM.addLeadsModel.adate = formatterDate;
      SaleVM.addLeadsModel.atime = formatterTime;
      print("tarih saat :${SaleVM.addLeadsModel.adate} -- ${SaleVM.addLeadsModel.atime}");
    }
    String lastPhone = SaleVM.addLeadsModel.cphone!.replaceAll("-", "");
    String phoneType = "${SaleVM.addLeadsModel.cCdode!}-$lastPhone";
    print("son telefon : $phoneType -- $lastPhone-- ${SaleVM.addLeadsModel.cCdode}");
    String slastPhone="";
    String sphoneType="";
    if(SaleVM.addLeadsModel.sphone !=null){
      slastPhone = SaleVM.addLeadsModel.sphone!.replaceAll("-", "");
    }
    if(SaleVM.addLeadsModel.sCode!=null){
      sphoneType = "${SaleVM.addLeadsModel.sCode!}-$slastPhone";
    }

    Leads leads =Leads(date:DateTime.now(),leadid:SaleVM.addLeadsModel.leadid, cname :SaleVM.addLeadsModel.cfirstname
        ,cfirstname:SaleVM.addLeadsModel.cfirstname,clastname: SaleVM.addLeadsModel.clastname,cphone:phoneType,
        caddress:SaleVM.addLeadsModel.caddress,sname:SaleVM.addLeadsModel.sname,sfirstname:SaleVM.addLeadsModel.sfirstname,
        slastname:SaleVM.addLeadsModel.slastname,sphone:sphoneType,semail:SaleVM.addLeadsModel.semail,
        cemail:SaleVM.addLeadsModel.cemail,ccountry:SaleVM.addLeadsModel.ccountry,ccounty: SaleVM.addLeadsModel.ccounty,ccity:SaleVM.addLeadsModel.ccity,
        cstate:SaleVM.addLeadsModel.cstate,czipcode:SaleVM.addLeadsModel.czipcode,referredby:"",work:"",eventname:"",
        whereprospect:"",appointment: appointment,adate:SaleVM.addLeadsModel.adate,atime:SaleVM.addLeadsModel.atime,
        questions: listQuestion,listQuestion: SaleVM.addLeadsModel.listQuestion);


    String leadString = leadsToJson(leads);
    print(leadString);
    SaleVM.postLead(context,leadString);


  }
}
