import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/postOverride.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/OLDLibrary.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../constants/AppColors.dart';

class AddOverride extends BaseStatefulPage {
  const AddOverride(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AddOverrideState();
}

class _AddOverrideState extends BaseStatefulPageState<AddOverride> {
  AdminOverrideVm viewModel = AdminOverrideVm();
  TextEditingController amount=TextEditingController();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AdminOverrideVm>(
        builder: (context,value,_){
          if(viewModel.overrideType == null || viewModel.organisations ==null || viewModel.overrideUserList == null){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child: Column(
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
                        hint: Text("selectOverrideType".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),

                        value: viewModel.selectedOverrideTypeId != null
                            ? viewModel.overrideType!
                            .firstWhere((type) => type.overrideTypeId == viewModel.selectedOverrideTypeId)
                            .overrideTypeName
                            : null,
                        onChanged: (newValue) async{
                          viewModel.setSelectedOverrideType(newValue!);

                        },
                        items: viewModel.overrideType!.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.overrideTypeName!,

                            child: Row(
                              children: [
                                Text(value.overrideTypeName!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("puchases".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                  ),
                  const SizedBox(height: 8,),
                  TextField(
                    style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    decoration: dateInputDecoration(context,"selectDist"),
                    controller: viewModel.distName,
                    readOnly: true,
                    onTap: () async{

                      if(viewModel.organisations!.isNotEmpty){
                        showOrgList(context,viewModel);
                      }else{
                        snackBarDesign(context, StringUtil.warning, "userListEmpty".tr());
                      }
                    },
                  ),
                  const SizedBox(height: 8,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("override".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                  ),
                  const SizedBox(height: 8,),
                  TextField(
                    style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    decoration: dateInputDecoration(context,"salesId"),
                    controller: viewModel.userName,
                    readOnly: true,
                    onTap: () {
                      if(viewModel.overrideUserList!.isNotEmpty){
                        showUserList(context,viewModel);
                      }else{
                        snackBarDesign(context, StringUtil.warning, "userListEmpty".tr());
                      }
                    },
                  ),
                  const SizedBox(height: 8,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("overrideAmount".tr(),style: CustomTextStyle().semiBold12(
                            ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                      ),
                    ),
                    const SizedBox(height: 4,),
                    TextField(
                      maxLines: null,
                      controller: amount,
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                      decoration: textFieldTextDesign(context,"overrideAmount"),
                      cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: [CurrencyTextInputFormatter(symbol: '\$')],
                    ),
                  ],
                ),

                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: sizeWidth(context).width*0.4,
                        child: ElevatedButton(
                          onPressed: ()async{

                            if(viewModel.selectedOverrideTypeId !=null && amount.text.isNotEmpty && viewModel.distId !=null){
                              amount.text = amount.text.replaceAll("\$", "");
                              OverrideTypes types = OverrideTypes(
                                distName: viewModel.distName.text,
                                overrideTypeName: viewModel.selectedOverrideTypeName,
                                userName: viewModel.userName.text,
                                overrideTypeId: viewModel.selectedOverrideTypeId,
                                overrideAmount: amount.text
                              );
                              viewModel.addOverrideTypes(types);
                            }else{
                              snackBarDesign(context, StringUtil.error, "allAreaMustRequired".tr());
                            }

                          },
                          style: elevatedButtonStyle(context),
                          child: Text("add".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        ),
                      ),
                      SizedBox(
                        width: sizeWidth(context).width*0.4,
                        child: ElevatedButton(
                          onPressed: ()async{
                            if(viewModel.overrideTypes.isNotEmpty){
                              await post();
                            }else{
                              snackBarDesign(context, StringUtil.error, "allAreaMustRequired".tr());
                            }
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        ),
                      ),
                    ],
                  ),
                  RawScrollbar(
                    thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    thumbVisibility: true,
                    thickness: 1,
                    trackVisibility: true,
                    controller: controller,
                    child: SizedBox(
                      height: sizeWidth(context).height*0.6,
                      child: ListView.builder(
                        itemCount: viewModel.overrideTypes.length,
                        controller: controller,
                        itemBuilder: (context,index){
                          OverrideTypes item = viewModel.overrideTypes[index];
                          return Dismissible(
                            background: Container(
                              color: ColorUtil().getColor(context, ColorEnums.error),
                              child: const Icon(Icons.delete,color: AppColors.white,),
                            ),
                            key: UniqueKey(),
                            onDismissed: (DismissDirection direction){
                              viewModel.deleteList(index);
                            },
                            child: Card(
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
                                            width:sizeWidth(context).width*0.6,
                                            child: Text("${index+1}- ${item.overrideTypeName ?? ""}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text("\$${item.overrideAmount ?? 0.0}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.4,
                                            child: Text("distributor".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.distName!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.4,
                                            child: Text("overrideReceiveBy".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.userName!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
    );
  }
  getList()async{
    await viewModel.getOverrideTypes(context);
    await viewModel.getOrganisations(context);
    await viewModel.getOverrideUser(context);
  }
  post()async{

    PostOverride override = PostOverride(
      organisationId: viewModel.distId,
      userId: viewModel.userId,
      productId: 1,
      overrideTypes: viewModel.overrideTypes
    );
    await viewModel.postOverride(context, override);
  }
}
