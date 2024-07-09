import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comInactive.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionList.dart';
import 'package:wizzsales/adminPage/adminVm/commissionVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/AddAppBar.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class Commission extends StatefulWidget {
  const Commission({super.key});

  @override
  State<StatefulWidget> createState() => _CommissionState();
}

class _CommissionState extends State<Commission> {
  CommissionVm viewModel = CommissionVm();
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
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: AddAppBar(
        name: "commissionRate".tr(),
        func: ()  {
          Navigator.pushNamed(context, '/${PageName.adminAddCom}');
        },
      ),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<CommissionVm>(
          builder: (context,value,_){
            if(viewModel.commission == null){
              return spinKit(context);
            }else if(viewModel.commission!.isEmpty){

              return emptyView(context, "youDoNotHaveAnyRateList".tr());
            }else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         SizedBox(
                           width: sizeWidth(context).width*0.80,
                           height: 40,
                           child: TextField(
                             onChanged: (value){
                               viewModel.setQuery(value);
                               viewModel.searchRate(viewModel.commission!,viewModel.query);
                             },
                             decoration: searchTextDesign(context, "search"),
                             cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                             style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                           ),
                         ),
                         GestureDetector(
                           onTap:()async{
                             await showProgress(context, true);
                             await getList();
                             await showProgress(context, false);
                           },
                           child: Icon(Icons.refresh,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                         ),
                       ],
                     ),
                      const SizedBox(height: 8,),
                  
                      RawScrollbar(
                        thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                        thumbVisibility: true,
                        thickness: 1,
                        trackVisibility: true,
                        controller: controller,
                        child: RefreshIndicator(
                          onRefresh: getList,
                          color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          child: SizedBox(
                            height: justList(context, sizeWidth(context).height),
                            child: ListView.builder(
                              itemCount: viewModel.searchRate(viewModel.commission!,viewModel.query).length,
                              controller: controller,
                              itemBuilder: (context,index){
                                CommisionList model = viewModel.searchRate(viewModel.commission!,viewModel.query)[index];
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
                                              width: sizeWidth(context).width*0.30,
                                              child: Text("status".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ),
                                            Text(model.isActive == true ? "Active" : "InActive",
                                              style:model.isActive == true ?
                                              CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.wizzColor))
                                            :CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.error))),
                  
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             Text("comEffectiveDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  
                                            Text(mmDDYDate(model.calcBeginDate ?? ""),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("comEffectiveEndDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            Text(mmDDYDate(model.calcExpireDate ?? ""),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        if(model.roleViewName !=null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.30,
                                                child: Text("commissionType".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              //flat rate veya percentage bilgisi gelecek
                                              Text(model.roleViewName ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        const SizedBox(height: 4,),
                                        model.profileId ==null ?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeWidth(context).width*0.30,
                                              child: Text("role".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ),
                                            Text("${model.roleViewName ?? ""} ${context.tr("commission")}",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ],
                                        ):
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeWidth(context).width*0.30,
                                              child: Text("dealerName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ),
                                            Text(model.dealerName ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 0.5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            if(model.details!.isNotEmpty)
                                              SizedBox(
                                                width:sizeWidth(context).width*0.43,
                                                child: ElevatedButton(
                                                  onPressed: (){
                                                    if(model.isActive == true){
                                                      showComDetails(context,model.details!,model.calcPoolId!);
                                                    }else{
                                                      snackBarDesign(context, StringUtil.error, "inActiveError".tr());
                                                    }
                  
                                                  },
                                                  style: elevatedButtonStyle(context),
                                                  child: Text("commissionRateScale".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  
                                                ),
                                              ),
                                            SizedBox(
                                              width:sizeWidth(context).width*0.43,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(context, '/${PageName.commDetails}',arguments: {"id":model.calcPoolId});
                  
                                                },
                                                style: elevatedButtonStyle(context),
                                                child: Text("seeWinner".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                        model.isActive == true ?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width:sizeWidth(context).width*0.43,
                                              child: ElevatedButton(
                                                onPressed: () async{
                                                  bool checkStatus = await askChangeStatusCom(context);
                                                  if(checkStatus==true){
                                                    await updateStatus(model.calcPoolId!);
                                                  }
                                                },
                                                style: elevatedButtonStyle(context),
                                                child: Text("changeToDeactive".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                            ),
                                            SizedBox(
                                              width:sizeWidth(context).width*0.43,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  showUpdateExtendDate(context,viewModel,model.calcPoolId!);
                                                },
                                                style: elevatedButtonStyle(context),
                                                child: Text("extendDate".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                            ),
                                          ],
                                        ):SizedBox(
                                          width:sizeWidth(context).width*0.80,
                                          child: ElevatedButton(
                                            onPressed: () async{
                                              bool checkStatus = await askChangeStatusCom(context);
                                              if(checkStatus==true){
                                                await updateStatusActive(model.calcPoolId!);
                                              }
                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("changeToActive".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ),
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
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
  Future<void> getList()async{
    await viewModel.getCommissionList(context);
  }

  updateStatus(int id)async{
    ComInactive post = ComInactive(
      calcPoolId: id
    );
    await viewModel.updateInactive(context, post);
  }
  updateStatusActive(int id)async{
    ComInactive post = ComInactive(
        calcPoolId: id
    );
    await viewModel.updateActive(context, post);
  }
}
