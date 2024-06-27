import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/leads.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class AppointmentStep extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? step;
  final String? totalStepCount;
  const AppointmentStep({super.key, required this.continueClick, required this.previousClick, this.step, this.totalStepCount});

  @override
  State<AppointmentStep> createState() => _AppointmentStepState();
}

class _AppointmentStepState extends State<AppointmentStep> {
var radioGrup="";
final List<String> _verticalGroupValue = List.generate(200, (i) => "");
final List<String> _status = ["Yes, I'd like.", "No, I would not."];
TextEditingController dateInput=TextEditingController();
TextEditingController time = TextEditingController();
TimeOfDay selectTime =TimeOfDay.now();

String formatterTime="";
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() {
      print("seçilen saat :${selectTime.hour}:${selectTime.minute}");
      dateInput.text = mmDDYDate(DateTime.now().toString());


      if(radioGrup=="Yes, I'd like."){
        radioGrup = (SaleVM.addLeadsModel.appointment ?? 1).toString();
        if(SaleVM.addLeadsModel.date !=null){
          dateInput.text =mmDDYDate(SaleVM.addLeadsModel.date!.toString());
        }


      }else{
        radioGrup = (SaleVM.addLeadsModel.appointment ?? 0).toString();

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
            Text("scheduleAppointment".tr(),style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
                  padding: const EdgeInsets.fromLTRB(20, 24, 32, 24),
                  child: RadioGroup<String>.builder(
                    direction: Axis.vertical,
                    groupValue: _verticalGroupValue[1],
                    activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    onChanged: (value) => setState(() {
                      _verticalGroupValue[1] = value!;
                      radioGrup= value;
                    }),
                    items: _status,
                    itemBuilder: (item) => RadioButtonBuilder(
                        item,
                        textPosition: RadioButtonTextPosition.right
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: (radioGrup =="Yes, I'd like.") ? true : false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("appointmentDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    decoration: dateInputDecoration(context,"appointmentDate"),
                    controller: dateInput,
                    readOnly: true,
                    onTap: () async{
                      dateInput.text = await DatePickerHelper.getDatePicker(context);
                    },
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("appointmentTime".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    decoration: dateInputDecoration(context,"appointmentTime"),
                    controller: time,
                    readOnly: true,
                    onTap: () async{
                      selectTime = await DatePickerHelper.getTimePicker(context);
                      setState(() {
                        time.text =convertTo12HourFormat(selectTime.hour).toString();
                        formatterTime = selectTime.hour.toString();


                      });

                    },
                  ),
                ],
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
                                    if(radioGrup=="Yes, I'd like."){
                                      SaleVM.addLeadsModel.appointment =1;
                                      SaleVM.addLeadsModel.adate = formatDateString(dateInput.text,"MM-dd-yyyy","yyyy-MM-dd");
                                      SaleVM.addLeadsModel.atime =formatterTime;
                                    }else{
                                      SaleVM.addLeadsModel.appointment= 0;
                                    }
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
      ),
    );
  }
postLeads() async{
  List<Questions> listQuestion =[];
  if(SaleVM.addLeadsModel.listQuestion !=null){
    for(var i in SaleVM.addLeadsModel.listQuestion!.entries){

      var xx = <String,String>{};
      xx["\"${i.key}\" "] = "\"${i.value}\"";
      var x = Questions(id:i.key,answer: i.value);
      listQuestion.add(x);
    }
  }



  if(radioGrup=="Yes, I'd like."){
    SaleVM.addLeadsModel.appointment =1;


    String formatterDate = formatDateString(dateInput.text,"MM-dd-yyyy","yyyy-MM-dd");
    SaleVM.addLeadsModel.adate = formatterDate;
    SaleVM.addLeadsModel.atime =formatterTime;

  }else{
    SaleVM.addLeadsModel.appointment= 0;
    SaleVM.addLeadsModel.adate = "";
    SaleVM.addLeadsModel.atime ="";
  }

  String lastPhone = SaleVM.addLeadsModel.cphone!.replaceAll("-", "");
  String phoneType = "${SaleVM.addLeadsModel.cCdode!}-$lastPhone";
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
      whereprospect:"",appointment: SaleVM.addLeadsModel.appointment,adate:SaleVM.addLeadsModel.adate,atime:SaleVM.addLeadsModel.atime,
      questions: listQuestion,listQuestion: SaleVM.addLeadsModel.listQuestion);


  String leadString = leadsToJson(leads);
  print("post lead bilgi :$leadString");
  print("tarih :${SaleVM.addLeadsModel.adate}");
  SaleVM.postLead(context,leadString);

}
}
