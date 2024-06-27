import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminVm/stockVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/stockCheckIn/returnStock.dart';
import 'package:wizzsales/model/stockModel/assignDealerList.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously
class DealerStockList extends BaseStatefulPage {
  const DealerStockList(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _DealerStockListState();
}

class _DealerStockListState extends BaseStatefulPageState<DealerStockList>{
  StockVm viewModel = StockVm();
  ScrollController controller = ScrollController();
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
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<StockVm>(
        builder: (context,value,_){
          if(viewModel.assignList==null){
            return spinKit(context);
          }else if(viewModel.assignList!.isNotEmpty){
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

                            viewModel.searchAssign(viewModel.assignList!,viewModel.query);
                          },
                          decoration: searchTextDesign(context, "search"),
                          cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        ),
                      ),
                    ),
                  RawScrollbar(
                    thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    thumbVisibility: true,
                    thickness: 1,
                    trackVisibility: true,
                    controller: controller,
                    child: SizedBox(
                      height: justList(context, sizeWidth(context).height),
                      child: ListView.builder(
                        controller: controller,
                        itemCount: viewModel.searchAssign(viewModel.assignList!,viewModel.query).length,
                        itemBuilder: (context,index){
                          AssignDealerList model = viewModel.searchAssign(viewModel.assignList!,viewModel.query)[index];
                          int startIndex = (viewModel.assignList!.length == 1) ? 1 : (viewModel.assignList!.length);
                          List<int> indices = List.generate(viewModel.assignList!.length, (index) => startIndex - index);

                          return Card(
                            shape: cardShape(context),
                            color: ColorUtil().getColor(context,ColorEnums.background),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("${indices[index]}",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.wizzColor)))),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: sizeWidth(context).width*0.30,
                                        child: Text("enterSerialNumber".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ),
                                      Text(model.serialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  const Divider(
                                    thickness: 0.5,
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: sizeWidth(context).width*0.30,
                                        child: Text("assignDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ),
                                      Text(mmDDYDateTime(model.stockDate ?? ""),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: sizeWidth(context).width*0.30,
                                        child: Text("duration".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ),
                                      Text(calculateDay(model.stockDate!),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }else{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("emptyInventory".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
              ],
            );
          }
        },
      ),
    );
  }
  Future<void> getList()async{
   await viewModel.getAssign(context);
}

}
