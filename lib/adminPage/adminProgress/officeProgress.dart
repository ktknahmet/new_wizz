import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/MyProgressVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class OfficeProgress extends BaseStatefulPage {
  const OfficeProgress(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _OfficeProgressState();
}


class _OfficeProgressState extends BaseStatefulPageState<OfficeProgress> {
  MyProgressVm viewModel = MyProgressVm();
  LoginUser? loginUser;

  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<MyProgressVm>(
        builder: (context,value,_){
          if(viewModel.detailsReportModel == null){
            return spinKit(context);
          }else{
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: sizeWidth(context).width*0.30,
                    height: 40,
                    decoration: decorationTransparent(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: emptyDecoration(context),
                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                        cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        controller: viewModel.daySelect,
                        readOnly: true,
                        onTap: (){
                          selectProgressReport(context,viewModel);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height:4,),
                Divider(
                  thickness: 0.5,
                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                ),

                const SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "saleTotal".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                viewModel.sales.toString(),
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "totalLeads".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                viewModel.totalLeads.toString(),
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height:8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${context.tr("closingRatio")} %",
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                getDecimalPlaces(viewModel.closingRatio ?? 0.0, 2),
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "totalDemos".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                viewModel.totalDemos.toString(),
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "averageSalesPrice".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                "\$${viewModel.averageSalesPrice ?? "0"}",
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "totalRevenue".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                "\$${moneyFormat(viewModel.totalRevenue ?? "0.0")}",
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height:4,),
                Divider(
                  thickness: 0.5,
                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                ),
                const SizedBox(height:4,),
                const SizedBox(height:8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "paidCom".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                "\$${moneyFormat(viewModel.paidCom)}",
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "unPaidCom".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                "\$${moneyFormat(viewModel.unPaidCom)}",
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "goals".tr(),
                  style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                ),
                const SizedBox(height:4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "totalSale".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                "${viewModel.sales.toString()}/${viewModel.estimatedSales}",
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "leads".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                "${viewModel.leadActual}/${viewModel.leadGoals}",
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height:8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: sizeWidth(context).width * 0.40,
                      child: Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "appointment".tr(),
                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                "${viewModel.appointmentActual ?? 0}/${viewModel.appointmentGoals}",
                                style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
  Future<void>getList() async{

    SharedPref pref = SharedPref();
    int index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    await viewModel.detailReport(context, loginUser!.profiles![index].id!, loginUser!.profiles![index].organisation_id!);

  }
}
