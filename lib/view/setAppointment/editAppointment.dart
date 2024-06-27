import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/appointmentModel/appointmentValues/AppintmentValues.dart';
import 'package:wizzsales/model/appointmentModel/dealerList.dart';
import 'package:wizzsales/model/appointmentModel/editAppointmentModel/editAppointment.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/MyAppointmentVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../model/appointmentModel/Data.dart';

class EditAppointment extends StatefulWidget {
  final Data? data;
  const EditAppointment(this.data,{super.key});

  @override
  State<EditAppointment> createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<EditAppointment> {
  MyAppointmentVm viewModel = MyAppointmentVm();
  String cCountryCode="US";
  String sCountryCode="US";
  int? dealerId;
  int? statusCode;
  TextEditingController referredBy = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController cPhone = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController appointmentDate = TextEditingController();
  TimeOfDay selectTime =TimeOfDay.now();
  TextEditingController timeController = TextEditingController();
  String? time;
  List<DealerList> dealerList = [];
  List<Employee> statusList=[];

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: DefaultAppBar(name: "editAppointment".tr(),),
      body:  SizedBox(
          width: sizeWidth(context).width,
          height: sizeWidth(context).height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChangeNotifierProvider.value(
              value: viewModel,
              child: Consumer<MyAppointmentVm>(
                builder: (context,value,_){
                  if(viewModel.values ==null){
                    return spinKit(context);
                  }else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            shape: cardShape(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("leadType".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  Text(widget.data!.leadtypename ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                              
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            shape: cardShape(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("collectedBy".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  Text(widget.data!.uname ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          accountCreate(context, "referredBy", referredBy),
                          const SizedBox(height: 8,),
                          accountCreate(context, "prospectFirstName", firstName),
                          const SizedBox(height: 8,),
                          accountCreate(context, "prospectLastName", lastName),
                          const SizedBox(height: 8,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child:Text("prospectPhone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          IntlPhoneField(
                            decoration:phoneDecoration(context),
                            flagsButtonMargin: const EdgeInsets.only(left: 20),
                            disableLengthCheck: true,
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            dropdownTextStyle:CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [maskFormatter],
                            showCountryFlag: true,
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            controller: cPhone,
                            initialCountryCode:cCountryCode,
                            showDropdownIcon: true,
                            dropdownIconPosition: IconPosition.trailing,
                            onCountryChanged: (code){
                              setState(() {
                                cCountryCode= code.dialCode;
                              });


                            },
                          ),
                          const SizedBox(height: 8,),
                          mailCreate(context, "prospectEmail", cEmail),
                          const SizedBox(height: 8,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child:Text("sPhone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                          ),

                          const SizedBox(height: 8,),
                          accountCreate(context, "prospectAddress", address),
                          const SizedBox(height: 8,),
                          accountCreate(context, "zipCode", zipCode),
                          const SizedBox(height: 8,),
                          accountCreate(context, "city", city),
                          const SizedBox(height: 8,),
                          accountCreate(context, "state", state),
                          const SizedBox(height: 8,),
                          accountCreate(context, "county", county),
                          const SizedBox(height: 8,),
                          accountCreate(context, "country", country),
                          const SizedBox(height: 8,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("status".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            decoration: containerDecoration(context),
                            width: sizeWidth(context).width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:   DropdownButton<Employee>(
                                dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                underline: const SizedBox(),
                                hint: Text("status".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                value: statusCode != null && statusList.any((dealer) => dealer.id == statusCode)
                                    ? statusList.firstWhere((element) => element.id == statusCode)
                                    : null,
                                onChanged: (Employee? newValue) {
                                  setState(() {
                                    statusCode = newValue!.id!;
                                  });
                                },
                                items: statusList.map<DropdownMenuItem<Employee>>((Employee status) {
                                  return DropdownMenuItem<Employee>(

                                    value: status,
                                    child:Text(status.name!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),

                                  );
                                }).toList(),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8,),
                          accountCreate(context, "comment", comment),
                          const SizedBox(height: 8,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child:Text("reAppointmentDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                          ),
                          const SizedBox(height: 4,),
                          TextField(
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            decoration: dateInputDecoration(context,"reAppointmentDate"),
                            controller: appointmentDate,
                            readOnly: true,
                            onTap: () async{
                              appointmentDate.text = await DatePickerHelper.getDatePicker(context);
                            },
                          ),
                          const SizedBox(height: 8,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("reAppointmentTime".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                          const SizedBox(
                            height: 4,
                          ),
                          TextField(
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            decoration: dateInputDecoration(context,"reAppointmentTime"),
                            controller: timeController,
                            readOnly: true,
                            onTap: () async{
                              selectTime = await DatePickerHelper.getTimePicker(context);
                              setState(() {
                                timeController.text = convertTo12HourFormat(selectTime.hour).toString();
                                time = selectTime.hour.toString();
                              });
                            },
                          ),
                          const SizedBox(height: 8,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("dealer".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            decoration: containerDecoration(context),
                            width: sizeWidth(context).width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:   DropdownButton<DealerList>(
                                dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                underline: const SizedBox(),
                                hint: Text("dealer".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                value: dealerId != null && dealerList.any((dealer) => dealer.id == dealerId)
                                    ? dealerList.firstWhere((element) => element.id == dealerId)
                                    : null,
                                onChanged: (DealerList? newValue) {
                                  setState(() {
                                    dealerId = newValue?.id; // Null safety'den dolayı burada '?.' kullanıyoruz.
                                  });
                                },
                                items: dealerList.map<DropdownMenuItem<DealerList>>((DealerList dealer) {
                                  return DropdownMenuItem<DealerList>(
                                    value: dealer,
                                    child: Text(dealer.name!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          //dealer gelecek
                          widget.data!.answers !=null && widget.data!.answers!.isNotEmpty ?
                              Column(
                               children: [
                                Text("answer".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                 ListView.builder(
                                   itemCount: widget.data!.answers!.length,
                                   itemBuilder: (context,index){
                                     return Card(
                                       color: ColorUtil().getColor(context, ColorEnums.background),
                                       shape: cardShape(context),
                                       child: Column(
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text(widget.data!.answers![index].question!.question!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                               Text(widget.data!.answers![index].answer ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                             ],
                                           )
                                         ],
                                       ),
                                     );
                                   },
                                 ),
                               ],
                              ):Container(),
                          const SizedBox(height: 8,),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ChangeNotifierProvider<LocationProvider>(
                                  create: (_)=>LocationProvider(),
                                  child: Consumer<LocationProvider>(
                                    builder: (context,value,_){

                                      return ElevatedButton(
                                        style: elevatedButtonStyle(context),
                                        onPressed: () async{
                                          await value.getLocationDetails(context);
                                          zipCode.text = value.locationDetails["zipcode"] ?? "";
                                          country.text = value.locationDetails["country"] ?? "";
                                          county.text = value.locationDetails["county"] ?? "";
                                          state.text = value.locationDetails["state"] ?? "";
                                          city.text = value.locationDetails["city"] ?? "";
                                          address.text = value.locationDetails["street"] ?? "";

                                        },
                                        child:  Text("fillFromLocation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      );

                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  style: elevatedButtonStyle(context),
                                  onPressed: () async{
                                    await post();
                                  },
                                  child:  Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            )
          ),
        ),
      
    );
  }
  getList()async{
   await viewModel.appointmentValue(context,widget.data!.id!);
   referredBy.text = widget.data!.referredby ?? "";
   firstName.text = widget.data!.cfirstname ?? "";
   lastName.text = widget.data!.clastname ?? "";
   cEmail.text = widget.data!.cemail ?? "";
   address.text = widget.data!.caddress ?? "";
   zipCode.text = widget.data!.czipcode ?? "";
   comment.text = widget.data!.comment ?? "";
   appointmentDate.text = mmDDYDate(widget.data!.appointmentdate.toString()) ?? "";
   cPhone.text = extractPhoneNumber(widget.data!.cphone ?? "");
   statusCode = viewModel.values!.adid!;
   dealerId=widget.data!.dealer!;
   dealerList.clear();
   statusList.clear();


   if(statusCode!<3){
     for(int i=4;i<viewModel.values!.statusForm!.length;i++){
       var employee = viewModel.values!.statusForm![i];
       statusList.add(Employee(id: employee.id, name: employee.name));
     }
   }else{
     for(int i=1;i<viewModel.values!.statusForm!.length;i++){
       var employee = viewModel.values!.statusForm![i];
       statusList.add(Employee(id: employee.id, name: employee.name));
     }
   }
   for (int i = 0; i < viewModel.values!.employee!.length; i++) {
     var employee = viewModel.values!.employee![i];
     dealerList.add(DealerList(id: employee.id, name: employee.name));
   }
   for (int i = 0; i < viewModel.values!.employee2!.length; i++) {
     var employee = viewModel.values!.employee2![i];
     dealerList.add(DealerList(id: employee.id, name: employee.name));
   }
  }
  post() async{

    if(cCountryCode =="US"){
      cCountryCode ="1";
    }
    if(sCountryCode=="US"){
      sCountryCode="1";
    }
    String phone = "+$cCountryCode-${cPhone.text}";
    bool customerMail = false;



    if(cEmail.text.isNotEmpty){
      customerMail = isEmail(cEmail.text);
    }

    if(cPhone.text.length !=10){
      snackBarDesign(context, StringUtil.warning, "phoneMustDigit".tr());
    }else{
      if(customerMail){
        EditAppointmentModel postModel =EditAppointmentModel (id: widget.data!.id!,cfirstname: firstName.text,
            clastname: lastName.text,cphone:phone,astatus: statusCode,sfirstname: "",slastname: "",
            sphone: "",cemail: cEmail.text.toLowerCase(),semail: "",registerby: widget.data!.user,caddress: address.text,ccity: city.text,
            cstate: state.text,czipcode: zipCode.text,ccounty: county.text,ccountry: country.text,comment: comment.text,dealer: dealerId,
            rdate1: appointmentDate.text,rdate2: time);
        await viewModel.postAppointment(context, postModel);
      }else{
        snackBarDesign(context, StringUtil.warning, "emailTypeWrong".tr());
      }

    }

    if(viewModel.response !=null){
      snackBarDesign(context, StringUtil.success, "updatedAppointment".tr());
      Navigator.pushNamed(context, '/${PageName.myAppointment}');
    }

  }
}
