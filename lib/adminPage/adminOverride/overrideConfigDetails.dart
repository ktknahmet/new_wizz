import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/allOverride.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/AddAppBar.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../constants/colorsUtil.dart';
import '../../utils/style/CustomTextStyle.dart';
import '../adminModel/overrideModel/deleteOverrideConfig.dart';

class AdminOverride extends StatefulWidget {
  const AdminOverride({super.key});

  @override
  State<StatefulWidget> createState() => _AdminOverrideState();
}

class _AdminOverrideState extends State<AdminOverride> {
  AdminOverrideVm viewModel = AdminOverrideVm();
  ScrollController controller = ScrollController();
  int total=0;
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
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: AddAppBar(
        name: "overrideConfig".tr(),
        func: ()  {
          Navigator.pushNamed(context, '/${PageName.addOverrideScreen}');
        },
      ),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
            value: viewModel,
            child: Consumer<AdminOverrideVm>(
              builder: (context,value,_){
                if(viewModel.allOverride == null){
                  return spinKit(context);
                }else {
                  return SingleChildScrollView(
                    child: Column(

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: sizeWidth(context).width*0.6,
                              height: 40,
                              child: TextField(
                                onChanged: (value){
                                  viewModel.setQuery(value);
                                  viewModel.searchOverride(viewModel.allOverride!,viewModel.query);
                                },
                                decoration: searchTextDesign(context, "search"),
                                cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ),
                          ),
                           Container(
                             width: sizeWidth(context).width*0.23,
                             decoration: containerDecoration(context),
                             child:  Padding(
                               padding: const EdgeInsets.only(bottom: 8,left: 4,right: 4),
                               child: Column(

                                   children: [
                                     Text("total".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                     const SizedBox(height: 4,),
                                     Text("\$${moneyFormat(total)}",style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                   ],
                                 ),
                             ),
                             ),

                        ],
                      ),
                      const SizedBox(height: 8,),
                      RefreshIndicator(
                        onRefresh: getList,
                        color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        child: RawScrollbar(
                          thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: SizedBox(
                            height: justList(context, sizeWidth(context).height),
                            child: ListView.builder(
                              controller: controller,
                              itemCount:  viewModel.searchOverride(viewModel.allOverride!,viewModel.query).length,
                              itemBuilder: (context,index){
                                AllOverride item =  viewModel.searchOverride(viewModel.allOverride!,viewModel.query)[index];
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
                                                   child: Text("overrideAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                               Expanded(
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.end,
                                                   children: [
                                                     Text("\$${item.overrideAmount ?? "0.0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                                   width:sizeWidth(context).width*0.3,
                                                   child: Text("distPurchases".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                               Expanded(
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.end,
                                                   children: [
                                                     Text(item.organisationName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                                   child: Text("type".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                               Expanded(
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.end,
                                                   children: [
                                                     Text(item.overrideType ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                                   child: Text("overrideRecipient".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
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
                                                   child: Text("product".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                               Expanded(
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.end,
                                                   children: [
                                                     Text(item.productName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                                 width: sizeWidth(context).width*0.4,
                                                 child: ElevatedButton(
                                                     onPressed: ()async{
                                                       await updateOverrideConfig(context,item.overrideConfigurationId!,viewModel,getList);
                                                     },
                                                     style: elevatedButtonStyle(context),
                                                     child: Text("edit".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: sizeWidth(context).width*0.4,
                                                 child: ElevatedButton(
                                                     onPressed: ()async{
                                                       bool check = await areYouSure(context);
                                                       if(check){
                                                         await delete(item.overrideConfigurationId!);
                                                       }
                                                     },
                                                     style: elevatedButtonStyle(context),
                                                     child: Text("delete".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                 ),
                                               )
                                             ],
                                           )
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
          )
        )
      ),
    );
  }
  Future<void>getList() async{
   total =0;
   await viewModel.getOverrideList(context);
   if(viewModel.allOverride!.isNotEmpty){
     for(int i=0;i<viewModel.allOverride!.length;i++){
       final value = (viewModel.allOverride![i].overrideAmount ?? "0.0").replaceAll(".", "");
       total = total+(int.parse(value));
     }

   }
  }
  delete(int id)async{
    DeleteOverrideConfig config = DeleteOverrideConfig(
        configId:id
    );
    await viewModel.deletedConfig(context, config,getList);
  }

}
