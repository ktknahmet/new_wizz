import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/productCoastList.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class ProductCost extends BaseStatefulPage {
  const ProductCost(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _ProductCostState();
}

class _ProductCostState extends BaseStatefulPageState<ProductCost> {
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
          if(viewModel.productCoast == null){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: sizeWidth(context).width,
                    height: 40,
                    child: TextField(
                      onChanged: (value){
                        viewModel.setQuery(value);
                        viewModel.searchProductCoast(viewModel.productCoast!,viewModel.query);
                      },
                      decoration: searchTextDesign(context, "search"),
                      cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  RefreshIndicator(
                    onRefresh: getList,
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: RawScrollbar(
                      controller: controller,
                      thumbVisibility: true,
                      thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      thickness: 1,
                      child: SizedBox(
                        height: justList(context, sizeWidth(context).height),
                        child: ListView.builder(
                          itemCount: viewModel.searchProductCoast(viewModel.productCoast!,viewModel.query).length,
                          controller: controller,
                          itemBuilder: (context,index){
                            ProductCoastList model = viewModel.searchProductCoast(viewModel.productCoast!,viewModel.query)[index];
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
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("amount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text("\$${model.costAmount ?? "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("product".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.productName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("distributor".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.distName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("date".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(mmDDYDate(model.createdAt),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    SizedBox(
                                      width: sizeWidth(context).width*0.8,
                                      height: 30,
                                      child: ElevatedButton(
                                          onPressed: (){
                                            updateProductCoast(context,viewModel,model.costId!);
                                          },
                                          style: elevatedButtonStyle(context),
                                          child: Text("update".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                    ),
              
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                   const SizedBox(height: 8,),
                   SizedBox(
                          width: sizeWidth(context).width*0.8,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/${PageName.addProductCoast}');
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("add".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                        ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  Future <void>getList()async{
   await viewModel.getProductCoast(context);
  }
}
