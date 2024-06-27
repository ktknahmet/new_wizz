import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminVm/adminBonusVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/bonusWinnerModel/bonusWinnerDealer.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class BonusWinnerList extends BaseStatefulPage {
  const BonusWinnerList(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _BonusWinnerListState();
}

class _BonusWinnerListState extends BaseStatefulPageState<BonusWinnerList> {
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
          if(viewModel.bonusWinnerDealerList == null){
            return spinKit(context);
          }else if(viewModel.bonusWinnerDealerList!.isEmpty){
            return emptyView(context, "doNotHaveAnyBonusWinner");
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        onChanged: (value){
                          viewModel.setQuery(value);
                          viewModel.searchBonusWinnerDealer(viewModel.bonusWinnerDealerList!,viewModel.query);
                        },
                        decoration: searchTextDesign(context, "search"),
                        cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  RefreshIndicator(
                    onRefresh: getList,
                    color: ColorUtil().getColor(context, ColorEnums.background),
                    child: SizedBox(
                      height: justList(context, sizeWidth(context).height),
                      child: RawScrollbar(
                        controller: controller,
                        thumbVisibility: true,
                        thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        thickness: 1,
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.searchBonusWinnerDealer(viewModel.bonusWinnerDealerList!,viewModel.query).length,
                          itemBuilder: (context,index){
                            BonusWinnerDealerList item =  viewModel.searchBonusWinnerDealer(viewModel.bonusWinnerDealerList!,viewModel.query)[index];
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
                                              Text("${item.totalQuantity}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                              Text(mmDDYDateTime(item.vestingDate),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  Future<void>getList()async{
   await viewModel.getBonusWinnerDealer(context);
  }
}
