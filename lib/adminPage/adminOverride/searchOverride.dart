import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideWinner.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../constants/colorsUtil.dart';
import '../../utils/style/CustomTextStyle.dart';

class SearchOverride extends BaseStatefulPage {
  const SearchOverride(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _SearchOverrideState();
}

class _SearchOverrideState extends BaseStatefulPageState<SearchOverride> {
  AdminOverrideVm viewModel = AdminOverrideVm();
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
          if(viewModel.overrideWinner == null){
            return spinKit(context);
          }else if(viewModel.overrideWinner!.isEmpty){
            return emptyView(context, "youDoNotHaveAnyWinnerYet");
          }else{
            return Column(
              children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       SizedBox(
                         width: sizeWidth(context).width*0.4,
                         child: TextField(
                           style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                           cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                           decoration: dateInputDecoration(context,"selectUser"),
                           controller: viewModel.overrideUser,
                           readOnly: true,
                           onTap: () async{
                             selectOverrideNameBase(context,viewModel);
                           },
                         ),
                       ),
                       Container(
                         decoration: containerDecoration(context),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("total".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                               const SizedBox(height: 4,),
                               Text("${viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                             ],
                           ),
                         ),
                       ),
                       Container(
                         decoration: containerDecoration(context),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("totalAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                               const SizedBox(height: 4,),
                               Text("\$${moneyFormat(viewModel.totalOverrideDetails)}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                             ],
                           ),
                         ),
                       )
                     ],
                   ),
                   const SizedBox(height: 8,),
                   RawScrollbar(
                     controller: controller,
                     thumbVisibility: true,
                     thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                     thickness: 1,
                     child: RefreshIndicator(
                       onRefresh: getList,
                       color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                       child: SizedBox(
                         width: sizeWidth(context).width,
                         height: justList(context, sizeWidth(context).height),
                         child: ListView.builder(
                           controller: controller,
                           itemCount: viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length,
                           itemBuilder: (context,index){
                             int startIndex = (viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length == 1) ? 1 : viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length;
                             List<int> indices = List.generate(viewModel.overrideWinner!.length, (index) => startIndex - index);
                             AdminOverrideWinner model = viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query)[index];
                             return Card(
                               shape: cardShape(context),
                               color: ColorUtil().getColor(context, ColorEnums.background),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Column(
                                   children: [
                                     Text(indices[index].toString(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SizedBox(
                                           width: sizeWidth(context).width*0.5,
                                           child: Text("overrideReceiveBy".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                         ),
                                         Text(model.userName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                       ],
                                     ),


                                     const SizedBox(height: 4,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SizedBox(
                                           width: sizeWidth(context).width*0.3,
                                           child: Text("overrideType".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                         ),
                                         Text(model.overrideType ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                       ],
                                     ),
                                     const SizedBox(height: 4,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SizedBox(
                                           width: sizeWidth(context).width*0.3,
                                           child: Text("product".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                         ),
                                         Text(model.productName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                       ],
                                     ),
                                     const SizedBox(height: 4,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SizedBox(
                                           width: sizeWidth(context).width*0.3,
                                           child: Text("enterSerialNumber".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                         ),
                                         Text(model.serialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                       ],
                                     ),
                                     const SizedBox(height: 4,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SizedBox(
                                           width: sizeWidth(context).width*0.3,
                                           child: Text("overrideAmount".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                         ),
                                         Text("\$${model.overrideAmount ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                       ],
                                     ),
                                     const SizedBox(height: 4,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SizedBox(
                                           width: sizeWidth(context).width*0.3,
                                           child: Text("puchases".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                         ),
                                         Text(model.organisationName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                       ],
                                     ),
                                     const SizedBox(height: 4,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SizedBox(
                                           width: sizeWidth(context).width*0.3,
                                           child: Text("overrideCalDate".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                         ),
                                         Text(mmDDYDate(model.calculatedDate),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                       ],
                                     ),
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
            );
          }
        },
      ),
    );
  }

  Future<void> getList()async{
    await viewModel.getOverrideWinner(context,null,null,null);
    viewModel.search.clear();
    viewModel.search.add("All");
    for(int i=0;i<viewModel.overrideWinner!.length;i++){
      if(viewModel.search.contains(viewModel.overrideWinner![i].userName) == false){
        viewModel.search.add(viewModel.overrideWinner![i].userName!);
      }
    }
    for(int i=0;i<viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length;i++){
      AdminOverrideWinner model = viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query)[i];
      viewModel.totalOverrideDetails +=double.parse(model.overrideAmount ?? "0.0");
    }
  }
}
