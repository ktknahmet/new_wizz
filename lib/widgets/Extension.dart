// ignore_for_file: use_build_context_synchronously
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wizzsales/adminPage/adminModel/adminContestModel/Qualifications.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/appointmentBoard.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/saleBoard.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comExist.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comRateExtendDate.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/comSaleDetails/ComSaleDetails.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionList.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/payPost.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/postAdjust.dart';
import 'package:wizzsales/adminPage/adminModel/customerEventModel/RewardEvent.dart';
import 'package:wizzsales/adminPage/adminModel/customerEventModel/RewardEventActivityDetailDocuments.dart';
import 'package:wizzsales/adminPage/adminModel/inventoryModel/allAssignStock.dart';
import 'package:wizzsales/adminPage/adminModel/inventoryModel/postDistInventoryWarehouse.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/orgDetails.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserList.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserPost.dart';
import 'package:wizzsales/adminPage/adminModel/productCoastModel/updateProductCoast.dart';
import 'package:wizzsales/adminPage/adminModel/referralListModel/Customer.dart';
import 'package:wizzsales/adminPage/adminModel/referralListModel/Data.dart';
import 'package:wizzsales/adminPage/adminModel/rewardOrderModel/orderLine.dart';
import 'package:wizzsales/adminPage/adminModel/roles/allRoles.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/organisations/allOrganisations.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/postStockDealer/postStockDealer.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/stockDealer/stockDealer.dart';
import 'package:wizzsales/adminPage/adminModel/warehouse/warehouseList.dart';
import 'package:wizzsales/adminPage/adminVm/adminBoardVm.dart';
import 'package:wizzsales/adminPage/adminVm/adminBonusVm.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/adminPage/adminVm/adminVm.dart';
import 'package:wizzsales/adminPage/adminVm/commissionVm.dart';
import 'package:wizzsales/adminPage/adminVm/stockVm.dart';
import 'package:wizzsales/adminPage/adminVm/warehouseVm.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Draw.dart';
import 'package:wizzsales/model/allUsers/allUser.dart';
import 'package:wizzsales/model/contactModel/contactModel.dart';
import 'package:wizzsales/model/contractModel/contractType.dart';
import 'package:wizzsales/model/detailsReportModel/DetailReportModel.dart';
import 'package:wizzsales/model/expenseModel/expenseSale.dart';
import 'package:wizzsales/model/leadModel/leadStatusList.dart';
import 'package:wizzsales/model/leadModel/leadStatusPost.dart';
import 'package:wizzsales/model/leadReportModel/leadReportWithGoals.dart';
import 'package:wizzsales/model/stockModel/assignDealerList.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/function/helper/DocumentHelper.dart';
import 'package:wizzsales/utils/function/providerFunc/CheckPermissionProvider.dart';
import 'package:wizzsales/utils/function/providerFunc/ContactProvider.dart';
import 'package:wizzsales/utils/notification/NotificationUtils.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/pdfPage/pdfPage.dart';
import 'package:wizzsales/view/pdfPage/pdfPageFile.dart';
import 'package:wizzsales/view/videoPage/videoPage.dart';
import 'package:wizzsales/viewModel/ContractVm.dart';
import 'package:wizzsales/viewModel/ExpenseVm.dart';
import 'package:wizzsales/viewModel/HomeVm.dart';
import 'package:wizzsales/viewModel/LiveDemoVm.dart';
import 'package:wizzsales/viewModel/MyAppointmentVm.dart';
import 'package:wizzsales/viewModel/MyLeadVm.dart';
import 'package:wizzsales/viewModel/MyProgressVm.dart';
import 'package:wizzsales/viewModel/MySaleVm.dart';
import 'package:wizzsales/viewModel/OfficeSaleVm.dart';
import 'package:wizzsales/viewModel/RegisterVm.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row,Border;
import 'package:wizzsales/viewModel/SalesVm.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../adminPage/adminModel/overrideModel/overrideWinner.dart';
import '../adminPage/adminModel/overrideModel/updateOverrideConfig.dart';
import '../adminPage/adminModel/stockReportModel/stockReportData.dart';
import 'dart:ui' as ui;
import 'Constant.dart';
import 'OLDLibrary.dart';


  Future<void> postSms(BuildContext context,String message, List<String> recipents) async {

  }
  Future<void> postSmsFromAll(BuildContext context,List<String> name, List<String> recipents) async {
    List<String> newRecipents =[];
    for(int i =0;i<recipents.length;i++){
      newRecipents.add(recipents[i]);
      await sendSMS(message: "Hi ${name[i]} I just purchased this amazing product called HYLA! They are allowing me to give a HYLA Aera to a friend. I choose you! Please select a date to receive your water air freshener, and thank me later!", recipients:newRecipents,sendDirect: true);
      newRecipents.clear();
    }
  }


  void sendSms(BuildContext context,List<String> name,List<String> recipents) {
    Future.delayed(const Duration(seconds: 0)).then((_) => {
      showModalBottomSheet(

          backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
          context: context,
          useRootNavigator: true,
          shape: bottomSheetShape(context),
          builder: (context) {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const SizedBox(height: 8,),
                    const Text("Hi friends I just purchased this amazing product called HYLA! They are allowing me to give a HYLA Aera to a friend. I choose you! Please select a date to receive your water air freshener, and thank me later!",),

                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(32), // <-- Radius
                              ),
                            ),
                            onPressed: () async{
                              Navigator.pop(context);
                              await postSmsFromAll(context,name, recipents);
                            },
                            child: const Text(
                              "Send a message to all friends",
                             style: TextStyle(color: Colors.white,),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          ),
    });
  }





deleteToken(BuildContext context)async{
  SharedPref pref = SharedPref();
  await pref.deletePref(context, SharedUtils.userToken);
  await pref.deletePref(context, SharedUtils.salesRoleId);
  await pref.deletePref(context, SharedUtils.activeProfile);
  await pref.deletePref(context, SharedUtils.profileIndex);
  await pref.deletePref(context, SharedUtils.profileId);
  await pref.deletePref(context, SharedUtils.orgId);
  await pref.deletePref(context, SharedUtils.userModel);
  await pref.deletePref(context, SharedUtils.user);
  await pref.deletePref(context, SharedUtils.admin);
  await pref.deletePref(context, "payPeriod");
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/${PageName.logout}',
        (Route<dynamic> route) => false,
  );
}
showPhoto(BuildContext context,String photo){
  showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      backgroundColor:Colors.transparent,
      context: context,

      useRootNavigator: true,
      builder: (context) {
        return SizedBox(
          width: sizeWidth(context).width,
          height: sizeWidth(context).height*0.60,
          child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading.gif',
                image: photo,
                fit: BoxFit.contain),
        );
      });

}
showContestPhoto(BuildContext context,String photo){
  showModalBottomSheet(
     isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,

      useRootNavigator: true,
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height*0.90,
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.gif',
                  image: photo,
                  fit: BoxFit.fill),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: sizeWidth(context).width*0.80,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: elevatedButtonStyle(context),
                      child: Text("back".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      });

}

selectMySaleType(BuildContext context){
  showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      useRootNavigator: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: sizeWidth(context).height*0.20,
            child: Column(

              children: [
                Text("chooseSales".tr(),style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                 Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/${PageName.mySaleTabBar}',arguments: {'index':1});
                          },
                          style: elevatedButtonStyle(context),
                          child:Text("approved".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                        ),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/${PageName.mySaleTabBar}',arguments: {'index':2});
                          },
                          style: elevatedButtonStyle(context),
                          child:Text("pending".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                        )
                      ],
                    ),

                 )
              ],
            ),
          ),
        );
      });

}
selectOfficeSaleType(BuildContext context){
  showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      useRootNavigator: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("chooseSales".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/${PageName.officeSaleTabBar}',arguments: {'index':1});
                    },
                    style: elevatedButtonStyle(context),
                    child:Text("approved".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/${PageName.officeSaleTabBar}',arguments: {'index':2});
                    },
                    style: elevatedButtonStyle(context),
                    child:Text("pending".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                  )
                ],
              )
            ],
          ),
        );
      });

}

Future<bool?>showQuestions(BuildContext context)async{
  bool? check;
  await showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      useRootNavigator: true,
      builder: (context) {
        return SizedBox(
            width: sizeWidth(context).width,
            height: sizeWidth(context).height*0.15,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("didSaleDemo".tr(),style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  const SizedBox(height: 8,),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                //satış yapıldı
                                check=true;
                                Navigator.pop(context);


                              },
                              style: elevatedButtonStyle(context),
                              child: Text("yes".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),

                            ElevatedButton(
                              onPressed: (){
                                check=false;
                                Navigator.pop(context);
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("no".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      });
  return check;

}
Future<bool>showReturnToDist(BuildContext context)async{
  bool check = false;
  await showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      useRootNavigator: true,
      builder: (context) {
        return SizedBox(
          width: sizeWidth(context).width,
          height: sizeWidth(context).height*0.15,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text("returnDist".tr(),style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                 const SizedBox(height: 8,),
                 Expanded(
                   child: Align(
                     alignment: Alignment.bottomCenter,
                     child: Padding(
                       padding: const EdgeInsets.all(8),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           ElevatedButton(
                             onPressed: (){
                               //satış yapıldı
                               check=true;
                               Navigator.pop(context);


                             },
                             style: elevatedButtonStyle(context),
                             child: Text("yes".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                           ),

                            ElevatedButton(
                              onPressed: (){
                                check=false;
                                Navigator.pop(context);
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("no".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),

                         ],
                       ),
                     ),
                   ),
                 )
              ],
            ),
          )
        );
      });
  return check;

}

showGraphDetails(BuildContext context,int index, List<LeadReportWithGoals> report){
  showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      useRootNavigator: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8,),
            Text(getReportText(index).tr(),style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: ColorUtil().getColor(context, ColorEnums.background),
                shape: cardShape(context),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'actual'.tr(),
                                  style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight))
                                ),
                                Text('${context.tr("myDemos")}: ${report[0].value}',style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                Text('${context.tr("leadsReport")}: ${report[1].value}',style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'estimated'.tr(),
                                    style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight))
                                ),
                                Text('${context.tr("myDemos")}: ${report[0].estimated}',style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                Text('${context.tr("leadsReport")}: ${report[1].estimated}',style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                              ],
                            ),
                          ],
                        ),
                ),



              ),
            ),
          ],
        );
      });

}
showSaleDetails(BuildContext context,String photo,String name){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
          content: SizedBox(
            width: sizeWidth(context).width,
            height: sizeWidth(context).height*0.40,
            child: Column(
              children: [
                photo.isNotEmpty ? Expanded(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/loading.gif',
                    image: photo,
                    fit: BoxFit.cover),
                ) :
                Image.asset(
                  "assets/uploadPhoto.webp",
                  fit: BoxFit.contain,
                  height: 64,
                ),
                const SizedBox(height: 8,),
                Text(name.isNotEmpty ? name :"",style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
              ],
            ),
          ),
        );
      }
  );
}
selectAreaDemoBoard(BuildContext context,AdminBoardVm viewModel){
  ScrollController controller = ScrollController();
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            elevation: 0,
            backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
            content:SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height*0.80,
              child: Column(
                children: [
                  ChangeNotifierProvider.value(
                    value: viewModel,
                    child: Consumer<AdminBoardVm>(
                      builder: (context,value,_){
                        return RawScrollbar(
                          thumbColor: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: SizedBox(
                            height: sizeWidth(context).height*0.7,
                            child: ListView.builder(
                              itemCount: viewModel.gridMap.length,
                              itemBuilder: (context, index) {
                                var map = viewModel.gridMap[index];
                                var key = map.keys.first;
                                var value = map[key]!;
                                return ListTile(
                                  title: Text(key),
                                  trailing: Checkbox(
                                    value: value,
                                    activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    onChanged: (bool? newValue) {
                                      viewModel.setGridMap(key, newValue!);
                                    },
                                  ),
                                );

                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      }
  );
}
selectAreaReports(BuildContext context,AdminVm viewModel){
  ScrollController controller = ScrollController();
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            elevation: 0,
            backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
            content:SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height*0.80,
              child: Column(
                children: [
                  ChangeNotifierProvider.value(
                    value: viewModel,
                    child: Consumer<AdminVm>(
                      builder: (context,value,_){
                        return RawScrollbar(
                          thumbColor: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: SizedBox(
                            height: sizeWidth(context).height*0.7,
                            child: ListView.builder(
                              itemCount: viewModel.gridMap.length,
                              itemBuilder: (context, index) {
                                var map = viewModel.gridMap[index];
                                var key = map.keys.first;
                                var value = map[key]!;
                                return ListTile(
                                  title: Text(key),
                                  trailing: Checkbox(
                                    value: value,
                                    activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    onChanged: (bool? newValue) {
                                      viewModel.setGridMap(key, newValue!);
                                    },
                                  ),
                                );

                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      }
  );
}

selectAreaReportsOverride(BuildContext context,AdminOverrideVm viewModel){
  ScrollController controller = ScrollController();
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            elevation: 0,
            backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
            content:SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height*0.80,
              child: Column(
                children: [
                  ChangeNotifierProvider.value(
                    value: viewModel,
                    child: Consumer<AdminOverrideVm>(
                      builder: (context,value,_){
                        return RawScrollbar(
                          thumbColor: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: SizedBox(
                            height: sizeWidth(context).height*0.7,
                            child: ListView.builder(
                              itemCount: viewModel.gridMap.length,
                              itemBuilder: (context, index) {
                                var map = viewModel.gridMap[index];
                                var key = map.keys.first;
                                var value = map[key]!;
                                return ListTile(
                                  title: Text(key),
                                  trailing: Checkbox(
                                    value: value,
                                    activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    onChanged: (bool? newValue) {
                                      viewModel.setGridMap(key, newValue!);
                                    },
                                  ),
                                );

                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      }
  );
}
selectAreaCommission(BuildContext context,CommissionVm viewModel){
  ScrollController controller = ScrollController();
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            elevation: 0,
            backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
            content:SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height*0.80,
              child: Column(
                children: [
                  ChangeNotifierProvider.value(
                    value: viewModel,
                    child: Consumer<CommissionVm>(
                      builder: (context,value,_){
                        return RawScrollbar(
                          thumbColor: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: SizedBox(
                            height: sizeWidth(context).height*0.7,
                            child: ListView.builder(
                              itemCount: viewModel.gridMap.length,
                              itemBuilder: (context, index) {
                                var map = viewModel.gridMap[index];
                                var key = map.keys.first;
                                var value = map[key]!;
                                return ListTile(
                                  title: Text(key),
                                  trailing: Checkbox(
                                    value: value,
                                    activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    onChanged: (bool? newValue) {
                                      viewModel.setGridMap(key, newValue!);
                                    },
                                  ),
                                );

                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      }
  );
}
selectAreaBonus(BuildContext context,AdminBonusVm viewModel){
  ScrollController controller = ScrollController();
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            elevation: 0,
            backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
            content:SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height*0.80,
              child: Column(
                children: [
                  ChangeNotifierProvider.value(
                    value: viewModel,
                    child: Consumer<AdminBonusVm>(
                      builder: (context,value,_){
                        return RawScrollbar(
                          thumbColor: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: SizedBox(
                            height: sizeWidth(context).height*0.7,
                            child: ListView.builder(
                              itemCount: viewModel.gridMap.length,
                              itemBuilder: (context, index) {
                                var map = viewModel.gridMap[index];
                                var key = map.keys.first;
                                var value = map[key]!;
                                return ListTile(
                                  title: Text(key),
                                  trailing: Checkbox(
                                    value: value,
                                    activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    onChanged: (bool? newValue) {
                                      viewModel.setGridMap(key, newValue!);
                                    },
                                  ),
                                );

                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      }
  );
}
selectAreaInventory(BuildContext context,StockVm viewModel){
  ScrollController controller = ScrollController();
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            elevation: 0,
            backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
            content:SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height*0.80,
              child: Column(
                children: [
                  ChangeNotifierProvider.value(
                    value: viewModel,
                    child: Consumer<StockVm>(
                      builder: (context,value,_){
                        return RawScrollbar(
                          thumbColor: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: SizedBox(
                            height: sizeWidth(context).height*0.7,
                            child: ListView.builder(
                              itemCount: viewModel.gridMap.length,
                              itemBuilder: (context, index) {
                                var map = viewModel.gridMap[index];
                                var key = map.keys.first;
                                var value = map[key]!;
                                return ListTile(
                                  title: Text(key),
                                  trailing: Checkbox(
                                    value: value,
                                    activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    onChanged: (bool? newValue) {
                                      viewModel.setGridMap(key, newValue!);
                                    },
                                  ),
                                );

                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      }
  );
}
selectAreaLeadReport(BuildContext context,MyLeadVm viewModel){
  ScrollController controller = ScrollController();
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            elevation: 0,
            backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
            content:SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height*0.80,
              child: Column(
                children: [
                  ChangeNotifierProvider.value(
                    value: viewModel,
                    child: Consumer<MyLeadVm>(
                      builder: (context,value,_){
                        return RawScrollbar(
                          thumbColor: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: SizedBox(
                            height: sizeWidth(context).height*0.7,
                            child: ListView.builder(
                              itemCount: viewModel.gridMap.length,
                              itemBuilder: (context, index) {
                                var map = viewModel.gridMap[index];
                                var key = map.keys.first;
                                var value = map[key]!;
                                return ListTile(
                                  title: Text(key),
                                  trailing: Checkbox(
                                    value: value,
                                    activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    onChanged: (bool? newValue) {
                                      viewModel.setGridMap(key, newValue!);
                                    },
                                  ),
                                );

                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      }
  );
}

selectAreaApptReport(BuildContext context,MyAppointmentVm viewModel){
  ScrollController controller = ScrollController();
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
          content:SizedBox(
            width: sizeWidth(context).width,
            height: sizeWidth(context).height*0.80,
            child: Column(
              children: [
                ChangeNotifierProvider.value(
                  value: viewModel,
                  child: Consumer<MyAppointmentVm>(
                    builder: (context,value,_){
                      return RawScrollbar(
                        thumbColor: ColorUtil().getColor(
                            context, ColorEnums.wizzColor),
                        thumbVisibility: true,
                        thickness: 1,
                        trackVisibility: true,
                        controller: controller,
                        child: SizedBox(
                          height: sizeWidth(context).height*0.7,
                          child: ListView.builder(
                            itemCount: viewModel.gridMap.length,
                            itemBuilder: (context, index) {
                              var map = viewModel.gridMap[index];
                              var key = map.keys.first;
                              var value = map[key]!;
                              return ListTile(
                                title: Text(key),
                                trailing: Checkbox(
                                  value: value,
                                  activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                  onChanged: (bool? newValue) {
                                    viewModel.setGridMap(key, newValue!);
                                  },
                                ),
                              );

                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: sizeWidth(context).width*0.8,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("save".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        );
      }
  );
}


void valiDateInformation(BuildContext context, String errorMessage) {
  Future.delayed(const Duration(seconds: 0)).then((_) => {
    showModalBottomSheet(
        constraints: BoxConstraints(
          maxWidth:  sizeWidth(context).width,
        ),
        shape:  bottomSheetShape(context),
        backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
        context: context,

        useRootNavigator: true,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            width: sizeWidth(context).width,
            height: sizeWidth(context).height*0.40,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset("assets/info.png",height: sizeWidth(context).width*0.30,),
                  const SizedBox(height: 16,),
                  Text(errorMessage, style: CustomTextStyle().semiBold16(ColorUtil().getColor(context,ColorEnums.textTitleLight)),),
                ],
              ),
            ),
          );
        }),
  });
}


 Future<bool> checkTerms(BuildContext context) async{
  bool result = false;
   await showModalBottomSheet(
       backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
       constraints: BoxConstraints(
         maxWidth:  sizeWidth(context).width,
       ),
      builder: (context) {
        return SizedBox(
          height: sizeWidth(context).height*0.70,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(

                children: [

                  const SizedBox(height: 8,),
                  Text("termPrivacy".tr(),style: CustomTextStyle().black20(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text( """Hyla North America, LLC Terms and Conditions 
              
              Please read these Terms and Conditions ("Terms", "Terms and Conditions") carefully before using the Hyla North America, LLC Application System and the Hyla North America, LLC Mobile Application (the "Service") operated by Hyla North America, LLC ("us", "we", or "our").
              
              Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service.
              
              CONTENT AND USE OF THE SERVICES
               Responsibility for Content and Use of the Services.
              Content includes any data, information, materials, text, graphics, images, music, software, audio, video, works of authorship of any kind, that are uploaded, transmitted, posted, generated, stored or otherwise made available through the Services ("Content"), which will include without limitation any Content that account holders (including you) provide through your use of the Services. By making your Content available through your use of the Services, you grant Hyla North America, LLC a worldwide, royalty-free, non-exclusive license to host and use your Content. Archive your Content frequently. You are responsible for any lost or unrecoverable Content. You must provide all required and appropriate warnings, information and disclosures. Hyla North America, LLC is not responsible for any of your Content that you submit through the Services.
              You agree not to use, nor permit any third party to use, the Services to upload, post, distribute, link to, publish, reproduce, engage in, promote or transmit any of the following:
              Illegal, fraudulent, defamatory, obscene, pornographic, profane, threatening, abusive, hateful, harassing, offensive, inappropriate or objectionable information or communications of any kind, including without limitation conduct that is excessively violent, incites or threatens violence, encourages "flaming" others or criminal or civil liability under any local, state, federal or foreign law;
              Content that would impersonate someone else or falsely represent your identity or qualifications, or that may constitute a breach of any individual’s privacy; is illegally unfair or deceptive, or creates a safety or health risk to an individual or the public;
              Except as permitted by Hyla North America, LLC in writing, investment opportunities, solicitations, chain letters, pyramid schemes, other unsolicited commercial communication or spamming or flooding;
              Virus, Trojan horse, worm or other disruptive or harmful software or data; and
              Any Content that you do not own or have the right to use without permission from the intellectual property rights owners thereof.
              
               Restricted Use of the Services.
              You shall not, and shall not permit any users of the Services or any other party to, engage in, solicit, or promote any activity that is objectionable or may be illegal, violates the rights of others, is likely to cause notoriety, harm or damage to the reputation of Hyla North America, LLC or could subject Hyla North America, LLC to liability to third parties, including: (i) unauthorized access, monitoring, interference with, or use of the Services or third party accounts, data, computers, systems or networks; (ii) interference with others’ use of the Services or any system or network, including mail bombing, broadcast or denial of service attacks; (iii) unauthorized collection or use of personal or confidential information, including phishing, pharming, spidering, and harvesting; (iv) viewing or other use of any Content that, in Hyla North America, LLC’s opinion, is prohibited under this Agreement; (v) any other activity that places Hyla North America, LLC in the position of fostering, or having potential or actual liability for, illegal activity in any jurisdiction; or (vi) attempting to probe, scan, penetrate or test the vulnerability of a Hyla North America, LLC system or network or to breach Hyla North America, LLC security or authentication measures, whether by passive or intrusive techniques. Hyla North America, LLC reserves the right to not authorize and may terminate your use of the Services based on reasonable suspicion of your activities, business, products or services that are objectionable or promote, support or engage in any of the restricted uses described above.
              Community forums. The Services may include a community forum or other social features to exchange Content and information with other users of the Services and the public. Hyla North America, LLC does not support and is not responsible for the Content in these community forums. Please use respect when you interact with other users. Do not reveal information that you do not want to make public. Users may post hypertext links to content of third parties for which Hyla North America, LLC is not responsible.
              
              
              Hyla North America, LLC may freely use feedback you provide. You agree that Hyla North America, LLC may use your feedback, suggestions, or ideas in any way, including in future modifications of the Services, other products or services, advertising or marketing materials. You grant Hyla North America, LLC a perpetual, worldwide, fully transferable, sublicensable, non-revocable, fully paid-up, royalty free license to use the feedback you provide to Intuit in any way.
              
               Hyla North America, LLC may monitor Content. Hyla North America, LLC may, but has no obligation to, monitor access to or use of the Services or Content or to review or edit any Content for the purpose of operating the Services, to ensure compliance with this Agreement, and to comply with applicable law or other legal requirements. We may disclose any information necessary to satisfy our legal obligations, protect Hyla North America, LLC or its customers, or operate the Services properly. Hyla North America, LLC, in its sole discretion, may refuse to post, remove, or refuse to remove, or disable any Content, in whole or in part, that is alleged to be, or that we consider to be unacceptable, undesirable, inappropriate, or in violation of this Agreement.
              10. SOCIAL MEDIA SITES. Hyla North America, LLC may provide experiences on social media platforms such as Facebook®, Twitter® and LinkedIn® that enable online sharing and collaboration among anyone who has registered to use them. Any content you post, such as pictures, information, opinions, or any Personal Information that you make available to other participants on these social platforms, is subject to the Terms of Use and Privacy Policies of those platforms. Please refer to those social media platforms to better understand your rights and obligations with regard to such content.""",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => RegisterVm(),
                    child: Consumer<RegisterVm>(
                      builder: (context,value,_){
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                  activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                  checkColor: AppColors.white,
                                  value: value.checkTerm,
                                  onChanged: (check) {
                                    value.setTerm(check!);
                                    result = value.checkTerm;
                                  },
                                ),
                                SizedBox(
                                  width: sizeWidth(context).width*0.75,
                                  child: Column(
                                    children: [
                                      Text("iAgree".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                    ],
                                  ),
                                )
                              ],
                            ),

                          ],
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      }

  );
  return result;
}
Future<bool> cancelReward(BuildContext context) async{
  bool result = false;
  await showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return  Padding(
          padding: const EdgeInsets.all(8),
          child:  SizedBox(
            height: sizeWidth(context).height*0.20,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("doYouWantCancel".tr(),style: CustomTextStyle().black20(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.80,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: (){
                              result = true;
                              Navigator.pop(context);
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("approved".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),


        );
      }

  );
  return result;
}
Future<bool> askChangeStatusCom(BuildContext context) async{
  bool result = false;
  await showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return  Padding(
          padding: const EdgeInsets.all(8),
          child:  SizedBox(
            height: sizeWidth(context).height*0.20,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("changeComRate".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width*0.40,
                            child: ElevatedButton(
                                onPressed: (){
                                  result = false;
                                  Navigator.pop(context);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("no".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                            ),
                          ),
                          SizedBox(
                            width: sizeWidth(context).width*0.40,
                            child: ElevatedButton(
                                onPressed: (){
                                  result = true;
                                  Navigator.pop(context);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("yes".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                )
              ],
            ),
          ),


        );
      }

  );
  return result;
}

Future<bool> areYouSure(BuildContext context) async{
  bool result = false;
  await showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return  Padding(
          padding: const EdgeInsets.all(8),
          child:  SizedBox(
            height: sizeWidth(context).height*0.20,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("areYouSure".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: sizeWidth(context).width*0.40,
                              child: ElevatedButton(
                                  onPressed: (){
                                    result = false;
                                    Navigator.pop(context);
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("no".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                              ),
                            ),
                            SizedBox(
                              width: sizeWidth(context).width*0.40,
                              child: ElevatedButton(
                                  onPressed: (){
                                    result = true;
                                    Navigator.pop(context);
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("yes".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                )
              ],
            ),
          ),


        );
      }

  );
  return result;
}
Future<bool> approvedReward(BuildContext context) async{
  bool result = false;
  await showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return  Padding(
          padding: const EdgeInsets.all(8),
          child:  SizedBox(
            height: sizeWidth(context).height*0.20,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("wantToUpdateStatus".tr(),style: CustomTextStyle().black20(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: sizeWidth(context).width*0.80,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: (){
                              result = true;
                              Navigator.pop(context);
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("approved".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),


        );
      }

  );
  return result;
}
Future<bool> updateCustomerEvent(BuildContext context,String status) async{
  bool result = false;
  await showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return  Padding(
            padding: const EdgeInsets.all(8),
            child:  SizedBox(
              height: sizeWidth(context).height*0.20,
              child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(status =="PENDING" ? "wantToUpdateStatusApproved".tr() :"wantToUpdateStatusPending".tr(),style: CustomTextStyle().black20(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: sizeWidth(context).width*0.80,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: (){
                                  result = true;
                                  Navigator.pop(context);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("updateStatus".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            ),


        );
      }

  );
  return result;
}

showSocialMediaAccount(BuildContext context,String code){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(code,style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ],
          ),
        );
      }
  );
}
Future<void> saveAndLaunchFile(BuildContext context,List<int> bytes,) async {
  Random random = Random();
  var fileName = random.nextInt(99999 - 10000 + 1) + 10000;
  String? filePath;
  Directory? directory;
  if(Platform.isAndroid){
    filePath= await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
  }else{
    directory = await getApplicationDocumentsDirectory();
    filePath = directory.path;
  }
  final fileLocation = "$filePath/$fileName.xlsx";
  final File file = File(fileLocation);
  await file.writeAsBytes(bytes, flush: true);


  NotificationUtil().showNotification(title: "Successful",body: "downloadedFile".tr());
  showFile(context,fileLocation);

}

downloadExcel(BuildContext context,GlobalKey<SfDataGridState> key) async{
  Workbook workbook = key.currentState!.exportToExcelWorkbook();
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  await saveAndLaunchFile(context,bytes);
}
Future<void> generateAndOpenExcel(BuildContext context,List<StockReportDataDetails> dataDetails) async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  final List<String> headers = ['Product', 'Stock Date', 'Serial Number', 'Distributor', 'Created At', 'Updated At'];

  for (var i = 0; i < headers.length; i++) {
    final Range range = sheet.getRangeByIndex(1, i + 1);
    range.setText(headers[i]);
    range.cellStyle.hAlign = HAlignType.center; // Metinleri yatayda ortala
    range.cellStyle.vAlign = VAlignType.center; // Metinleri dikeyde ortala
  }

  // Add data
  int rowIndex = 2; // Start from row 2 (after headers)
  for (var item in dataDetails) {
    sheet.getRangeByIndex(rowIndex, 1).setText(item.productName!);
    sheet.getRangeByIndex(rowIndex, 2).setText(mmDDYDate(item.stockDate.toString()));
    sheet.getRangeByIndex(rowIndex, 3).setText(item.serialNumber!);
    sheet.getRangeByIndex(rowIndex, 4).setText(item.distName ?? "");
    sheet.getRangeByIndex(rowIndex, 5).setText(mmDDYDate(item.createdAt.toString()));
    sheet.getRangeByIndex(rowIndex, 6).setText(mmDDYDate(item.updatedAt.toString()));

    // Metin hücrelerini ortala
    for (var i = 1; i <= headers.length; i++) {
      final Range range = sheet.getRangeByIndex(rowIndex, i);
      range.cellStyle.hAlign = HAlignType.center;
      range.cellStyle.vAlign = VAlignType.center;
    }

    rowIndex++;
  }
  Random random = Random();
  var fileName = random.nextInt(99999 - 10000 + 1) + 10000;

  String? filePath;
  Directory? directory;
  if(Platform.isAndroid){
    filePath= await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
  }else{
    directory = await getApplicationDocumentsDirectory();
    filePath = directory.path;
  }
  final String fileLocation="$filePath/$fileName.xlsx";
  final List<int> bytes = workbook.saveAsStream();
  final File file = File(fileLocation);
  await file.writeAsBytes(bytes);

  // Open file
  NotificationUtil().showNotification(title: "Successful",body: "downloadedFile".tr());
  showFile(context,fileLocation);

}
showFile(BuildContext context,String filePath){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("downloadedFile".tr(),style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              const SizedBox(height: 4,),
              Text(filePath,style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              ChangeNotifierProvider(
                create: (_)=>CheckPermissionProvider(),
                child: Consumer<CheckPermissionProvider>(
                  builder: (context,value,_){
                    return ElevatedButton(
                      onPressed: ()async{
                        Navigator.pop(context);
                        if (value.status == null) {
                          await value.checkExternalStorage();
                        }

                         if(value.status!.isGranted){
                           final result = await OpenFile.open(filePath);
                           if (kDebugMode) {
                             print("type=${result.type}  message=${result.message}");
                           }

                           if(result.type==ResultType.noAppToOpen){
                             snackBarDesign(context, StringUtil.error, "weDidNotFindFile".tr());
                           }

                        }else{
                           snackBarDesign(context, StringUtil.error, "givePermission".tr());
                           value.checkExternalStorage();
                        }
                      },
                      style: elevatedButtonStyle(context),
                      child: Text("openFile".tr(),style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }
  );
}
showSaveBonusDialog(BuildContext context){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("saveConfigureBonus".tr(),style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              SizedBox(
                width: sizeWidth(context).width*0.8,
                child:  ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: elevatedButtonStyle(context),
                  child: Text("OK",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                ),
              ),
            ],
          ),
        );
      }
  );
}

showDrawCodeAlert(BuildContext context,String code){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${context.tr("drawCode")} :$code",style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
            ],
          ),
        );
      }
  );
}
updateStatusMySale(BuildContext context,MySaleVm viewModel,String serialId,int id) {
  showModalBottomSheet(
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      useRootNavigator: true,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<MySaleVm>(
            builder: (context,value,_){
              return SizedBox(
                height: sizeWidth(context).height*0.20,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(height: 8,),
                      Text("wantToUpdateStatus".tr(), style: CustomTextStyle().semiBold18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Serial id:", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          Text("#$serialId", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                        ],
                      ),

                      Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                   SizedBox(
                                      width: sizeWidth(context).width*0.4,
                                      child: ElevatedButton(
                                        style: elevatedButtonStyle(context),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await viewModel.updateStatus(context,id,serialId,"1");
                                        },
                                        child: Text(
                                          "approve".tr(),
                                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                        ),
                                      ),
                                    ),

                                  Text(
                                    "or".tr(),
                                    style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                  ),
                                  SizedBox(
                                      width: sizeWidth(context).width*0.4,
                                      child: ElevatedButton(
                                        style: elevatedButtonStyle(context),
                                        onPressed: () async {

                                        },
                                        child: Text(
                                          "cancelSale".tr(),
                                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                        ),
                                      ),
                                    ),


                                ],
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
  );
}
updateStatusOfficeSale(BuildContext context,OfficeSaleVm viewModel,String serialId,int id,Function func) {
  showModalBottomSheet(
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      useRootNavigator: true,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<OfficeSaleVm>(
            builder: (context,value,_){
              return SizedBox(
                height: sizeWidth(context).height*0.20,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(height: 8,),
                      Text("wantToUpdateStatus".tr(), style: CustomTextStyle().semiBold18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Serial id:", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          Text("#$serialId", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                        ],
                      ),

                      Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: sizeWidth(context).width*0.4,
                                    child: ElevatedButton(
                                      style: elevatedButtonStyle(context),
                                      onPressed: () async {

                                        await viewModel.updateStatus(context,id,serialId);
                                        await func();
                                        Navigator.pop(context);

                                      },
                                      child: Text(
                                        "approve".tr(),
                                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                      ),
                                    ),
                                  ),

                                  Text(
                                    "or".tr(),
                                    style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                  ),
                                  SizedBox(
                                    width: sizeWidth(context).width*0.4,
                                    child: ElevatedButton(
                                      style: elevatedButtonStyle(context),
                                      onPressed: () async {

                                        await viewModel.updateCancelStatus(context,id,serialId);
                                        await func();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "cancelSale".tr(),
                                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
  );
}
updateStatusApproveCancel(BuildContext context,OfficeSaleVm viewModel,String serialId,int id,Function func) {
  showModalBottomSheet(
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      useRootNavigator: true,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<OfficeSaleVm>(
            builder: (context,value,_){
              return SizedBox(
                height: sizeWidth(context).height*0.20,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(height: 8,),
                      Text("wantToUpdateStatus".tr(), style: CustomTextStyle().semiBold18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Serial id:", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          Text("#$serialId", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                        ],
                      ),

                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                 SizedBox(
                                    width: sizeWidth(context).width*0.4,
                                    child: ElevatedButton(
                                        style: elevatedButtonStyle(context),
                                        onPressed: () async {

                                          await viewModel.updateStatus(context,id,serialId);
                                          await func();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "approve".tr(),
                                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                        ),
                                      ),
                                    ),

                                Text(
                                  "or".tr(),
                                  style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                ),
                                SizedBox(
                                    width: sizeWidth(context).width*0.4,
                                    child: ElevatedButton(
                                      style: elevatedButtonStyle(context),
                                      onPressed: () async {
                                        await viewModel.updatePendingStatus(context,id,serialId);
                                        await func();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "pending".tr(),
                                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                      ),
                                    ),
                                  ),


                              ],
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
  );
}
referralDetails(BuildContext context,Customer customer,List<SmsLog>? smsLog) async{
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("customerInfo".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              const SizedBox(height: 8,),
              Card(
                shape: cardShape(context),
                color: ColorUtil().getColor(context, ColorEnums.background),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customer.avatar !=null ? GestureDetector(
                              onTap: (){
                                showPhoto(context, customer.avatar);
                              },
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                    size: const Size.fromRadius(16),
                                    // Image radius
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/loading.gif',
                                      image: customer.avatar,
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                            ): Image.asset("assets/uploadPhoto.webp",height: 64,),
                            const SizedBox(width: 8,),
                            SizedBox(
                              width: sizeWidth(context).width*0.50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${customer.firstName!} ${customer.middleName ?? ""} ${customer.lastName ?? ""}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  const SizedBox(height: 4,),
                                  Text(customer.loginEmail ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  const SizedBox(height: 4,),
                                  Text(customer.loginPhone ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  const SizedBox(height: 4,),
                                  Text(customer.dateOfBirth ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  const SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      customer.tiktok !=null ?
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Image.asset("assets/tiktok.png",height: 24,),
                                      ) : Container(),
                                      const SizedBox(width: 8,),
                                      customer.facebook !=null ?
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Image.asset("assets/facebook.png",height: 24,),
                                      ) : Container(),
                                      const SizedBox(width: 8,),
                                      customer.instagram !=null ?
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Image.asset("assets/instagram.png",height: 24,),
                                      ) : Container(),
                                      const SizedBox(width: 8,),
                                      customer.twitter !=null ?
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Image.asset("assets/twitter.png",height: 24,),
                                      ) : Container()
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(customer.isActive !=null && customer.isActive ==true ? "Active" : "InActive",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                ],
                              ),
                            )
                          ]
                      ),
                    ],
                  ),

                ),
              ),
              const SizedBox(height: 4,),
              smsLog!.isNotEmpty ? SizedBox(
                height: sizeWidth(context).height*0.30,
                child: RawScrollbar(
                  controller: controller,
                  thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                  thumbVisibility: true,
                  thickness: 1,
                  child: ListView.builder(
                    controller: controller,
                    itemCount: smsLog.length,
                    itemBuilder: (context,index){
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
                                  Text("smsType".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                  Text(smsLog[index].smsTitle!,style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("sendDate".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                  Text(formatDate(smsLog[index].sentDate!.toString()),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),

                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              ),
                              const SizedBox(height: 8,),
                              Text(smsLog[index].smsBody!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ):const SizedBox()
            ],
          ),



        );

      }

  );

}
contestsQualifications(BuildContext context,List<Qualifications?>? line) async{
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 4,),
              SizedBox(
                height: sizeWidth(context).height*0.45,
                child: RawScrollbar(
                  controller: controller,
                  thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                  thumbVisibility: true,
                  thickness: 1,
                  child: ListView.builder(
                    controller: controller,
                    itemCount: line!.length,
                    itemBuilder: (context,index){
                      return Card(
                        shape: cardShape(context),
                        color: ColorUtil().getColor(context, ColorEnums.background),
                        elevation: 4 ,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child:  Row(
                            children: [
                              // Sol taraftaki görüntü
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("createDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                      const SizedBox(height: 4,),
                                      Text("updatedDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                      const SizedBox(height: 4,),
                                      Text("type".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                      const SizedBox(height: 4,),
                                      Text("period".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)

                                    ],
                                  )
                              ),
                              // Sağ taraftaki metin
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(formatDate(line[index]!.createdAt!.toString()),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                      const SizedBox(height: 4,),
                                      Text(formatDate(line[index]!.updatedAt!.toString()),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                      const SizedBox(height: 4,),
                                      Text(line[index]!.type!.toString(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                      const SizedBox(height: 4,),
                                      Text(line[index]!.period!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)


                                    ],
                                  )
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

      }

  );

}
showComDetails(BuildContext context,List<Detail> details,int poolId) async{
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
        maxHeight: sizeWidth(context).height*0.85
      ),
      builder: (context) {
        return Column(
            children: [
              Text("commissionRateScale".tr(),style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
              Text("Total ${details.length}",style: CustomTextStyle().black18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

              RawScrollbar(
                thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                thumbVisibility: true,
                thickness: 1,
                trackVisibility: true,
                controller: controller,
                child: SizedBox(
                  height: sizeWidth(context).height*0.70,
                  child: ListView.builder(
                    controller: controller,
                    itemCount: details.length,
                    itemBuilder: (context,value){
                      return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                        Text("${value+1}", style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("minAmount".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                            Text("\$${details[value].amountLevel1 ?? "0"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                          ],
                                        ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("maxAmount".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           Text("\$${details[value].amountLevel2 ?? "0"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                         ],
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text(details[value].comType ?? "", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                           details[value].comType =="AMOUNT"
                                               ? Text("\$${details[value].commAmount ?? "0"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)))
                                               : Text("${details[value].comPercentage ?? "0"}%", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)))
                                         ],
                                       ),
                                    const SizedBox(height: 8,),
                                    SizedBox(
                                      width:sizeWidth(context).width*0.80,
                                      height: 30,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, '/${PageName.adminEditComRate}',arguments: {"detail":details[value]});

                                        },
                                        style: elevatedButtonStyle(context),
                                        child: Text("edit".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                      ),
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
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:sizeWidth(context).width*0.4,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("back".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                      ),
                    ),
                    SizedBox(
                      width:sizeWidth(context).width*0.4,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/${PageName.addCurrentCommissionRate}',arguments: {"poolId":poolId});

                        },
                        style: elevatedButtonStyle(context),
                        child: Text("addAnew".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                      ),
                    ),
                  ],
                ),
              )
            ],
        );

      }

  );

}

rewardOrderLines(BuildContext context,List<RewardOrderLine?>? line) async{
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                    const SizedBox(height: 4,),
                   SizedBox(
                       height: sizeWidth(context).height*0.30,
                       child: RawScrollbar(
                         controller: controller,
                         thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                         thumbVisibility: true,
                         thickness: 1,
                         child: ListView.builder(
                           controller: controller,
                           itemCount: line!.length,
                           itemBuilder: (context,index){
                             return Card(
                               shape: cardShape(context),
                               color: ColorUtil().getColor(context, ColorEnums.background),
                               elevation: 4 ,
                               child: Padding(
                                 padding: const EdgeInsets.all(8),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     GestureDetector(
                                       onTap:(){
                                      showPhoto(context, line[index]!.reward!.imagePath!);
                                     },
                                       child: ClipOval(
                                         child: SizedBox.fromSize(
                                             size: const Size.fromRadius(32),
                                             // Image radius
                                             child: FadeInImage.assetNetwork(
                                               placeholder: 'assets/loading.gif',
                                               image: line[index]!.reward!.imagePath!,
                                               fit: BoxFit.cover,
                                             )
                                         ),
                                       ),
                                     ),
                                     Expanded(
                                       child: Padding(
                                         padding: const EdgeInsets.all(8),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(line[index]!.reward!.title!,style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                             const SizedBox(height: 2,),
                                             Divider(
                                               thickness: 1,
                                               color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                             ),
                                             const SizedBox(height: 2,),
                                             Text(line[index]!.reward!.description!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                           ],
                                         ),
                                       ),
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

      }

  );

}
customerEventDetails(BuildContext context,RewardEvent rewardEvent,List<RewardEventActivityDetailDocuments?>? details) async{

  showModalBottomSheet(
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 4,),
              SizedBox(
                child: Card(
                  shape: cardShape(context),
                  color: ColorUtil().getColor(context, ColorEnums.background),
                  elevation: 4 ,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        rewardEvent.eventDocument !=null ? SizedBox(
                            width: sizeWidth(context).width*0.35,
                            child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/loading.gif',
                                    image: rewardEvent.eventDocument!,
                                    fit: BoxFit.cover,
                                  ),
                          ) : const SizedBox(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(rewardEvent.eventViewName!,style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 2,),
                                Divider(
                                  thickness: 1,
                                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                ),
                                const SizedBox(height: 2,),
                                Text(rewardEvent.eventViewDescription!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             details !=null && details[0]!.documentPath !=null ? SingleChildScrollView(
               child: SizedBox(
                  height: sizeWidth(context).height*0.30,
                  child: VideoPage("",details[0]!.documentPath!),
                ),
             ) : SizedBox(
               height: sizeWidth(context).height*0.30,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("isNotUploadVideo".tr(),style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                 ],
               ),
             )
            ],
          ),
        );
      }
  );
}
showContactList(BuildContext context,ContactProvider viewModel){
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<ContactProvider>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchContact(viewModel.contactModel,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child:  ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchContact(viewModel.contactModel,viewModel.query).length,
                            itemBuilder: (context,index){
                              ContactModel model = viewModel.searchContact(viewModel.contactModel,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                          const SizedBox(width: 4,),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(model.displayName,style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                const SizedBox(height: 4,),
                                                Text(model.phones,style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Checkbox(
                                                checkColor: AppColors.white,
                                                activeColor: AppColors.wizzColor,
                                                value: model.isChecked,
                                                onChanged: (bool? v) {
                                                  if(model.phones.length >10){
                                                    viewModel.setCheck(viewModel.contactModel,viewModel.query,index,v!);
                                                  }else{
                                                    snackBarDesign(context, StringUtil.error, "wrongPhone".tr());
                                                  }

                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("back".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              ),
                              ElevatedButton(
                                onPressed: ()async{
                                  await viewModel.addListFromContact(context,viewModel.contactModel);
                                  await viewModel.getReferralList(context);
                                  Navigator.pop(context);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("addContact".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              )
                            ],
                          ),
                        ),
                      ),

                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
selectGraphReport(BuildContext context,HomeVm viewModel){
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<HomeVm>(
            builder: (context,value,_){
              return SizedBox(
                height: sizeWidth(context).height*0.35,
                child: Column(
                    children: [
                      RawScrollbar(
                        thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        thumbVisibility: true,
                        thickness: 1,
                        trackVisibility: true,
                        controller: controller,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4,left: 4,right: 4),
                          child: SizedBox(
                              height: sizeWidth(context).height*0.30,
                              child: ListView.builder(
                                controller: controller,
                                itemCount:  day.length,
                                itemBuilder: (context,index){
                                  return  GestureDetector(
                                      onTap: (){
                                        viewModel.setReportIndex(day[index]);
                                        Navigator.pop(context);
                                      },
                                      child:Card(
                                        elevation: 4,
                                        shape: cardShape(context),
                                        color: ColorUtil().getColor(context, ColorEnums.background),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(day[index],style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  if(viewModel.reportIndex == index)
                                                    Icon(Icons.check,color: ColorUtil().getColor(context, ColorEnums.wizzColor),)
                                                ],

                                          ),
                                        ),
                                      )
                                 );
                                },
                              ),
                            ),
                        ),
                        ),

                    ]
                ),
              );
            },
          ),
        );
      }
  );
}

selectProgressReport(BuildContext context,MyProgressVm viewModel){
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<MyProgressVm>(
            builder: (context,value,_){
              return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RawScrollbar(
                        thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        thumbVisibility: true,
                        thickness: 1,
                        trackVisibility: true,
                        controller: controller,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4,left: 4,right: 4),
                          child: SizedBox(
                            height: sizeWidth(context).height*0.50,
                            child: ListView.builder(
                                controller: controller,
                                itemCount:  progressList.length,
                                itemBuilder: (context,index){
                                  return  GestureDetector(
                                      onTap: (){
                                        viewModel.setReportIndex(index,viewModel.detailsReportModel!);
                                        Navigator.pop(context);
                                      },
                                      child:Card(
                                              shape: cardShape(context),
                                              elevation: 2,
                                              color: ColorUtil().getColor(context, ColorEnums.background),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(progressList[index],style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                        if(viewModel.progressIndex == index)
                                                          Icon(Icons.check,color: ColorUtil().getColor(context, ColorEnums.wizzColor),)
                                                      ],
                                                    ),
                                                ),
                                              ),
                                  );
                                },
                              ),
                            ),
                        ),
                      ),
                    ]
              );
            },
          ),
        );
      }
  );
}

showSaleList(BuildContext context,ExpenseVm viewModel){
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<ExpenseVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchSaleList(viewModel.expenseSale!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchSaleList(viewModel.expenseSale!,viewModel.query).length,
                            itemBuilder: (context,index){
                              ExpenseSale model = viewModel.searchSaleList(viewModel.expenseSale!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: (){
                                    viewModel.setSaleId(model.cname!,model.serialid!);
                                    viewModel.setId(model.id!);
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                      shape: cardShape(context),
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                            const SizedBox(width: 4,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(model.cname!,style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  const SizedBox(height: 4,),
                                                  Text(model.serialid!,style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  const SizedBox(height: 4,),
                                                  Text(formatDate(model.date!.toString()),style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),


                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
showUserList(BuildContext context,AdminOverrideVm viewModel){
  viewModel.setQuery("");
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminOverrideVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchUserList(viewModel.overrideUserList!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchUserList(viewModel.overrideUserList!,viewModel.query).length,
                            itemBuilder: (context,index){
                              OverrideUserList model =viewModel.searchUserList(viewModel.overrideUserList!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                          const SizedBox(width: 4,),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${model.name!} - ${model.menuroles ?? ""}",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width:sizeWidth(context).width*0.3,
                                            child: ElevatedButton(
                                              onPressed: (){
                                                viewModel.setUser(model.name!,model.id!);
                                                Navigator.pop(context);
                                              },
                                              style: elevatedButtonStyle(context),
                                              child: Text("select".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ),
                                          )

                                        ],
                                      ),
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      ),


                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
selectUserList(BuildContext context,AdminOverrideVm viewModel){
  viewModel.setQuery("");
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminOverrideVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.selectUserList(viewModel.allUsers!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.selectUserList(viewModel.allUsers!,viewModel.query).length,
                            itemBuilder: (context,index){
                              AllUsers model =viewModel.selectUserList(viewModel.allUsers!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: (){
                                    viewModel.setUser(model.name!,model.id!);
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                      shape: cardShape(context),
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                            const SizedBox(width: 4,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${model.name!} - ${model.menuRoles ?? ""}",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: ()async{
                                                OverrideUserPost overrideUser= OverrideUserPost(
                                                    userId: model.id
                                                );
                                                await viewModel.postOverrideUser(context, overrideUser);
                                              },
                                              style: elevatedButtonStyle(context),
                                              child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),


                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
updateOverrideConfig(BuildContext context,int id,AdminOverrideVm viewModel,Function() func){
  TextEditingController amount = TextEditingController();
  showModalBottomSheet(

      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminOverrideVm>(
            builder: (context,value,_){
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width*0.4,
                            child: ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("back".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                            ),
                          ),
                          SizedBox(
                            width: sizeWidth(context).width*0.4,
                            child: ElevatedButton(
                                onPressed: ()async{
                                   amount.text = amount.text.replaceAll("\$", "");
                                   if(amount.text.isNotEmpty){
                                     UpdateOverrideConfig update = UpdateOverrideConfig(
                                         configId :id,
                                         overrideAmount : amount.text
                                     );
                                     await viewModel.updateConfig(context,update,func);
                                  }else{
                                     Navigator.pop(context);
                                     snackBarDesign(context, StringUtil.error, "overrideAmountRequired".tr());
                                   }
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("update".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8,),
                      TextField(
                        maxLines: null,
                        controller: amount,
                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                        decoration: textFieldTextDesign(context,"overrideAmount"),
                        cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [CurrencyTextInputFormatter(symbol: '\$')],
                      ),

                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
Future<Map<String,dynamic>>selectWarehouseList(BuildContext context,StockVm viewModel)async{
   Map<String,dynamic> values={};
  viewModel.setQuery("");
  ScrollController controller = ScrollController();
  await showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<StockVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query).length,
                            itemBuilder: (context,index){
                              WarehouseList model =viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(model.warehouseName ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                const SizedBox(height: 4,),
                                                Text(model.warehousePhone ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                const SizedBox(height: 4,),
                                                Text(model.warehouseState ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: ()async{
                                              values["distId"] = model.warehouseId;
                                              values["distName"] = model.warehouseName;
                                              values["warehouseName"]=model.warehouseName;
                                              Navigator.pop(context);
                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: ()async{
                            values["distId"] = null;
                            values["warehouseName"]=null;
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("back".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        ),
                      )
                    ]
                ),
              );
            },
          ),
        );
      }
  );
  return values;
}
showOrgList(BuildContext context,AdminOverrideVm viewModel){
  viewModel.query="";
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminOverrideVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchOrgList(viewModel.organisations!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchOrgList(viewModel.organisations!,viewModel.query).length,
                            itemBuilder: (context,index){
                              OrgDetails model =viewModel.searchOrgList(viewModel.organisations!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: (){
                                    viewModel.setDist("${model.organisationName!}/${model.userName}",model.organisationId!);
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                      shape: cardShape(context),
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${model.organisationName}/${model.userName}",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),


                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
Future<int?>showOrgInventoryDist(BuildContext context,WarehouseVm viewModel)async{
    viewModel.query="";
  ScrollController controller = ScrollController();
  await showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<WarehouseVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchDist(viewModel.organisations!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchDist(viewModel.organisations!,viewModel.query).length,
                            itemBuilder: (context,index){
                              AllOrganisations model =viewModel.searchDist(viewModel.organisations!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: (){
                                    viewModel.setDistIdForReport(model.name!,model.id!);
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                      shape: cardShape(context),
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(model.name ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),


                    ]
                ),
              );
            },
          ),
        );
      }

  );
  return viewModel.distId;
}
selectDistWarehouse(BuildContext context,WarehouseVm viewModel){
  viewModel.query="";
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<WarehouseVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchDist(viewModel.organisations!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchDist(viewModel.organisations!,viewModel.query).length,
                            itemBuilder: (context,index){
                              AllOrganisations model =viewModel.searchDist(viewModel.organisations!,viewModel.query)[index];
                              return Card(
                                  shape: cardShape(context),
                                  color: ColorUtil().getColor(context, ColorEnums.background),
                                  elevation: 4,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.person,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(model.name ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: ()async{
                                              viewModel.setDistId(model.name!,model.id!);
                                              Navigator.pop(context);
                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("select".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          )
                                        ],
                                      )
                                  )
                              );
                            },
                          ),
                        ),
                      ),


                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
selectAssignStockList(BuildContext context,StockVm viewModel){
  viewModel.query="";
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<StockVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchAssignStock(viewModel.allAssignStock!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:   viewModel.searchAssignStock(viewModel.allAssignStock!,viewModel.query).length,
                            itemBuilder: (context,index){
                              AllAssignStock model = viewModel.searchAssignStock(viewModel.allAssignStock!,viewModel.query)[index];
                              return Card(
                                  shape: cardShape(context),
                                  color: ColorUtil().getColor(context, ColorEnums.background),
                                  elevation: 4,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(model.serialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                const SizedBox(height: 4,),
                                                Text(model.productName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                const SizedBox(height: 4,),
                                                Text(mmDDYDate(model.stockDate ?? ""),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                const SizedBox(height: 4,),

                                              ],
                                            )
                                          ),
                                          Checkbox(
                                            activeColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                            checkColor: AppColors.white,
                                            value: model.check,
                                            onChanged: (check) {
                                              viewModel.setAssignStockCheckbox(index,check!,viewModel.searchAssignStock(viewModel.allAssignStock!,viewModel.query));
                                            },
                                          ),
                                        ],
                                      )
                                  )
                              );
                            },
                          ),
                        ),
                      ),
                     Padding(
                       padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           SizedBox(
                             width: sizeWidth(context).width*0.4,
                             height: 50,
                             child: ElevatedButton(
                                 onPressed: ()async{
                                   viewModel.setQuery("");
                                   viewModel.addPoolListWithModel(viewModel.searchAssignStock(viewModel.allAssignStock!,viewModel.query));
                                   Navigator.pop(context);
                                 },
                                 style: elevatedButtonStyle(context),
                                 child: Text("select".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                             ),
                           ),
                           SizedBox(
                             width: sizeWidth(context).width*0.4,
                             height: 50,
                             child: ElevatedButton(
                                 onPressed: ()async{
                                   Navigator.pop(context);
                                 },
                                 style: elevatedButtonStyle(context),
                                 child: Text("cancel".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                             ),
                           ),
                         ],
                       ),
                     )

                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
selectOverrideNameBase(BuildContext context,AdminOverrideVm viewModel){
  viewModel.query="";

  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminOverrideVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);
                              viewModel.searchName(viewModel.search,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchName(viewModel.search,viewModel.query).length,
                            itemBuilder: (context,index){
                              String name = viewModel.searchName(viewModel.search,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    elevation: 4,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.person,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(name,style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: ()async{
                                                viewModel.setQuery(name);
                                                viewModel.overrideUser.text = name;
                                                viewModel.totalOverrideDetails =0;
                                                for(int i=0;i<viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query).length;i++){
                                                  AdminOverrideWinner model = viewModel.searchWinner(viewModel.overrideWinner!,viewModel.query)[i];
                                                  viewModel.totalOverrideDetails +=double.parse(model.overrideAmount ?? "0.0");
                                                }
                                                Navigator.pop(context);
                                              },
                                              style: elevatedButtonStyle(context),
                                              child: Text("select".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            )
                                          ],
                                        )
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      ),


                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
selectLeadStatus(BuildContext context,MyLeadVm viewModel,int leadId){
  viewModel.query="";
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<MyLeadVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchLeadStatus(viewModel.leadStatusList!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount: viewModel.searchLeadStatus(viewModel.leadStatusList!,viewModel.query).length,
                            itemBuilder: (context,index){
                              LeadStatusList model =viewModel.searchLeadStatus(viewModel.leadStatusList!,viewModel.query)[index];
                              return Card(
                                  shape: cardShape(context),
                                  color: ColorUtil().getColor(context, ColorEnums.background),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: sizeWidth(context).width*0.6,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(model.name ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                              ],
                                            )
                                        ),

                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: ()async{
                                               LeadStatusPost status = LeadStatusPost(
                                                 leadId: leadId,
                                                 leadStatusId: model.id
                                               );
                                               await viewModel.updateLeadStatus(context,status);

                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("update".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ),
                                        )
                                      ],
                                    )
                                  )
                              );
                            },
                          ),
                        ),
                      ),


                    ]
                ),
              );
            },
          ),
        );
      }
  );
}


updateProductCoast(BuildContext context,AdminOverrideVm viewModel,int id){
  TextEditingController amount = TextEditingController();
  showModalBottomSheet(

      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminOverrideVm>(
            builder: (context,value,_){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                      children: [
                        accountNumber(context, "amount", amount),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              height: 30,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("cancel".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                            ),
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              height: 30,
                              child: ElevatedButton(
                                  onPressed: () async{
                                    if(amount.text.isNotEmpty){
                                      UpdateProductCoast update = UpdateProductCoast(
                                          costId: id,
                                          costAmount: amount.text
                                      );
                                      await viewModel.updateProduct(context, update);
                                      Navigator.pop(context);
                                    }else{
                                      Navigator.pop(context);
                                      snackBarDesign(context, StringUtil.error, "requiredAmountArea".tr());
                                    }
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("update".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                            ),
                          ],
                        )
                      ]

                ),
              );
            },
          ),
        );
      }
  );
}
selectDemo(BuildContext context,LiveDemoVm viewModel){

  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<LiveDemoVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setDemoQuery(value);

                              viewModel.searchAppointment(viewModel.leadList!,viewModel.demoQuery);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchAppointment(viewModel.leadList!,viewModel.demoQuery).length,
                            itemBuilder: (context,index){
                              Draw model =viewModel.searchAppointment(viewModel.leadList!,viewModel.demoQuery)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: ()async{
                                    List<String> numaraParcalari = model.cphone!.split("-");
                                    String phone = numaraParcalari.length > 1 ? numaraParcalari[1] : "";
                                    viewModel.setInformation(
                                        model.ccity ?? "",model.czipcode ?? "",model.cstate ?? "",
                                        model.ccounty ?? "",model.cfirstname ?? "",model.clastname ?? "",phone,model.cemail ?? "",
                                        model.caddress ?? "",model.code);
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                      shape: cardShape(context),
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                            const SizedBox(width: 4,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(model.cname ?? "",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  const SizedBox(height: 4,),
                                                  Text(model.cphone ?? "",style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  const SizedBox(height: 4,),
                                                  Text(model.cemail ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),


                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
selectAssignSerial(BuildContext context,SalesVm viewModel){

  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<SalesVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      const SizedBox(height: 24,),
                      SizedBox(
                          width: sizeWidth(context).width*0.70,
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


                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.40,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchAssign(viewModel.assignList!,viewModel.query).length,
                            itemBuilder: (context,index){
                              AssignDealerList model =viewModel.searchAssign(viewModel.assignList!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:  Card(
                                shape: cardShape(context),
                                color: ColorUtil().getColor(context,ColorEnums.background),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
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
                                      const Divider(
                                        thickness: 0.5,
                                      ),
                                      const SizedBox(height: 4,),
                                      SizedBox(
                                        width: sizeWidth(context).width*0.8,
                                        height: 30,
                                        child: ElevatedButton(
                                          onPressed: (){
                                            viewModel.setSerial(model.serialNumber!);
                                            Navigator.pop(context);
                                          },
                                          style: elevatedButtonStyle(context),
                                          child: Text("select".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),

                              );
                            },
                          ),
                        ),
                      ),
                      Text("OR",style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: accountCreate(context, "enterSerialNumber", viewModel.serialIdController),
                      ),
                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
showTotalSale(BuildContext context,int index, SalesReport salesReport){
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      shape: bottomSheetShape(context),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      useRootNavigator: true,
      builder: (context) {
        List<dynamic> data;
        switch (index) {
          case 0:
            data = salesReport.lastMonthlyDayCount!;
            break;
          case 1:
            data = salesReport.yesterdayHourlyCount!;
            break;
          case 2:
            data = salesReport.todayHourlyCount!;
            break;
          case 3:
            data = salesReport.weeklyDayCount!;
            break;
          case 4:
            data = salesReport.monthlyDayCount!;
            break;
          case 5:
            data = salesReport.annualMonthCount!;
            break;
          default:
            data = [];

}
        return  SizedBox(
          height: sizeWidth(context).height*0.85,
          child: RawScrollbar(
              thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
              thumbVisibility: true,
              thickness: 1,
              trackVisibility: true,
              controller: controller,
              child: ListView.builder(
                controller: controller,
                itemCount: data.length,
                itemBuilder: (context, dataIndex) {
                  var item = data[dataIndex];
                  if (item != null) {
                    String title;
                    int count;
                    int totalPrice;
                    if (index == 1 || index==2) {
                      title = item.hour ?? "";
                      count = item.count ?? 0;
                      totalPrice = item.totalPrice ?? 0;
                    } else if (index ==0 || index == 3 || index == 4) {
                      title = item.day ?? "";
                      count = item.count ?? 0;
                      totalPrice = item.totalPrice ?? 0;
                    } else {
                      title = item.month ?? "";
                      count = item.count ?? 0;
                      totalPrice = item.totalPrice ?? 0;
                    }
                    if(count >0){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildCard(context,"sales",totalPrice, title, count),
                      );
                    }
                  }
                  return const SizedBox(); // Geçersiz veya eksik veri için boş bir SizedBox döndür
                },
              ),

          ),
        );
      },
  );
}
showTotalLeads(BuildContext context, int index, LeadsReport leadReports) {

    ScrollController controller = ScrollController();
    List<Widget>cardList=[];
    if(index == 0){
      cardList.clear();
      for(int i = 0; i < leadReports.leadReports!.length; i++){
        for(int a = 0; a < leadReports.leadReports![i].lastMonthlyNotContactedDayCount!.length; a++){
          if(leadReports.leadReports![i].lastMonthlyNotContactedDayCount![a].count!>0){
            cardList.add(
              buildCardLeads(context, "Not Contacted",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].lastMonthlyNotContactedDayCount![a].day!,
                  leadReports.leadReports![i].lastMonthlyNotContactedDayCount![a].count!),
            );
          }
        }
        for(int a = 0; a < leadReports.leadReports![i].lastMonthlyAppointmentSetDayCount!.length; a++){
          if(leadReports.leadReports![i].lastMonthlyAppointmentSetDayCount![a].count!>0){
            cardList.add(
              buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].lastMonthlyAppointmentSetDayCount![a].day!,
                  leadReports.leadReports![i].lastMonthlyAppointmentSetDayCount![a].count!),
            );
          }
        }
        for(int a = 0; a < leadReports.leadReports![i].lastMonthlySaleSoldDayCount!.length; a++){
          if(leadReports.leadReports![i].lastMonthlySaleSoldDayCount![a].count!>0){
            cardList.add(
              buildCardLeads(context, "Sold",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].lastMonthlySaleSoldDayCount![a].day!,
                  leadReports.leadReports![i].lastMonthlySaleSoldDayCount![a].count!),
            );
          }
        }
      }
    }

    if(index == 1){
      cardList.clear();
      for(int i = 0; i < leadReports.leadReports!.length; i++){
        for(int a = 0; a < leadReports.leadReports![i].yesterdayAppointmentSetHourly!.length; a++){
          if(leadReports.leadReports![i].yesterdayAppointmentSetHourly![a].count!>0){
            cardList.add(
              buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].yesterdayAppointmentSetHourly![a].hour!,
                  leadReports.leadReports![i].yesterdayAppointmentSetHourly![a].count!),
            );
          }
        }
      }
    }

    if(index == 2){
      cardList.clear();
      for(int i = 0; i < leadReports.leadReports!.length; i++){
        for(int a = 0; a < leadReports.leadReports![i].daliyAppointmentSetHourly!.length; a++){
          if(leadReports.leadReports![i].daliyAppointmentSetHourly![a].count!>0){
            cardList.add(
              buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].daliyAppointmentSetHourly![a].hour!,
                  leadReports.leadReports![i].daliyAppointmentSetHourly![a].count!),
            );
          }
        }
      }
    }

    if(index == 3){
      cardList.clear();
      for(int i = 0; i < leadReports.leadReports!.length; i++){
        for(int a = 0; a < leadReports.leadReports![i].weeklyNotContactedDayCount!.length; a++){
          if(leadReports.leadReports![i].weeklyNotContactedDayCount![a].count!>0){
            cardList.add(
              buildCardLeads(context, "Not Contacted",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].weeklyNotContactedDayCount![a].day!,
                  leadReports.leadReports![i].weeklyNotContactedDayCount![a].count!),
            );
          }
        }
        for(int a = 0; a < leadReports.leadReports![i].weeklyAppointmentSetDayCount!.length; a++){
          if(leadReports.leadReports![i].weeklyAppointmentSetDayCount![a].count!>0){
            cardList.add(
              buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].weeklyAppointmentSetDayCount![a].day!,
                  leadReports.leadReports![i].weeklyAppointmentSetDayCount![a].count!),
            );
          }
        }
        for(int a = 0; a < leadReports.leadReports![i].weeklySoldDayCount!.length; a++){
          if(leadReports.leadReports![i].weeklySoldDayCount![a].count!>0){
            cardList.add(
              buildCardLeads(context, "Sold",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].weeklySoldDayCount![a].day!,
                  leadReports.leadReports![i].weeklySoldDayCount![a].count!),
            );
          }
        }
      }

    }

    if(index == 4){
      cardList.clear();
      for(int i = 0; i < leadReports.leadReports!.length; i++){
        for(int a = 0; a < leadReports.leadReports![i].monthlyNotContactedDayCount!.length; a++){
          if(leadReports.leadReports![i].monthlyNotContactedDayCount![a].count!>0){
            cardList.add(
              buildCardLeads(context, "Not Contacted",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].monthlyNotContactedDayCount![a].day!,
                  leadReports.leadReports![i].monthlyNotContactedDayCount![a].count!),
            );
          }
        }
        for(int a = 0; a < leadReports.leadReports![i].monthlyAppointmentSetDayCount!.length; a++){
          if(leadReports.leadReports![i].monthlyAppointmentSetDayCount![a].count!>0){
            cardList.add(
              buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].monthlyAppointmentSetDayCount![a].day!,
                  leadReports.leadReports![i].monthlyAppointmentSetDayCount![a].count!),
            );
          }
        }
        for(int a = 0; a < leadReports.leadReports![i].monthlySaleSoldDayCount!.length; a++){
          if(leadReports.leadReports![i].monthlySaleSoldDayCount![a].count!>0){
            cardList.add(
              buildCardLeads(context, "Sold",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].monthlySaleSoldDayCount![a].day!,
                  leadReports.leadReports![i].monthlySaleSoldDayCount![a].count!),
            );
          }
        }

      }

    }

    if(index == 5){
      cardList =[];
      for(int i = 0; i < leadReports.leadReports!.length; i++){
        for(int a = 0; a < leadReports.leadReports![i].annualyNotContactedMonthly!.length; a++){
          if(leadReports.leadReports![i].annualyNotContactedMonthly![a].count!>0){

              cardList.add(
                buildCardLeads(context, "Not Contacted",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].annualyNotContactedMonthly![a].month!,
                    leadReports.leadReports![i].annualyNotContactedMonthly![a].count!),
              );

          }
        }
        for(int a = 0; a < leadReports.leadReports![i].annualyAppointmentSetMonthly!.length; a++){
          if(leadReports.leadReports![i].annualyAppointmentSetMonthly![a].count!>0){
            cardList.add(
              buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].annualyAppointmentSetMonthly![a].month!,
                  leadReports.leadReports![i].annualyAppointmentSetMonthly![a].count!),
            );


          }
        }
        for(int a = 0; a < leadReports.leadReports![i].annualySoldMonthly!.length; a++){
          if(leadReports.leadReports![i].annualySoldMonthly![a].count!>0){
            cardList.add(
              buildCardLeads(context, "Sold",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].annualySoldMonthly![a].month!,
                  leadReports.leadReports![i].annualySoldMonthly![a].count!),
            );
          }
        }

      }
    }
    showModalBottomSheet(
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxWidth: sizeWidth(context).width,
        ),
        backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
        context: context,
        shape: bottomSheetShape(context),
        useRootNavigator: true,
        builder: (context) {
          return SizedBox(
            height: sizeWidth(context).height*0.90,
            child: RawScrollbar(
              thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
              thumbVisibility: true,
              thickness: 1,
              trackVisibility: true,
              controller: controller,
              child: ListView.builder(
                shrinkWrap: true,
                controller: controller,
                itemCount: cardList.length,
                itemBuilder: (context, itemIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cardList[itemIndex],
                  );
                },
              ),
            ),
          );
        }
    );
  }
showTotalAppointment(BuildContext context, int index, LeadsReport leadReports) {

  ScrollController controller = ScrollController();
  List<Widget>cardList=[];
  if(index == 0){
    cardList.clear();
    for(int i = 0; i < leadReports.leadReports!.length; i++){
      for(int a = 0; a < leadReports.leadReports![i].lastMonthlyAppointmentSetDayCount!.length; a++){
        if(leadReports.leadReports![i].lastMonthlyAppointmentSetDayCount![a].count!>0){
          cardList.add(
            buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].lastMonthlyAppointmentSetDayCount![a].day!,
                leadReports.leadReports![i].lastMonthlyAppointmentSetDayCount![a].count!),
          );
        }
      }

    }
  }

  if(index == 1){
    cardList.clear();
    for(int i = 0; i < leadReports.leadReports!.length; i++){
      for(int a = 0; a < leadReports.leadReports![i].yesterdayAppointmentSetHourly!.length; a++){
        if(leadReports.leadReports![i].yesterdayAppointmentSetHourly![a].count!>0){
          cardList.add(
            buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].yesterdayAppointmentSetHourly![a].hour!,
                leadReports.leadReports![i].yesterdayAppointmentSetHourly![a].count!),
          );
        }
      }
    }
  }

  if(index == 2){
    cardList.clear();
    for(int i = 0; i < leadReports.leadReports!.length; i++){
      for(int a = 0; a < leadReports.leadReports![i].daliyAppointmentSetHourly!.length; a++){
        if(leadReports.leadReports![i].daliyAppointmentSetHourly![a].count!>0){
          cardList.add(
            buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].daliyAppointmentSetHourly![a].hour!,
                leadReports.leadReports![i].daliyAppointmentSetHourly![a].count!),
          );
        }
      }
    }
  }

  if(index == 3){
    cardList.clear();
    for(int i = 0; i < leadReports.leadReports!.length; i++){

      for(int a = 0; a < leadReports.leadReports![i].weeklyAppointmentSetDayCount!.length; a++){
        if(leadReports.leadReports![i].weeklyAppointmentSetDayCount![a].count!>0){
          cardList.add(
            buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].weeklyAppointmentSetDayCount![a].day!,
                leadReports.leadReports![i].weeklyAppointmentSetDayCount![a].count!),
          );
        }
      }

    }

  }

  if(index == 4){
    cardList.clear();
    for(int i = 0; i < leadReports.leadReports!.length; i++){

      for(int a = 0; a < leadReports.leadReports![i].monthlyAppointmentSetDayCount!.length; a++){
        if(leadReports.leadReports![i].monthlyAppointmentSetDayCount![a].count!>0){
          cardList.add(
            buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].monthlyAppointmentSetDayCount![a].day!,
                leadReports.leadReports![i].monthlyAppointmentSetDayCount![a].count!),
          );
        }
      }
    }
  }

  if(index == 5){
    cardList.clear();
    for(int i = 0; i < leadReports.leadReports!.length; i++){

      for(int a = 0; a < leadReports.leadReports![i].annualyAppointmentSetMonthly!.length; a++){
        if(leadReports.leadReports![i].annualyAppointmentSetMonthly![a].count!>0){
          cardList.add(
            buildCardLeads(context, "AppointmentSet",leadReports.leadReports![i].leadTypeName!, leadReports.leadReports![i].annualyAppointmentSetMonthly![a].month!,
                leadReports.leadReports![i].annualyAppointmentSetMonthly![a].count!),
          );
        }
      }
    }
  }
  showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: sizeWidth(context).width,
      ),
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      useRootNavigator: true,
      builder: (context) {
        return SizedBox(
          height: sizeWidth(context).height*0.90,
          child: RawScrollbar(
            thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
            thumbVisibility: true,
            thickness: 1,
            trackVisibility: true,
            controller: controller,
            child: ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: cardList.length,
              itemBuilder: (context, itemIndex) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: cardList[itemIndex],
                );
              },
            ),
          ),
        );
      }
  );
}


sliderClick(BuildContext context,String title,String type,String link) async{
  switch(type){
    case "video":{
      Navigator.pushNamed(context, '/${PageName.videoPage}',
        arguments: {'title': title, 'url':link},);
    }
    break;
    case "pdf":{
      Navigator.pushNamed(context, '/${PageName.pdfPage}',
        arguments: {'title': title, 'url':link},);
    }
    break;
    case "photo":{
     showPhoto(context, link);
    }
    break;
    case "link":{
      await launchUrl(Uri.parse(link));
    }
  }

}


 showCarouselDetails(BuildContext context,String url,String type) async{

  await showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
        minWidth: sizeWidth(context).width,
      ),
      builder: (context) {
        return SizedBox(
          height: sizeWidth(context).height*0.70,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    type =="video" ?
                    SizedBox(
                      height: sizeWidth(context).height*0.40,
                      child: VideoPage("",url),
                    ):type=="pdf" || type=="application/pdf" ?
              
                    SizedBox(
                      height: sizeWidth(context).height*0.60,
                      child: PdfPage("",url),
                    ):  Image.network(
                      url, fit: BoxFit.cover,height: sizeWidth(context).height*0.45,width: sizeWidth(context).width,)
              
                  ],
                ),
            ),
            ),

        );
      }
  );
}
Future<bool> uploadDocument(BuildContext context,File file,String type) async{
  bool result = false;
  await showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return SizedBox(
          height: sizeWidth(context).height*0.80,
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
              
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("cancel".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
              
                          ),
                          ElevatedButton(
                            onPressed: ()async{
                              result = true;
                              Navigator.pop(context);
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("upload".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
              
                          )
                        ],
                      ),
                      const SizedBox(height: 8,),
                      type =="mp4" ?
                      SizedBox(
                        height: sizeWidth(context).height*0.50,
                        child: VideoPage("",file.path),
                      ):type=="pdf" || type=="application/pdf" ?
              
                      SizedBox(
                        height: sizeWidth(context).height*0.50,
                        child: PdfPageFile("",file),
                      ):  Image.file(
                            file, fit: BoxFit.contain,),
                    ],
                  ),
            ),
          ),


        );
      }

  );
  return result;
}

Future<bool> uploadJustPdf(BuildContext context,File file) async{
  bool result = false;
  await showModalBottomSheet(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context) {
        return SizedBox(
          height: sizeWidth(context).height*0.70,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  SizedBox(
                    height: sizeWidth(context).height*0.60,
                    child: PdfPageFile("",file),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("cancel".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                      ),
                      ElevatedButton(
                        onPressed: ()async{
                          result = true;
                          Navigator.pop(context);
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("upload".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                      )
                    ],
                  )

                ],
              ),
            ),
          ),
        );
      }

  );
  return result;
}

areYouSurePay(BuildContext context,SalesVm viewModel,int id,int saleId){

  showModalBottomSheet(
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<SalesVm>(
            builder: (context,value,_){
              return SizedBox(
                height: sizeWidth(context).height*0.4,
                child: Column(

                    children: [
                       const SizedBox(height: 8,),
                       Text("doYouWantPay".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                       Expanded(
                         child: Align(
                           alignment: Alignment.bottomCenter,
                           child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 SizedBox(
                                   width: sizeWidth(context).width*0.4,
                                   child: ElevatedButton(
                                     onPressed: (){
                                       Navigator.pop(context);
                                     },
                                     style: elevatedButtonStyle(context),
                                     child: Text("cancel".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                   ),
                                 ),
                                 SizedBox(
                                   width: sizeWidth(context).width*0.4,
                                   child: ElevatedButton(
                                     onPressed: ()async{
                                       Navigator.pop(context);
                                       PayPost post = PayPost(calcPoolSaleId: id);
                                       await viewModel.postComPay(context,post,saleId);
                                     },
                                     style: elevatedButtonStyle(context),
                                     child: Text("pay".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                   ),
                                 )
                               ],
                             ),
                         ),
                       ),


                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
Future<bool>paidQuestion(BuildContext context) async{
  bool check=false;
  await showModalBottomSheet(
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return SizedBox(
          height: sizeWidth(context).height*0.4,
          child: Column(
              children: [
                const SizedBox(height: 16,),
                Text("doYouWantPay".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width*0.4,
                            child: ElevatedButton(
                              onPressed: (){
                                check = false;
                                Navigator.pop(context);
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("cancel".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                          ),
                          SizedBox(
                            width: sizeWidth(context).width*0.4,
                            child: ElevatedButton(
                              onPressed: ()async{
                                check = true;
                                Navigator.pop(context);

                              },
                              style: elevatedButtonStyle(context),
                              child: Text("pay".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),


              ]
          ),
        );
      }
  );
  return check;
}
Future<bool>returnPaidQuestion(BuildContext context) async{
  bool check=false;
  await showModalBottomSheet(
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return SizedBox(
          height: sizeWidth(context).height*0.4,
          child: Column(
              children: [
                const SizedBox(height: 16,),
                Text("doYouWantReturnPay".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width*0.4,
                            child: ElevatedButton(
                              onPressed: (){
                                check = false;
                                Navigator.pop(context);
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("cancel".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                          ),
                          SizedBox(
                            width: sizeWidth(context).width*0.4,
                            child: ElevatedButton(
                              onPressed: ()async{
                                check = true;
                                Navigator.pop(context);

                              },
                              style: elevatedButtonStyle(context),
                              child: Text("yes".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),


              ]
          ),
        );
      }
  );
  return check;
}
showComSaleDetails(BuildContext context,List<ComSaleDetails> details){
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return SizedBox(
          height: sizeWidth(context).height*0.75,
          child: Column(
              children: [
                RawScrollbar(
                  thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                  thumbVisibility: true,
                  thickness: 1,
                  trackVisibility: true,
                  controller: controller,
                  child: SizedBox(
                    height: sizeWidth(context).height*0.7,
                    child: ListView.builder(
                      controller: controller,
                      itemCount:  details.length,
                      itemBuilder: (context,index){
                        ComSaleDetails item = details[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("cName".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(item.cname ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  GestureDetector(
                                    onTap: ()async{
                                      if(item.cphone !=null){
                                        openDialPad(item.cphone!);
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.40,
                                            child: Text("cPhone".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(item.cphone ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                          ],

                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.20,
                                          child: Text("email".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(item.cemail ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("state".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(item.cstate ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("address".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(item.caddress ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("zipCode".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(item.czipcode ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.20,
                                          child: Text("price".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("\$${item.price ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.20,
                                          child: Text("netPrice".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("\$${item.netprice ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("fee1".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("\$${item.fee1 ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("fee2".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("\$${item.fee2 ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("otherDeduction".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("\$${item.otherDeductions ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  if(item.financepercentage !=null)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.40,
                                            child: Text("financePercentage".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text("${item.financepercentage ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                          ],

                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 4,),
                                  if(item.receiveAmount !=null)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.40,
                                            child: Text("receiveAmount".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text("\$${item.receiveAmount ?? "0.00"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                          ],

                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 4,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width:sizeWidth(context).width*0.40,
                                          child: Text("tax".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("%${item.tax ?? "0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ],

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  if(item.note !=null)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.40,
                                            child: Text("note".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(item.note ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                          ],

                                        ),
                                      ],
                                    ),
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      if(item.distributor != null)
                                        Column(
                                          children: [
                                            item.distributor!.image !=null ?
                                            ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(16),
                                                  // Image radius
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/loading.gif',
                                                    image: item.distributor!.image!,
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ):ClipOval(
                                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                            ),
                                            Text("DST",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.distributor!.name ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.distributor!.phone ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                          ],
                                        ),
                                      const SizedBox(width: 4,),
                                      if(item.dealer != null)
                                        Column(
                                          children: [
                                            item.dealer!.image !=null ?
                                            ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(16),
                                                  // Image radius
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/loading.gif',
                                                    image: item.dealer!.image!,
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ):ClipOval(
                                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                            ),
                                            Text("DL",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.dealer!.name ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.dealer!.phone ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                          ],
                                        ),
                                      const SizedBox(width: 4,),
                                      if(item.da != null)

                                        Column(
                                          children: [
                                            item.da!.image !=null ?
                                            ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(16),
                                                  // Image radius
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/loading.gif',
                                                    image: item.da!.image!,
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ):ClipOval(
                                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                            ),
                                            Text("DA",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.da!.name ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.da!.phone ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                          ],
                                        ),
                                      const SizedBox(width: 4,),
                                      if(item.dps != null)
                                        Column(
                                          children: [
                                            item.dps!.image !=null ?
                                            ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(16),
                                                  // Image radius
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/loading.gif',
                                                    image: item.dps!.image!,
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ):ClipOval(
                                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                            ),
                                            Text("DPS",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.dps!.name ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.dps!.phone ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                          ],
                                        ),
                                      const SizedBox(width: 4,),
                                      if(item.user != null)
                                        Column(
                                          children: [
                                            item.user!.image !=null ?
                                            ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(16),
                                                  // Image radius
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/loading.gif',
                                                    image: item.user!.image!,
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ):ClipOval(
                                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                            ),
                                            Text("USER",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.user!.name ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.user!.phone ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                          ],
                                        ),
                                      const SizedBox(width: 4,),
                                      if(item.leader != null)
                                        Column(
                                          children: [
                                            item.leader!.image !=null ?
                                            ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(16),
                                                  // Image radius
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/loading.gif',
                                                    image: item.leader!.image!,
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ):ClipOval(
                                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                            ),
                                            Text("TL",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.leader!.name ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.leader!.phone ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                          ],
                                        ),
                                      const SizedBox(width: 4,),
                                      if(item.sm != null)
                                        Column(
                                          children: [
                                            item.sm!.image !=null ?
                                            ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(16),
                                                  // Image radius
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/loading.gif',
                                                    image: item.sm!.image!,
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ):ClipOval(
                                                child: Image.asset("assets/uploadPhoto.webp",height: 64,)
                                            ),
                                            Text("SM",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.sm!.name ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                            const SizedBox(height: 4,),
                                            Text(item.sm!.phone ?? "",style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                          ],
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: sizeWidth(context).width*0.8,
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("back".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                        ),
                      ),
                    ),
                  ),
                ),
              ]
          ),
        );
      }
  );
}
selectAppointmentReport(BuildContext context,MyAppointmentVm viewModel){
  ScrollController controller = ScrollController();
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<MyAppointmentVm>(
            builder: (context,value,_){
              return Column(

                  children: [
                     RawScrollbar(
                        thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                        thumbVisibility: true,
                        thickness: 1,
                        trackVisibility: true,
                        controller: controller,
                        child: SizedBox(
                          height: sizeWidth(context).height*0.45,
                          child: ListView.builder(
                            controller: controller,
                            itemCount:  days.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                    onTap: (){
                                      viewModel.setReportIndex(days[index]);
                                      Navigator.pop(context);
                                    },
                                    child: Card(
                                              shape: cardShape(context),
                                              color: ColorUtil().getColor(context, ColorEnums.background),
                                              elevation: 4,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(days[index],style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    if(viewModel.reportIndex == index)
                                                      Icon(Icons.check,color: ColorUtil().getColor(context, ColorEnums.wizzColor),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                        )
                              );
                            },
                          ),
                        ),
                      ),

                  ]
              );
            },
          ),
        );
      }
  );
}
openReportDetail(BuildContext context,String name,HomeVm viewModel){
  switch (name){
    case "Sales":
      if(viewModel.totalSales>0){
        showTotalSale(context,viewModel.reportIndex,viewModel.detailsReportModel!.salesReport!);
      }else{
        snackBarDesign(context, StringUtil.warning, "notYetTotalSales".tr());
      }
    break;
    case "Demos":
      if(viewModel.totalAppointment>0){
        showTotalAppointment(context,viewModel.reportIndex,viewModel.detailsReportModel!.leadsReport!);
      }else{
        snackBarDesign(context, StringUtil.warning, "notYetTotalAppointment".tr());
      }
    break;
    case "Leads":
      if(viewModel.totalLeads>0){

        showTotalLeads(context,viewModel.reportIndex,viewModel.detailsReportModel!.leadsReport!);
      }else{
        snackBarDesign(context, StringUtil.warning, "notYetTotalLeads".tr());
      }

  }
}

uploadContract(BuildContext context,ContractVm viewModel){
  viewModel.contractName=null;

  showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      useRootNavigator: true,
      builder: (context) {
        return  ChangeNotifierProvider.value(
              value:viewModel,
              child: Consumer<ContractVm>(
                builder: (context,value,_){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: sizeWidth(context).height*0.20,
                      child: Column(

                              children: [
                                Container(
                                  decoration: containerDecoration(context),
                                  width: sizeWidth(context).width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButton<String>(
                                      dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                      underline: const SizedBox(),

                                      hint: Text("updateDocument".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                      value: viewModel.contractName,
                                      onChanged: (newValue) {
                                        ContractType selectedContract = viewModel.contractType!.firstWhere(
                                              (contract) => contract.contractName == newValue,);

                                        viewModel.setContractName(newValue!,selectedContract.contractId!);
                                      },
                                      items: viewModel.contractType!.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value.contractName,

                                          child: Row(
                                            children: [
                                              Text(value.contractName!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8,),

                                if(viewModel.contractName !=null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.80,
                                          child: ElevatedButton(
                                            onPressed: ()async{
                                              Map<String, dynamic>  docMap=await DocumentHelper.getDocument(context);
                                              if (docMap["document"] != null) {
                                                if (kDebugMode) {
                                                  print("tipler :${docMap["fileType"]}");
                                                }
                                                if(docMap["fileType"]=="pdf"){

                                                   bool result =  await uploadJustPdf(context,docMap["document"]);
                                                    if(result){
                                                      viewModel.documentFile = docMap["document"];
                                                      await viewModel.postDistContract(context,viewModel.contractId!,viewModel.documentFile!);
                                                      await viewModel.getDistContract(context);
                                                    }
                                                }else{
                                                  Navigator.pop(context);
                                                  snackBarDesign(context, StringUtil.error, "youCanUploadOnlyPdf".tr());
                                                }
                                              }
                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("selectPdfFile".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                              ],
                            ),
                    ),

                  );
                },
              ),
        );
      });
}
showContractPostFile(BuildContext context,ContractVm viewModel){
  ScrollController controller = ScrollController();
  List<String> distId=[];
  viewModel.documentFile=null;
  TextEditingController contractName = TextEditingController();
  showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
        minHeight: sizeWidth(context).height*0.90
      ),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,
      shape: bottomSheetShape(context),
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return  ChangeNotifierProvider.value(
          value:viewModel,
          child: Consumer<ContractVm>(
            builder: (context,value,_){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child:  SingleChildScrollView(
                  child: Column(
                      children: [
                        const SizedBox(height: 4,),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16),
                          child: accountCreate(context, "contractName", contractName),
                        ),
                        const SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              onChanged: (value){
                                viewModel.setQuery(value);
                  
                                viewModel.addContract(viewModel.organisations!,viewModel.query);
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
                            child:SizedBox(
                              height: sizeWidth(context).height*0.60,
                              child: ListView.builder(
                                controller: controller,
                                itemCount:viewModel.addContract(viewModel.organisations!,viewModel.query).length,
                                itemBuilder: (context,index){
                                  AllOrganisations model = viewModel.addContract(viewModel.organisations!,viewModel.query)[index];
                                  return Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(
                                        context, ColorEnums.background),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(model.name!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Checkbox(
                                                  checkColor: AppColors.white,
                                                  activeColor: ColorUtil().getColor(context,
                                                      ColorEnums.wizzColor),
                                                  value: model.check!,
                                                  onChanged: (value) {
                                                    viewModel.setCheck(viewModel.addContract(viewModel.organisations!,viewModel.query),index, value!);
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                  
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ) ,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: sizeWidth(context).width*0.80,
                                  child: ElevatedButton(
                                    onPressed: ()async{
                                      distId.clear();
                                      for(int i=0;i<viewModel.addContract(viewModel.organisations!,viewModel.query).length;i++){
                                        if(viewModel.addContract(viewModel.organisations!,viewModel.query)[i].check == true){
                                          distId.add(viewModel.addContract(viewModel.organisations!,viewModel.query)[i].id!.toString());
                                        }
                                      }
                                      if(distId.isNotEmpty && contractName.text.isNotEmpty){
                                        Map<String, dynamic>  docMap=await DocumentHelper.getDocument(context);
                                        if (docMap["document"] != null) {
                                          if (kDebugMode) {
                                            print("tipler :${docMap["fileType"]}");
                                          }
                                          if(docMap["fileType"]=="pdf"){

                                            bool result =  await uploadJustPdf(context,docMap["document"]);
                                            if(result){
                                              viewModel.documentFile = docMap["document"];
                                              await viewModel.postAdminContracts(context, contractName.text, distId, viewModel.documentFile!);
                                            }
                                          }else{
                                            Navigator.pop(context);
                                            snackBarDesign(context, StringUtil.error, "youCanUploadOnlyPdf".tr());
                                          }
                                        }
                                      }else{
                                        Navigator.pop(context);
                                        snackBarDesign(context, StringUtil.error, "requiredContractNameType".tr());
                                      }
                                    },
                                    style: elevatedButtonStyle(context),
                                    child: Text("selectPdfFile".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  
                                  ),
                                ),
                  
                              ],
                            ),
                          ),
                  
                      ],
                    ),
                ),


              );
            },
          ),
        );
      });
}
barcodeSetDist(BuildContext context,StockVm viewModel){
  ScrollController controller = ScrollController();
  viewModel.query ="";
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<StockVm>(
            builder: (context,value,_){
              return  SingleChildScrollView(
                  child: Column(
                    children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 16,bottom: 16),
                         child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: sizeWidth(context).width*0.7,
                                height: 40,
                                child: TextField(
                                  onChanged: (value){
                                    viewModel.setQuery(value);
                                    viewModel.searchOrganisation(viewModel.organisations!,viewModel.query);
                                  },
                                  decoration: searchTextDesign(context, "search"),
                                  cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                                ),
                              ),
                            ],

                         ),
                       ),
                      RawScrollbar(
                        controller: controller,
                        thumbVisibility: true,
                        thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        thickness: 1,
                        child: SizedBox(
                          height: sizeWidth(context).height*0.75,
                          child: ListView.builder(
                            controller: controller,
                            itemCount: viewModel.searchOrganisation(viewModel.organisations!,viewModel.query).length,
                            itemBuilder: (context,index){
                              AllOrganisations model = viewModel.searchOrganisation(viewModel.organisations!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                               width: sizeWidth(context).width*0.5,
                                               child: Text(model.name ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                           if(model.id !=0)
                                             Expanded(
                                               child: SizedBox(
                                                 width: sizeWidth(context).width*0.2,
                                                 child: ElevatedButton(
                                                   onPressed: (){
                                                     viewModel.setAllDistId(model.name!, model.id!);
                                                     viewModel.clearDistWarehouseName();
                                                     Navigator.pop(context);

                                                   },
                                                   style: elevatedButtonStyle(context),
                                                   child: Text("select".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                                 ),
                                               ),
                                             )
                                         ],
                                       )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ),
                      ),
                    ],
                  ),

              );
            },
          ),
        );
      }
  );
}

Future<File?> uploadSignature(BuildContext context) async{
  File? file;
  GlobalKey<SfSignaturePadState> key = GlobalKey();
 await showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      backgroundColor:ColorUtil().getColor(context, ColorEnums.background),
      context: context,
     shape: bottomSheetShape(context),
      useRootNavigator: true,
      builder: (context) {
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: sizeWidth(context).height*0.50,
            child: Column(

                children: [
                  Text("signInSignature".tr(),
                    style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  SizedBox(
                    height: sizeWidth(context).height*0.40,
                    child: SfSignaturePad(
                      key: key,
                      backgroundColor:AppColors.white ,
                      strokeColor: AppColors.black,

                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: ()  {
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("cancel".tr(),
                            style: CustomTextStyle().semiBold12(ColorUtil()
                                .getColor(context, ColorEnums.textTitleLight)),),
                    
                        ),
                        ElevatedButton(
                          onPressed: ()  async{
                            ui.Image image = await key.currentState!.toImage();
                            final byteData = await image.toByteData(
                                format: ui.ImageByteFormat.png
                            );
                    
                            final Uint8List imageBytes = byteData!.buffer.asUint8List(
                                byteData.offsetInBytes,byteData.lengthInBytes);
                    
                    
                            String? filePath;
                            Directory? directory;
                            if(Platform.isAndroid){
                              filePath= await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
                            }else{
                              directory = await getApplicationDocumentsDirectory();
                              filePath = directory.path;
                            }
                            final fileLocation = "$filePath/signature.png";
                            file = File(fileLocation);
                            await file!.writeAsBytes(imageBytes, flush: true);
                            Navigator.pop(context);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("upload".tr(),
                            style: CustomTextStyle().semiBold12(ColorUtil()
                                .getColor(context, ColorEnums.textTitleLight)),),
                    
                        ),
                      ],
                    ),
                  )
                ],

            ),
          ),
        );
      });
  return file;
}
showDealerList(BuildContext context,StockVm viewModel,String seriNumber,int poolId){
  ScrollController controller = ScrollController();

  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<StockVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);
                              viewModel.searchDealer(viewModel.stockDealer!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child:  ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchDealer(viewModel.stockDealer!,viewModel.query).length,
                            itemBuilder: (context,index){
                              StockDealer model = viewModel.searchDealer(viewModel.stockDealer!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: [
                                          Row(

                                            children: [
                                              if (model.image !=null) GestureDetector(
                                                onTap:(){
                                                  showPhoto(context, model.image!);
                                                },
                                                child: ClipOval(
                                                  child: SizedBox.fromSize(
                                                      size: const Size.fromRadius(16),
                                                      // Image radius
                                                      child: FadeInImage.assetNetwork(
                                                        placeholder: 'assets/loading.gif',
                                                        image: model.image!,
                                                        fit: BoxFit.cover,
                                                      )
                                                  ),
                                                ),
                                              ) else Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                              const SizedBox(width: 4,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(model.name ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    const SizedBox(height: 4,),
                                                    Text(model.phone ?? "",style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    const SizedBox(height: 4,),
                                                    Text(model.email ?? "",style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: sizeWidth(context).width*0.30,
                                                height:30,
                                                child: ElevatedButton(
                                                  onPressed: ()async{

                                                    PostStockDealer post = PostStockDealer(
                                                        poolDetailId: poolId,
                                                        dealerId: model.id,
                                                        distributorId: model.distributor,
                                                        serialNumber: int.tryParse(seriNumber)
                                                    );
                                                    await viewModel.postDealer(context,post);


                                                  },
                                                  style: elevatedButtonStyle(context),
                                                  child: Text("select".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                ),
                                              ),
                                            ],
                                          ),



                                        ],
                                      ),
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                          SizedBox(
                            width: sizeWidth(context).width*0.80,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("back".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            ),
                          ),


                        ),
                      ),

                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
showUserCom(BuildContext context,CommissionVm viewModel,int type){
  ScrollController controller = ScrollController();

  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<CommissionVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      const SizedBox(height: 8,),
                      SizedBox(
                        width: sizeWidth(context).width*0.70,
                        height: 40,
                        child: TextField(
                          onChanged: (value){
                            viewModel.setQuery(value);
                            viewModel.searchDealer(viewModel.stockDealer!,viewModel.query);
                          },
                          decoration: searchTextDesign(context, "search"),
                          cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        ),
                      ),


                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.40,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child:  ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.searchDealer(viewModel.stockDealer!,viewModel.query).length,
                            itemBuilder: (context,index){
                              StockDealer model = viewModel.searchDealer(viewModel.stockDealer!,viewModel.query)[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child:
                                      Row(
                                        children: [
                                          model.image !=null ?
                                          ClipOval(
                                            child: SizedBox.fromSize(
                                                size: const Size.fromRadius(16),
                                                // Image radius
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: 'assets/loading.gif',
                                                  image: model.image!,
                                                  fit: BoxFit.cover,
                                                )
                                            ),
                                          ):
                                          Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                          const SizedBox(width: 4,),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(model.name ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                const SizedBox(height: 4,),
                                                Text(model.profilemenurole ?? "",style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                              ],
                                            ),
                                          ),
                                          Radio<int>(
                                              activeColor: ColorUtil().getColor(context,ColorEnums.wizzColor),
                                              value: model.id!,
                                              groupValue: viewModel.profileId,
                                              onChanged: (int? value) {
                                                ComExist post = ComExist(
                                                    profileId: model.id,
                                                    roleId: null
                                                );
                                                viewModel.postComExist(context,post,model.id!,"${model.name!} / ${model.profilemenurole!}",type);
                                              }
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                          SizedBox(
                            width: sizeWidth(context).width*0.80,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("back".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            ),
                          ),
                        ),
                      ),

                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
showDistInventoryWarehouse(BuildContext context,StockVm viewModel,int poolId,Function() function){
  ScrollController controller = ScrollController();
  viewModel.query="";
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<StockVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      SizedBox(
                        width: sizeWidth(context).width*0.70,
                        height: 40,
                        child: TextField(
                          onChanged: (value){
                            viewModel.setQuery(value);
                            viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query);
                          },
                          decoration: searchTextDesign(context, "search"),
                          cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        ),
                      ),


                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child:  ListView.builder(
                            controller: controller,
                            itemCount: viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query).length,
                            itemBuilder: (context,index){
                              WarehouseList model = viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query)[index];
                              return  Card(
                                shape: cardShape(context),
                                color: ColorUtil().getColor(context, ColorEnums.background),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(model.warehouseName ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                            const SizedBox(height: 4,),
                                            Text(model.warehousePhone ?? "",style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: ElevatedButton(
                                          onPressed: ()async{
                                            PostDistInventoryWarehouse post = PostDistInventoryWarehouse(
                                                distributorWarehouseId: model.warehouseId,
                                                poolDetailId: poolId
                                            );
                                            await viewModel.postDistWarehouse(context, post,function);

                                          },
                                          style: elevatedButtonStyle(context),
                                          child: Text("add".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                          SizedBox(
                            width: sizeWidth(context).width*0.80,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("back".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            ),
                          ),
                        ),
                      ),

                    ]
                ),
              );
            },
          ),
        );
      }
  );
}
showImporterWarehouse(BuildContext context,StockVm viewModel){
  ScrollController controller = ScrollController();
  viewModel.query="";
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<StockVm>(
            builder: (context,value,_){
              return SingleChildScrollView(
                child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      SizedBox(
                          width: sizeWidth(context).width*0.70,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);
                              viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),


                      const SizedBox(height: 8,),
                      SizedBox(
                        height: sizeWidth(context).height*0.75,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child:  ListView.builder(
                            controller: controller,
                            itemCount: viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query).length,
                            itemBuilder: (context,index){
                              WarehouseList model = viewModel.searchWarehouse(viewModel.warehouseList!,viewModel.query)[index];
                              return  Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                              children: [

                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(model.warehouseName ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                      const SizedBox(height: 4,),
                                                      Text(model.warehousePhone ?? "",style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  child: ElevatedButton(
                                                    onPressed: ()async{
                                                     viewModel.setImporterWarehouseName(model.warehouseName!,model.warehouseId!);
                                                     Navigator.pop(context);

                                                    },
                                                    style: elevatedButtonStyle(context),
                                                    child: Text("select".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                              SizedBox(
                                width: sizeWidth(context).width*0.80,
                                child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("back".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                ),
                              ),
                        ),
                      ),

                    ]
                ),
              );
            },
          ),
        );
      }
  );
}

showRolesCom(BuildContext context,CommissionVm viewModel,int type){
  ScrollController controller = ScrollController();

  showModalBottomSheet(

      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<CommissionVm>(
            builder: (context,value,_){
              return  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: sizeWidth(context).height*0.50,
                        child: RawScrollbar(
                          thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                          thumbVisibility: true,
                          thickness: 1,
                          trackVisibility: true,
                          controller: controller,
                          child:  ListView.builder(
                            controller: controller,
                            itemCount:  viewModel.allRoles!.length,
                            itemBuilder: (context,index){
                              AllRoles model = viewModel.allRoles![index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(model.viewName ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          const SizedBox(height: 8,),
                                          Radio<int>(
                                            activeColor: ColorUtil().getColor(context,ColorEnums.wizzColor),
                                            value: model.id!,
                                            groupValue: viewModel.roleId,
                                            onChanged: (int? value) async{
                                              ComExist post = ComExist(
                                                  profileId: null,
                                                  roleId: model.id
                                              );
                                               viewModel.postComExist(context,post,value!,"Role / ${model.viewName!}",type);
                                              }

                                          )
                                        ],
                                      ),
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ]
              );
            },
          ),
        );
      }
  );
}
showAdjust(BuildContext context,CommissionVm viewModel,int id){
  TextEditingController updateAdjust = TextEditingController();
  showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<CommissionVm>(
            builder: (context,value,_){
              return  SizedBox(
                height: sizeWidth(context).height*0.70,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("back".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                            ),
                            ElevatedButton(
                                onPressed: ()async{
                                  if(updateAdjust.text.isNotEmpty){
                                    int adjust = int.parse(updateAdjust.text.split('.')[0]);
                                    PostAdjust post = PostAdjust(
                                        calcPoolSaleId:  id,
                                        adjustAmount: adjust
                                    );
                                    await viewModel.postComAdjust(context, post);
                                  }else{
                                    Navigator.pop(context);
                                    snackBarDesign(context, StringUtil.error, "requiredAdjust".tr());
                                  }
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("save".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                            ),
                          ],
                        ),
                        accountNumber(context, "updateCom", updateAdjust),


                      ]
                  ),
                ),
              );
            },
          ),
        );
      }
  );
}
showAskNewSale(BuildContext context){
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return  SizedBox(
          height: sizeWidth(context).height*0.30,
          child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                    child: Text("doYouWantNewSale".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("back".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                              ),
                            ),
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child: ElevatedButton(
                                  onPressed: ()async{
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/${PageName.addSale}',arguments: {'demoId':null});

                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("add".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )

                ]

          ),
        );
      }
  );
}
showAskNewAppt(BuildContext context){
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return  SizedBox(
          height: sizeWidth(context).height*0.30,
          child:  Column(
                children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                  child: Text("doYouWantNewAppt".tr(),style: CustomTextStyle().semiBold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("back".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                              ),
                            ),
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child: ElevatedButton(
                                  onPressed: ()async{
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/${PageName.leadsAppointment}');

                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("add".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]
            ),

        );
      }
  );
}
showAdjustSale(BuildContext context,SalesVm viewModel,int id,int saleId){
  TextEditingController updateAdjust = TextEditingController();
  TextEditingController note = TextEditingController();
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<SalesVm>(
            builder: (context,value,_){
              return  SizedBox(
                height: sizeWidth(context).height*0.60,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                      children: [
                        accountCreate(context, "note", note),
                        const SizedBox(height: 8,),
                        accountNumber(context, "updateCom", updateAdjust),
                        const SizedBox(height: 8,),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:sizeWidth(context).width*0.4,
                                  child: ElevatedButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      style: elevatedButtonStyle(context),
                                      child: Text("back".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                  ),
                                ),
                                SizedBox(
                                  width:sizeWidth(context).width*0.4,
                                  child: ElevatedButton(
                                    //note eklenecek
                                      onPressed: ()async{
                                        if(updateAdjust.text.isNotEmpty){
                                          int adjust = int.parse(updateAdjust.text.split('.')[0]);
                                          PostAdjust post = PostAdjust(
                                              calcPoolSaleId:  id,
                                              adjustAmount: adjust,
                                              note: note.text
                                          );
                                          await viewModel.postComAdjust(context, post);
                                        }else{
                                          Navigator.pop(context);
                                          snackBarDesign(context, StringUtil.error, "requiredAdjust".tr());
                                        }
                                      },
                                      style: elevatedButtonStyle(context),
                                      child: Text("save".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]
                  ),
                ),
              );
            },
          ),
        );
      }
  );
}



showUpdateExtendDate(BuildContext context,CommissionVm viewModel,int poolId){
  TextEditingController extendDate = TextEditingController();
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<CommissionVm>(
            builder: (context,value,_){
              return  SizedBox(
                height: sizeWidth(context).height*0.60,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width:sizeWidth(context).width*0.4,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("back".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                              ),
                            ),
                            SizedBox(
                              width:sizeWidth(context).width*0.4,
                              child: ElevatedButton(
                                  onPressed: ()async{
                                    if(extendDate.text.isNotEmpty){
                                      extendDate.text = formatDateString(extendDate.text,"MM-dd-yyyy","yyyy-MM-dd");
                                      ComRateExtendDate post = ComRateExtendDate(
                                          calcPoolId:  poolId,
                                          calcExpireDate: extendDate.text
                                      );

                                      await viewModel.updateExtendDate(context,post);
                                      Navigator.pop(context);
                                    }else{
                                      Navigator.pop(context);
                                      snackBarDesign(context, StringUtil.error, "requiredAdjust".tr());
                                    }
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("update".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        TextField(
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                          cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          decoration: dateInputDecoration(context,"extendDate"),
                          controller: extendDate,
                          readOnly: true,
                          onTap: () async{
                            extendDate.text = await DatePickerHelper.getDatePicker(context);
                          },
                        ),

                      ]
                  ),
                ),
              );
            },
          ),
        );
      }
  );
}


showComAmountDetail(BuildContext context,SalesVm viewModel, model,int saleId){
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
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
                            width: sizeWidth(context).width * 0.30,
                            child: Text("calType".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Text(model.comType ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text(
                              "calculateDate".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Text(mmDDYDateTime(
                              model.commCalculatedAt ?? ""),
                              style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("adjustAmount".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Text("\$${model.commAdjustAmount ?? "0"}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: sizeWidth(context).width * 0.30, child:
                          Text("distPaid".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Text(model.isCommPaid == true ? "Yes" : "No", style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.error))),
                        ],
                      ),
                      const SizedBox(height: 4,),

                      if(model.isCommPaid == false)
                        SizedBox(
                          width:sizeWidth(context).width*0.80,
                          height:30,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                                showAdjustSale(context,viewModel,model.comSaleId!,saleId);
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("adjustCom".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                          ),
                        ),
                      if(model.isCommPaid ==true)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: sizeWidth(context).width*0.3,
                              child: Text("payDate".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                            Text(mmDDYDate(model.payAt ?? ""),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ],
                        ),
                      const Divider(thickness: 1,),
                      const SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text(model.eligibleRoleName ?? "",
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Text(model.userName ?? "",
                              style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("role".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Text(model.profileMenurole ?? "",
                              style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      if(model.eligibleRoleName !=null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("roleInSales".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Text(model.eligibleRoleName ?? "",
                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor))),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: sizeWidth(context).width * 0.30,
                            child: Text("enterSerialNumber".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Text(model.saleSerialNumber ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("organisation".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Text(model.organisationName ?? "",
                              style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                        ],
                      ),

                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(height: 4,),

                      if(model.isCommPaid == false)
                        Column(
                          children: [
                            SizedBox(
                              width:sizeWidth(context).width*0.80,
                              height:30,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                    areYouSurePay(context,viewModel,model.comSaleId!,saleId);

                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("payCommission".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                              ),
                            ),
                            const SizedBox(height: 4,),

                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
  );
}
showSalesBoardDetails(BuildContext context,SaleBoard saleBoard){
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
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
                            width: sizeWidth(context).width * 0.40,
                            child: Text("cName".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(saleBoard.cname ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              )
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.40,
                            child: Text("saleDate".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(mmDDYDate(saleBoard.date!.toString()), style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),
                        ],
                      ),

                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.40,
                            child: Text(
                              "phone".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          GestureDetector(
                            onTap: ()async{
                              if(saleBoard.cphone !=null){
                                openDialPad(saleBoard.cphone!);
                              }
                            },
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(saleBoard.cphone ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                            width: sizeWidth(context).width * 0.30,
                            child: Text("email".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(saleBoard.cemail ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("enterSerialNumber".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(saleBoard.serialid ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("paymentType".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(financeType(saleBoard.finance ?? 10), style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("address".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(saleBoard.caddress ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("state".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(saleBoard.cstate ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("zipCode".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(saleBoard.czipcode ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("netPrice".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("\$${saleBoard.netprice ?? "0.0"} ", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("tax".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("%${saleBoard.tax ?? "0.0"} ", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("totalCommission".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("\$${saleBoard.comision ?? "0.0"} ", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("daCom".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("\$${saleBoard.dacomision ?? "0.0"} ", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("dealerCom".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("\$${saleBoard.dealercomision ?? "0.0"} ", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("leaderCom".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("\$${saleBoard.leadercomision ?? "0.0"} ", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("smCom".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("\$${saleBoard.smcomision ?? "0.0"} ", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("distCom".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("\$${saleBoard.dpscomision ?? "0.0"} ", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                ],
                              ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
  );
}
showApptBoardDetails(BuildContext context,AppointmentBoard board){
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      shape: bottomSheetShape(context),
      constraints: BoxConstraints(
        maxWidth:  sizeWidth(context).width,
      ),
      builder: (context){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
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
                            width: sizeWidth(context).width * 0.40,
                            child: Text("cName".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("${board.cfirstname ?? ""} ${board.clastname ?? ""}", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.40,
                            child: Text(
                              "phone".tr(),
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          GestureDetector(
                            onTap: ()async{
                              if(board.cphone !=null){
                                openDialPad(board.cphone!);
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(board.cphone ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                              ],
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.20,
                            child: Text("email".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(board.cemail ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("address".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(board.caddress ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("zipCode".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(board.czipcode ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("state".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(board.cstate ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("organisation".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(board.orgname ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("leadType".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(board.leadtypename ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("apptStatus".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(statusCase(board.astatus ?? 15), style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.wizzColor))),
                            ],
                          ),

                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: sizeWidth(context).width * 0.30,
                            child: Text("dealerName".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(board.dealername ?? "", style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                            ],
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
  );
}

