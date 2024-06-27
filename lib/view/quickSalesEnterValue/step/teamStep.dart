import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Distributor.dart';
import 'package:wizzsales/model/OLD/Sale.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SaleVm.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/OldViewUtis.dart';
import 'package:wizzsales/widgets/WizzTextField.dart';

import '../../../model/OLD/register/DistributorSubType.dart';

class TeamStep extends StatefulWidget {
  final VoidCallback? continueClick;
  final VoidCallback? previousClick;
  final String? step;
  final String? totalStepCount;
  const TeamStep({super.key, required this.continueClick,this.previousClick,this.step, this.totalStepCount});

  @override
  State<TeamStep> createState() => _TeamStepState();
}

class _TeamStepState extends State<TeamStep> {
  Distributor? distributor;

  TextEditingController editingController = TextEditingController();
  @override
  void initState() {

    UserVM.getDistributors(context).then((value) {
      if (value != null) {
        distributor = value;
      }
    });
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
          Text("salesTeam".tr(),style: CustomTextStyle().black20(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
          Text("fillInformation".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("${"step".tr()} 4/${widget.totalStepCount!}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
          ),
          const SizedBox(height: 40,),

          Align(
              alignment: Alignment.centerLeft,
              child: Text("salesManager".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
          const SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              clearFocus(context);
              showPickerDialog1(distributor!.sm ?? [], "SM");
            },
            child: Container(
              width: sizeWidth(context).width,
              height: 50,
              decoration: containerDecoration(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(SaleVM.addSaleModel.sm != null ? SaleVM.addSaleModel.sm!.name ?? "Select" : "Select",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("dps".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
          const SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              clearFocus(context);
              showPickerDialog1(distributor!.dps ?? [], "DPS");
            },
            child: Container(
              width: sizeWidth(context).width,
              height: 50,
              decoration: containerDecoration(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(SaleVM.addSaleModel.dps != null ? SaleVM.addSaleModel.dps!.name ?? "Select" : "Select",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("teamLeader".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
          const SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              clearFocus(context);
              showPickerDialog1(distributor!.leader ?? [], "LEADER");
            },
            child: Container(
              width: sizeWidth(context).width,
              height: 50,
              decoration: containerDecoration(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(SaleVM.addSaleModel.leader != null ? SaleVM.addSaleModel.leader!.name ?? "Select" : "Select",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("dealer".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
          const SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              clearFocus(context);
              showPickerDialog1(distributor!.dealer ?? [], "DEALER");
            },
            child: Container(
              width: sizeWidth(context).width,
              height: 50,
              decoration: containerDecoration(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(SaleVM.addSaleModel.dealer != null ? SaleVM.addSaleModel.dealer!.name ?? "Select" : "Select",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("dealerAssistant".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),
          const SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              clearFocus(context);
              showPickerDialog1(distributor!.da ?? [], "DA");
            },
            child: Container(
              width: sizeWidth(context).width,
              height: 50,
              decoration: containerDecoration(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(SaleVM.addSaleModel.da != null ? SaleVM.addSaleModel.da!.name ?? "Select" : "Select",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ),
            ),
          ),
          const SizedBox(height: 8,),


          const SizedBox(height: 16,),

          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
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
                        widget.continueClick!();

                      },
                      style: elevatedButtonStyle(context),
                      child: Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    )
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
  showPickerDialog1(List<DistributorSubType> list, String type) {
    ViewUtil.showCustomDialog(
        context,
        MyDialog(
            list,
            type,
            context,
            reloadContext
        )
    );
  }
  reloadContext() {
    setState(() {
    });
  }


}
class MyDialog extends StatefulWidget {
  List<DistributorSubType> list = [];
  String type;
  BuildContext mcontext;
  VoidCallback? callBack;

  MyDialog(this.list, this.type, this.mcontext, this.callBack, {super.key});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController editingController = TextEditingController();

  List<DistributorSubType> tempList = [];
  List<DistributorSubType> liste = [];

  Sale? qualifySale;
  String? type;

  @override
  Widget build(BuildContext context) {
    qualifySale = SaleVM.addSaleModel;
    type = widget.type;
    liste = widget.list;

    var title = "None";
    if (liste.where((element) => element.name == title).isEmpty) {
      DistributorSubType subtype = DistributorSubType();
      subtype.id = 0;
      subtype.name = title;
      liste.add(subtype);
    }

    if (tempList.isEmpty) {
      tempList.addAll(liste);
    }

    return Container(
      color: ColorUtil().getColor(context, ColorEnums.background),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            height: 44,
            child:  WizzTextField(
              hint: "search",
              textEditingController: editingController,
              hintTextColor: ColorEnums.textDefaultLight,
              hintTextSize: 14,
              borderColor: ColorEnums.textDefaultLight,
              borderWidth: 1.0,
              textColor: ColorEnums.textDefaultLight,
              leadingIconColor: ColorEnums.textDefaultLight,
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
                      int? itemId;
                      if (item.id != null) {
                        itemId = item.id;
                      }
                      if (type == "SM") {
                        if (itemId != null) {
                          qualifySale!.sm = User(id: itemId, name: item.name);
                        } else {
                          qualifySale!.sm = User();
                        }
                      } else if (type == "DPS") {
                        if (itemId != null) {
                          qualifySale!.dps = User(id: itemId, name: item.name);
                        } else {
                          qualifySale!.dps = User();
                        }
                      } else if (type == "LEADER") {
                        if (itemId != null) {
                          qualifySale!.leader = User(id: itemId, name: item.name);
                        } else {
                          qualifySale!.leader = User();
                        }
                      } else if (type == "DEALER") {
                        if (itemId != null) {
                          qualifySale!.dealer = User(id: itemId, name: item.name);
                        } else {
                          qualifySale!.dealer = User();
                        }
                      } else if (type == "DA") {
                        if (itemId != null) {
                          qualifySale!.da = User(id: itemId, name: item.name);
                        } else {
                          qualifySale!.da = User();
                        }
                      }
                      widget.callBack!();
                      Navigator.pop(widget.mcontext);
                    },
                    child: ListTile(
                      title: Text(item.name ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    ));
              })

        ],
      ),
    );
  }
}
