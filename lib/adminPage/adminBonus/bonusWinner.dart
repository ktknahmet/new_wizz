import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusWinnerList.dart';
import 'package:wizzsales/adminPage/adminVm/adminBonusVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class BonusWinner extends BaseStatefulPage {
  const BonusWinner(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _BonusWinnerState();
}

class _BonusWinnerState extends BaseStatefulPageState<BonusWinner> {
  AdminBonusVm viewModel = AdminBonusVm();
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
      child: Consumer<AdminBonusVm>(
        builder: (context,value,_){
          if(viewModel.bonusWinnerList == null){
            return spinKit(context);
          }else if(viewModel.bonusWinnerList!.isEmpty){
            return emptyView(context, "doNotHaveAnyBonusWinner");
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.7,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);
                              viewModel.searchWinner(viewModel.bonusWinnerList!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: ()async{
                          showProgress(context, true);
                          await getList();
                          showProgress(context, false);
                        },
                        icon: Icon(Icons.refresh,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                      )
                    ],
                  ),

                  const SizedBox(height: 8,),
                  RefreshIndicator(
                    onRefresh: getList,
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: SizedBox(
                      height: justList(context, sizeWidth(context).height),
                      child: RawScrollbar(
                        controller: controller,
                        thumbVisibility: true,
                        thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        thickness: 1,
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.searchWinner(viewModel.bonusWinnerList!,viewModel.query).length,
                          itemBuilder: (context,index){
                            BonusWinnerList item =  viewModel.searchWinner(viewModel.bonusWinnerList!,viewModel.query)[index];
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
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.40,
                                            child: Text("user".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.userName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.40,
                                            child: Text("amount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
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
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.40,
                                            child: Text("totalQuantity".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text("${item.totalQuantity ?? "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                            width:sizeWidth(context).width*0.40,
                                            child: Text("date".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(mmDDYDate(item.vestingDate),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),

                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
  Future<void>getList()async{
    await viewModel.getBonusWinner(context);
  }
}
