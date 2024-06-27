import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminBonus/bonusModel.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusOverlapping.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusRule.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/postBonus.dart';
import 'package:wizzsales/adminPage/adminVm/adminBonusVm.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/CheckBackBar.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../constants/colorsUtil.dart';
// ignore_for_file: use_build_context_synchronously

class AdminAddBonus extends StatefulWidget {
  const AdminAddBonus( {super.key});

  @override
  State<StatefulWidget> createState() => _AdminAddBonusState();
}

class _AdminAddBonusState extends State<AdminAddBonus> {
  ScrollController controller = ScrollController();
  AdminBonusVm viewModel = AdminBonusVm();
  TextEditingController minQuantity = TextEditingController();
  TextEditingController totalBonus = TextEditingController();
  TextEditingController chooseType = TextEditingController();
  TextEditingController startDate=TextEditingController();
  TextEditingController endDate=TextEditingController();
  List<BonusRule> ruleList=[];
  LoginUser? loginUser;
  int index=0;
  String? bonusDateType;
  String? type;

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
      appBar: CheckBackBar(
        name: "addBonus".tr(),
        check: viewModel.checkSave,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: SizedBox(
          width: sizeWidth(context).width,
          height: sizeWidth(context).height,
          child: ChangeNotifierProvider.value(
            value: viewModel,
            child: Consumer<AdminBonusVm>(
              builder: (context,value,_){
                if(viewModel.bonusTypes == null || viewModel.allRoles == null){
                  return spinKit(context);
                }else{
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child:TextField(
                                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                  cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                  decoration: dateInputDecoration(context,"beginDate"),
                                  controller: startDate,
                                  readOnly: true,
                                  onTap: () async{
                                    startDate.text = await DatePickerHelper.getDatePicker(context);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextField(
                                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                      cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                      decoration: dateInputDecoration(context,"expireDate"),
                                      controller: endDate,
                                      readOnly: true,
                                      onTap: () async{
                                        endDate.text = await DatePickerHelper.getDatePicker(context);
                                      },
                                    ),
                                  ],

                                ),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(height: 16,),
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  decoration: containerDecoration(context),
                                  width: sizeWidth(context).width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                      underline: const SizedBox(),
                                      hint: Text("selectBonusType".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),

                                      value: viewModel.selectedBonus,
                                      onChanged: (newValue) async{
                                        viewModel.setBonusType(newValue!);

                                      },
                                      items: viewModel.bonusTypes!.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value.bonusType,

                                          child: Row(
                                            children: [
                                              Text(value.bonusType!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: containerDecoration(context),
                                      width: sizeWidth(context).width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                          underline: const SizedBox(),
                                          hint: Text("selectRole".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),

                                          value: viewModel.role,
                                          onChanged: (newValue) {
                                            viewModel.setRole(newValue!);
                                          },
                                          items: viewModel.allRoles!.map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value.viewName,

                                              child: Row(
                                                children: [
                                                  Text(value.viewName!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                        const SizedBox(height: 16,),
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child:  accountNumber(context, "minQuantity", minQuantity),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    accountNumber(context,"bonusAmount",totalBonus),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child:  ElevatedButton(
                                onPressed: () async{
                                  await checkOverlap();
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("add".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              ),
                            ),
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child:  ElevatedButton(
                                onPressed: ()async{
                                  await save();
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("save".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        RawScrollbar(
                          controller: controller,
                          thumbVisibility: true,
                          thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          thickness: 1,
                          child: SizedBox(
                            height: justList(context, sizeWidth(context).height),
                            child: ListView.builder(
                              itemCount: viewModel.list.length,
                              controller:  controller,
                              itemBuilder: (context,index){
                                BonusModel item = viewModel.list[index];
                                return Card(
                                  shape: cardShape(context),
                                  color: ColorUtil().getColor(context, ColorEnums.background),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("role".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.roleName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("bonusType".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.bonusType ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("minQuantity".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("${item.minQuantity ?? "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("bonusAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("${item.bonusAmount ?? "0.0"}\$",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("beginDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.startDate!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("expireDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.endDate!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
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
                  );
                }
              },
            ),
          ),
        ),
      ),

    );
  }
  getList()async{
    await viewModel.getRoleList(context);
    await viewModel.getBonusTypes(context);
    SharedPref pref = SharedPref();
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);

  }
  checkOverlap()async{
    dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    dynamic y = formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    if(startDate.text.isNotEmpty && endDate.text.isNotEmpty && viewModel.selectedBonus !=null
        && viewModel.role !=null && minQuantity.text.isNotEmpty && totalBonus.text.isNotEmpty){

      DateTime selectedStartDate = DateTime.parse(x);
      DateTime selectedEndDate = DateTime.parse(y);

      if(selectedEndDate.isBefore(selectedStartDate)){
        snackBarDesign(context, StringUtil.error, "cannotGreaterEndDate".tr());
      }else{
        BonusOverlapping post = BonusOverlapping(
            distributorId: loginUser!.profiles![index].organisation_id,
            roleId: viewModel.roleId,
            beginDate: x,
            endDate: y,
            bonusType: viewModel.selectedBonus
        );
        await viewModel.postOverlapping(context,post,addListMethod);

      }

    }else{
      snackBarDesign(context, StringUtil.error, "allAreaMustRequired".tr());
    }
  }
  addListMethod(){
    BonusModel bonusModel = BonusModel(
        viewModel.role,
        viewModel.roleId,
        startDate.text,
        endDate.text,
        viewModel.selectedBonus,
        minQuantity.text,
        totalBonus.text);
    viewModel.addList(bonusModel);
    clearFocus(context);
    viewModel.setCheckSave(false);

  }
  save()async{

    if(viewModel.list.isNotEmpty){

      for(int i=0;i<viewModel.list.length;i++){
        BonusRule model = BonusRule(
          roleId: viewModel.list[i].roleId,
          beginDate: viewModel.list[i].startDate,
          endDate: viewModel.list[i].endDate,
          bonusType: viewModel.list[i].bonusType,
          minQuantity: viewModel.list[i].minQuantity,
          bonusAmount: viewModel.list[i].bonusAmount,
        );
        ruleList.add(model);
      }
      PostBonus postBonus = PostBonus(
          distributorId: loginUser!.profiles![index].organisation_id,
          bonusRules: ruleList
      );
      await viewModel.postBonus(context, postBonus,clearScreen);
    }else{
      snackBarDesign(context, StringUtil.error, "youMustAddBonus".tr());
    }
  }
  clearScreen(){
    viewModel.clearValues();
    minQuantity.clear();
    totalBonus.clear();
    startDate.clear();
    endDate.clear();
    viewModel.setCheckSave(true);

  }
}

