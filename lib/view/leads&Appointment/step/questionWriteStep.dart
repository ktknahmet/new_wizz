import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/LeadQuestion.dart';
import 'package:wizzsales/model/OLD/Question.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WizzTextField.dart';

class QuestionWriteStep extends StatefulWidget {
  VoidCallback? continueClick;
  VoidCallback? previousClick;
  String? step;
  String? totalStepCount;
  String questions = "";
   QuestionWriteStep({super.key,
    required this.continueClick,
    required this.previousClick,
    this.step,
    this.totalStepCount,
    required this.questions});

  @override
  State<QuestionWriteStep> createState() => _QuestionWriteStepState();
}


class _QuestionWriteStepState extends State<QuestionWriteStep> {
  final List<int> iddd = [];
  List<LeadsQuestion> salesQuestion = [];
  Map<int, String> questionMap = {};
  List<int> questionKeys =[];
  final List<String> _verticalGroupValue = List.generate(200, (i) => "");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {

        questionKeys = SaleVM.addLeadsModel.questionKeys!;

        for(var element in SaleVM.addLeadsModel.listQuestion!.entries){
          questionMap.putIfAbsent(element.key, () => element.value);
        }

        print("gelen question Write :  $questionMap");
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
            Text("questions".tr(),style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("pleaseFillInfo".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("${context.tr("step")} ${widget.step}/${widget.totalStepCount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ),

            const SizedBox(height: 20,),

            Container(
              margin: const EdgeInsets.fromLTRB(32, 20, 32, 0),
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
    var json = jsonDecode(widget.questions);
    var tagObjsJson = json as List;
    List<Question> datas2 =
    tagObjsJson.map((tagJson) => Question.fromJson(tagJson)).toList();

    for (var element in datas2) {
      if (element.type == 1) {
        questions.add(
          questionText(element.name, element.id!),
        );
        if (iddd.length < 2) {
          iddd.add(element.id!);
        }

      }
    }

    return questions;
  }

  Widget questionText(name, int id) {
    return Container(
        padding: const EdgeInsets.only(bottom: 32),
        width: sizeWidth(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            const SizedBox(
              height: 4,
            ),
            WizzTextField(
              hint: "pleaseAnswerHere",
              maxLines: 4,
              height: 66,
              hintTextColor: ColorEnums.textDefaultLight,
              hintTextSize: 14,
              borderColor: ColorEnums.shadowDefaultLight,
              borderWidth: 1.0,
              textColor: ColorEnums.textDefaultLight,
              isObsecure: null,
              onChanged: (text) {
                setState(() {
                  _verticalGroupValue[id] = text;
                });
              },
            ),
          ],
        ));
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
