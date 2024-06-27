import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/LeadQuestion.dart';
import 'package:wizzsales/model/OLD/Question.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';

class QuestionsStep extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? step;
  final String? totalStepCount;
  final String? questions;
  const QuestionsStep({super.key, required this.continueClick, required this.previousClick, this.step, this.totalStepCount,  this.questions});


  @override
  State<QuestionsStep> createState() => _QuestionsStepState();
}

class _QuestionsStepState extends State<QuestionsStep> {
  final List<String> _verticalGroupValue = List.generate(200, (i) => "");
  final List<String> _status = ["Yes", "No"];
  final List<String> _pet = ["Cat", "Dog", "Other"];
  Map<int,String> questionMap = {};
  final List<int> iddd =[];
  List<int> questionKeys =[];
  List<LeadsQuestion> salesQuestion =[];

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [
            Text("questions".tr(),style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("pleaseSelectQuestions".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("${context.tr("step")} ${widget.step}/${widget.totalStepCount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ),

            const SizedBox(height: 20,),

            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: getQuestions()
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
                                    for(var i in iddd){
                                      if(!questionMap.containsKey(i)){
                                        questionKeys.remove(i);
                                        questionMap.remove(i);
                                      }
                                    }
                                    SaleVM.addLeadsModel.listQuestion=questionMap;
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
                                  await check();
                                },
                                child:  Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
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
      ),
    );
  }

  List<Widget> getQuestions() {
    List<Widget> questions = <Widget>[];
    var json = jsonDecode(widget.questions!);
    var tagObjsJson = json as List;
    List<Question> datas2 = tagObjsJson.map((tagJson) => Question.fromJson(tagJson)).toList();

    for (var element in datas2) {
      if (element.name != "Married?" && element.type == 0) {
        questions.add(
          questionRadio(element.name, element.id!),
        );
        if(iddd.length<5){
          iddd.add(element.id!);
        }
      }
    }

    return questions;
  }

  Widget questionRadio(name, int id) {
    if (name == "Which pet?") {
      return Row(
          children: [
           Text(name,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

            Expanded(
              child: RadioGroup<String>.builder(
                direction: Axis.horizontal,
                groupValue: _verticalGroupValue[id],
                onChanged: (value) => setState(() {
                  _verticalGroupValue[id] = value!;
                }),
                items: _pet,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
                textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
              ),
            ),
          ]
      );
    } else {
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 15, 5),
          child: Row(children: [
            Expanded(
              child: Text(name,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ),
            Expanded(
              child: RadioGroup<String>.builder(
                direction: Axis.horizontal,
                groupValue: _verticalGroupValue[id],
                activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                onChanged: (value) => setState(() {
                  _verticalGroupValue[id] = value!;
                }),
                items: _status,
                textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                itemBuilder: (item) => RadioButtonBuilder(
                    item,
                    textPosition: RadioButtonTextPosition.right
                ),
              ),
            ),
          ]));
    }
  }
  check() async{
    for(var i in iddd){
      if(!questionMap.containsKey(i)){
        questionKeys.add(i);
        questionMap.putIfAbsent(i, () => _verticalGroupValue[i]);
      }
    }
    SaleVM.addLeadsModel.listQuestion=questionMap;
    SaleVM.addLeadsModel.questionKeys = questionKeys;
    print("questionMap :$questionMap  --${SaleVM.addLeadsModel.listQuestion!.length}");
    widget.continueClick!();
  }
}
