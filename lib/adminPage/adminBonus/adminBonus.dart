import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/bonusModel/bonusRuleList.dart';
import 'package:wizzsales/adminPage/adminVm/adminBonusVm.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/AddAppBar.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../constants/colorsUtil.dart';
// ignore_for_file: use_build_context_synchronously

class AdminBonus extends StatefulWidget {
  const AdminBonus({super.key});

  @override
  State<StatefulWidget> createState() => _AdminBonusState();
}

class _AdminBonusState extends State<AdminBonus> {
  AdminBonusVm viewModel = AdminBonusVm();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(name: "bonus".tr(),),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminBonusVm>(
            builder: (context,value,_){
              if(viewModel.bonusRoleList == null){
                return spinKit(context);
              }else if(viewModel.bonusRoleList!.isEmpty){
                return emptyView(context, "noWinnerListYet");
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
                                  viewModel.searchRoleList(viewModel.bonusRoleList!,viewModel.query);
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
                              itemCount: viewModel.searchRoleList(viewModel.bonusRoleList!,viewModel.query).length,
                              itemBuilder: (context,index){
                                BonusRuleList item =  viewModel.searchRoleList(viewModel.bonusRoleList!,viewModel.query)[index];
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
                                                child: Text("minQuantity".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("${item.minQuantity}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                                child: Text("beginDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(mmDDYDate(item.beginDate),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                                child: Text("expireDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(mmDDYDate(item.endDate),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                                child: Text("status".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.isActive ==true ? "Active" :"InActive",
                                                    style: item.isActive ==true ?
                                                    CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.wizzColor)) :
                                                    CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.error)),)
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
        ),
      ),
    );
  }
  Future<void> getList()async{
     await viewModel.getBonusRule(context);
  }

}
