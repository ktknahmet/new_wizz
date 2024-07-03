import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Draw.dart';
import 'package:wizzsales/model/OLD/register/DistributorSubType.dart';
import 'package:wizzsales/utils/OLD/LocalStorageApp.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/OLDExtention.dart';
import 'package:wizzsales/widgets/WizzTextField.dart';

class ThirdSale extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? step;
  final String? totalStepCount;

  const ThirdSale({super.key, required this.continueClick,this.previousClick,this.step, this.totalStepCount});

  @override
  State<ThirdSale> createState() => _ThirdSaleState();
}

class _ThirdSaleState extends State<ThirdSale> {
  List<Draw> listAppointment = [];
  List<Draw> tempListAppointment = [];
  List<DistributorSubType> _drawList = [];

  String? currentText;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeWidth(context).height,
      child: Column(
        children: [
          Text("customerType".tr(),style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
          Text("pleaseSelect".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
          const SizedBox(height: 8,),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("${context.tr("step")} 3/${widget.totalStepCount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
          ),
          const SizedBox(height: 30,),
           CupertinoSegmentedControl(

                children: {
                  "lead/apt".tr():Container(
                    width:sizeWidth(context).width*0.40,
                    height:sizeWidth(context).height*0.20,
                    color: currentText=="lead/apt".tr() ?
                    ColorUtil().getColor(context, ColorEnums.wizzColor) :ColorUtil().getColor(context, ColorEnums.background),

                    child: Align(
                      alignment: Alignment.center,
                      child: Text("lead/apt".tr(),style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                      ),
                    )
                  ),
                  "new".tr():Container(
                      width:sizeWidth(context).width*0.40,
                      height:sizeWidth(context).height*0.20,
                      color:  currentText=="new".tr() ?
                      ColorUtil().getColor(context, ColorEnums.wizzColor) :ColorUtil().getColor(context, ColorEnums.background),

                      child: Align(
                        alignment: Alignment.center,
                        child: Text("new".tr(),style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                        ),
                      )
                  ),
                },
                onValueChanged: (String value){
                  setState(() {
                    currentText = value;

                  });
                }
            ),

          const SizedBox(height: 8,),
            Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        widget.previousClick!();
                      },
                      style: elevatedButtonStyle(context),
                      child: Text("previous".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                       if(currentText==null || currentText!.isEmpty){
                         snackBarDesign(context, StringUtil.warning, "pleaseSelectCustomerType".tr());
                       }else{
                         if(currentText =="lead/apt".tr()){
                           getList(context);
                         }else{
                           nextPage();
                         }
                       }

                      },
                      style: elevatedButtonStyle(context),
                      child: Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    )
                  ],
                ),
              )


        ],
      ),
    );
  }
  nextPage(){
    if (SaleVM.addSaleModel.selectedCustomerType == 1) {
      SaleVM.addSaleModel.drawCode = "";
      SaleVM.addSaleModel.cfirstname = "";
      SaleVM.addSaleModel.clastname = "";
      SaleVM.addSaleModel.cemail = "";
      SaleVM.addSaleModel.cphone = "";
      SaleVM.addSaleModel.sfirstname = "";
      SaleVM.addSaleModel.slastname = "";
      SaleVM.addSaleModel.semail = "";
      SaleVM.addSaleModel.sphone = "";
    }
    SaleVM.addSaleModel.selectedCustomerType = 2;
    widget.continueClick!();
  }
  Future getList(BuildContext context) {
    _drawList = [];

    return SaleVM.getLeads(context).then((value) {

      listAppointment = value;
      if (listAppointment.isNotEmpty) {
        tempListAppointment = [...listAppointment];
      }
      LocalStorageApp.customerList.clear();
      if (LocalStorageApp.drawList.isNotEmpty) {
        for (var draw in LocalStorageApp.drawList) {
          LocalStorageApp.customerList.add(draw);
        }
      }
      if (listAppointment.isNotEmpty) {
        for (var draw in listAppointment) {
          LocalStorageApp.customerList.add(draw);
        }
      }
      if (listAppointment.isNotEmpty) {
        for (var element in listAppointment) {
          DistributorSubType type = DistributorSubType();
          type.id = element.id;
          type.name = '${element.cfirstname ?? ""} ${element.clastname ?? ""}';
          _drawList.add(type);
        }
      }
      print("lead type :${_drawList.length}");

      clearFocus(context);
      showCustomDialog(
          context,
          DrawDialog(
              _drawList,
              "Customer",
              context,
              widget.continueClick));
      setState(() {});
    });

  }

}



class DrawDialog extends StatefulWidget {
  List<DistributorSubType> list = [];
  String tab;
  String? type;
  BuildContext mcontext;
  VoidCallback? continueClick;

  DrawDialog(
      this.list,
      this.tab,
      this.mcontext,
      this.continueClick, {super.key});

  @override
  _DrawDialogState createState() => _DrawDialogState();
}

class _DrawDialogState extends State<DrawDialog> {

  TextEditingController searchController = TextEditingController();

  List<DistributorSubType> tempList = [];
  List<DistributorSubType> liste = [];

  String? type;
  String? tab;

  @override
  void initState() {
    super.initState();
    type = widget.type;
    tab = widget.tab;
    liste.addAll(widget.list);

    if (tempList.isEmpty) {
      tempList.addAll(liste);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Select Lead",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        Container(
          margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
          height: 44,
          child:  WizzTextField(
            hint: "search",
            textEditingController: searchController,
            hintTextColor: ColorEnums.textDefaultLight,
            hintTextSize: 14,
            borderColor: ColorEnums.textDefaultLight,
            borderWidth: 1.0,
            textColor: ColorEnums.textDefaultLight,
            leadingIconColor: ColorEnums.textTitleLight,
            onChanged: (value) {
              tempList.clear();
              if (value.isNotEmpty) {
                for (var item in liste) {
                  if (item.name != null ? item.name!.toLowerCase().contains(value.toLowerCase()) : false) {
                    tempList.add(item);
                  }
                }
                setState(() {});
              } else {
                setState(() {
                  tempList.clear();
                  tempList.addAll(liste);
                });
              }
            },
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: tempList.length,
            itemBuilder: (BuildContext context, int index) {
              DistributorSubType item = tempList[index];
              return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Draw draw = LocalStorageApp.customerList.where((element) => element.id! == item.id).first;
                    SaleVM.addSaleModel.drawCode = draw.code;
                    SaleVM.addSaleModel.cfirstname = draw.cfirstname;
                    SaleVM.addSaleModel.clastname = draw.clastname;
                    SaleVM.addSaleModel.cemail = draw.cemail;
                    SaleVM.addSaleModel.ccity = draw.ccity;
                    SaleVM.addSaleModel.cstate = draw.cstate;
                    SaleVM.addSaleModel.czipcode = draw.czipcode;
                    SaleVM.addSaleModel.ccountry = draw.ccountry;
                    SaleVM.addSaleModel.ccounty = draw.ccounty;
                    SaleVM.addSaleModel.ccountry = draw.ccountry;
                    SaleVM.addSaleModel.caddress = draw.caddress;

                    if (draw.cphone2 != null && draw.cphone2!.isNotEmpty) {

                      SaleVM.addSaleModel.cphone = extractPhoneNumber(draw.cphone ?? "");
                    }
                    if (draw.sfirstname != null && draw.sfirstname!.isNotEmpty) {
                      SaleVM.addSaleModel.sfirstname = draw.sfirstname;
                    }
                    if (draw.slastname != null && draw.slastname!.isNotEmpty) {
                      SaleVM.addSaleModel.slastname = draw.slastname;
                    }
                    if (draw.semail != null && draw.semail!.isNotEmpty) {
                      SaleVM.addSaleModel.semail = draw.semail;
                    }
                    if (draw.sphone2 != null && draw.sphone2!.isNotEmpty) {
                      var phone = draw.sphone2!.split("#");
                      if (phone.length == 3) {
                        SaleVM.addSaleModel.sphone = phone[2];
                      }
                    }
                    SaleVM.addSaleModel.selectedCustomerType = 1;
                    widget.continueClick!();
                  },
                  child: ListTile(
                    title: Text(item.name ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  ));
            })
      ],
    );
  }
}
