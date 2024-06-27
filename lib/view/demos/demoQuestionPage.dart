import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/demoModel/demoNote.dart';
import 'package:wizzsales/model/demoModel/demoQuestions.dart';
import 'package:wizzsales/model/demoModel/demoUnsuccessModel.dart';
import 'package:wizzsales/model/demoModel/postDemoQuestion.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/LiveDemoVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class DemoQuestionPage extends StatefulWidget {
  final DemoQuestions questions;
  final int demoId;

  const DemoQuestionPage(this.questions,this.demoId,{super.key});

  @override
  State<DemoQuestionPage> createState() => _DemoQuestionPageState();
}

class _DemoQuestionPageState extends State<DemoQuestionPage> {
  LiveDemoVm viewModel = LiveDemoVm();
  List<PostDemoQuestion> postDemoQuestion =[];
  List<DemoUnsuccessModel> demoUnsuccessModel =[];
  LoginUser? loginUser;
  TextEditingController note = TextEditingController();
  ScrollController controller = ScrollController();
  ScrollController controller1 = ScrollController();
  int? index;
  @override
  void initState() {
    getValue();
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: DefaultAppBar(name: "demoDetails".tr()),
      body: SizedBox(
          width: sizeWidth(context).width,
          height: sizeWidth(context).height,
          child: ChangeNotifierProvider.value(
            value: viewModel,
            child: Consumer<LiveDemoVm>(
              builder: (context,value,_){
                return  SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Column(
                        children: [
                          Text("pleaseFillQuestion".tr(),style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          Text("Step ${viewModel.questionStep}/2",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          const SizedBox(height: 8,),
                          Visibility(
                            visible: viewModel.radioQuestion,
                            child: SizedBox(
                              height: justList(context, sizeWidth(context).height),
                              child: RawScrollbar(
                                thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                                thumbVisibility: true,
                                thickness: 1,
                                trackVisibility: true,
                                controller: controller,
                                child: ListView.builder(
                                  controller: controller,
                                  itemCount: widget.questions.questions!.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shape:cardShape(context),
                                      color:ColorUtil().getColor(context, ColorEnums.background),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              const SizedBox(height: 8,),
                                              Text(
                                                widget.questions.questions![index].questionText!,
                                                style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                        value: "Yes",
                                                        groupValue: viewModel.getAnswerForQuestion(index),
                                                        onChanged: (value) {
                                                          viewModel.setAnswerForQuestion(index, value.toString());
                                                        },
                                                      ),
                                                      Text('Yes', style: TextStyle(color: ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                        value: "No",
                                                        groupValue: viewModel.getAnswerForQuestion(index),
                                                        onChanged: (value) {
                                                          viewModel.setAnswerForQuestion(index, value.toString());
                                                        },
                                                      ),
                                                      Text('No', style: TextStyle(color: ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                                    ],
                                                  )
                                                ],
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8,),

                          Visibility(
                            visible: viewModel.checkBoxQuestion,
                            child: Column(
                              children: [
                                Text("chooseReason".tr(), style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                SizedBox(
                                  height: sizeWidth(context).height*0.25,
                                  child: RawScrollbar(
                                    thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                                    thumbVisibility: true,
                                    thickness: 1,
                                    trackVisibility: true,
                                    controller: controller1,
                                    child: ListView.builder(
                                      controller: controller1,
                                      itemCount: widget.questions.reasons!.length,
                                      itemBuilder: (context,index){
                                        Reason model = widget.questions.reasons![index];
                                        return Card(
                                          shape: cardShape(context),
                                          color: ColorUtil().getColor(context, ColorEnums.background),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(model.reasonType!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                                Radio<bool>(
                                                  activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                  value: true,
                                                  groupValue: model.isChecked ?? false,
                                                  onChanged: (bool? v) {
                                                    viewModel.boolNote=true;
                                                    viewModel.setReason(index, true, widget.questions.reasons!);
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Visibility(
                              visible: viewModel.boolNote,
                              child:  accountCreate(context, "note", note),
                              ),
                          const SizedBox(height: 8,),

                      viewModel.boolNote ? SizedBox(
                            width: sizeWidth(context).width*0.80,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: ElevatedButton(
                                onPressed: ()async{
                                 await postOther();

                                },
                                style: elevatedButtonStyle(context),
                                child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              ),
                            ),
                          ) :SizedBox(
                        width: sizeWidth(context).width*0.80,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ElevatedButton(
                            onPressed: ()async{
                                if(viewModel.questionStep ==1){
                                  await postDemoQa();
                                }else{
                                  await postCheckBox();
                                }
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                        ),
                      ),
                        ]
                    ),
                  ),
                );
              },
            ),
          )
      ),
    );
  }
  getValue()async{
    SharedPref pref = SharedPref();
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
  }
  postDemoQa()async{

    if(viewModel.answers[0].isNotEmpty && viewModel.answers[1].isNotEmpty && viewModel.answers[2].isNotEmpty){

      for(int i=0;i<widget.questions.questions!.length;i++){
        PostDemoQuestion question = PostDemoQuestion(
          demoId: widget.demoId,
          userId: loginUser!.profiles![index!].id!,
          questionId: widget.questions.questions![i].questionId!,
          answerText: viewModel.answers[i],
        );
        postDemoQuestion.add(question);
      }
      await viewModel.postDemoDetail(context,postDemoQuestion);
    }else{
      snackBarDesign(context, StringUtil.error, "pleaseFillQuestion".tr());
    }
  }
  postCheckBox()async{
    demoUnsuccessModel.clear();
    for(int i=0;i<widget.questions.reasons!.length;i++){
      if(widget.questions.reasons![i].isChecked==true){
        DemoUnsuccessModel model = DemoUnsuccessModel(
            demoId: widget.demoId,
            userId: loginUser!.profiles![index!].id!,
            reasonTypeId: widget.questions.reasons![i].reasonTypeId!
        );
        demoUnsuccessModel.add(model);
      }
    }
    if(demoUnsuccessModel.isNotEmpty){
      await viewModel.postDemoUnQuestion(context,demoUnsuccessModel);
      if(viewModel.demoUnResponse !=null){
        snackBarDesign(context, StringUtil.success, "questionSent".tr());
         Navigator.pop(context);
      }
    }
  }
  postNote()async{
    DemoNote demoNote =DemoNote(
        demoId: widget.demoId,
        demoNote: note.text
    );
    if(note.text.isNotEmpty){
      await viewModel.postDemoNote(context, demoNote);
    }else{
      snackBarDesign(context, StringUtil.error, "requiredNote".tr());
    }
  }
  postOther() async{
    demoUnsuccessModel.clear();
    for(int i=0;i<widget.questions.reasons!.length;i++){
      if(widget.questions.reasons![i].isChecked==true){
        DemoUnsuccessModel model = DemoUnsuccessModel(
            demoId: widget.demoId,
            userId: loginUser!.profiles![index!].id!,
            reasonTypeId: widget.questions.reasons![i].reasonTypeId!
        );
        demoUnsuccessModel.add(model);
      }
    }
    if(demoUnsuccessModel.isNotEmpty){
      await viewModel.postDemoUnQuestion(context,demoUnsuccessModel);
      if(viewModel.demoUnResponse !=null){
        await postNote();
      }
    }
  }

}
