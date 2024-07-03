import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminVm/adminHomeVm.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/providerFunc/AppStateNotifier.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../model/OLD/User.dart';

class AdminHome extends BaseStatefulPage {
  const AdminHome(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AdminHomeState();
}

class _AdminHomeState extends BaseStatefulPageState<AdminHome> {
  AdminHomeVm viewModel = AdminHomeVm();
  ScrollController controller = ScrollController();
  LoginUser? loginUser;
  User? user;
  int index=0;
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AppStateNotifier>(
        builder: (context,value,_){
          if(viewModel.detailsReportModel == null || viewModel.overrideUserList == null){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child:  Column(
                children: [
                  Text(loginUser!.profiles![index].orgname!, style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                  //area silver area gold
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        border: Border.all(color: ColorUtil().getColor(context,ColorEnums.wizzColor), width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  viewModel.reportValues(0, viewModel.detailsReportModel!);
                                },
                                child:Container(
                                  color:viewModel.currentDay=="lastMonth".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                          alignment: Alignment.center,
                                          child: Text("lastMonth".tr(), style: CustomTextStyle().bold10(AppColors.white)
                                          ),
                                        ),
                                  ),
                                  ),
                                ),

                              GestureDetector(
                                onTap: (){
                                  viewModel.reportValues(1, viewModel.detailsReportModel!);
                                },
                                child:  Container(
                                  color:viewModel.currentDay=="yesterday".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child:  Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                          alignment: Alignment.center,
                                          child: Text("yesterday".tr(), style: CustomTextStyle().bold10(AppColors.white)
                                          ),
                                        ),
                                  ),
                                  ),
                                ),

                              GestureDetector(
                                onTap: (){
                                  viewModel.reportValues(2, viewModel.detailsReportModel!);
                                },
                                child:  Container(
                                  color:viewModel.currentDay=="daily".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                          alignment: Alignment.center,
                                          child: Text("daily".tr(), style: CustomTextStyle().bold10(AppColors.white)
                                          ),
                                        ),
                                  ),
                                  ),
                                ),
                              GestureDetector(
                                onTap: (){
                                  viewModel.reportValues(3, viewModel.detailsReportModel!);
                                },
                                child:  Container(
                                  color:viewModel.currentDay=="weekly".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                          alignment: Alignment.center,
                                          child: Text("weekly".tr(), style:
                                           CustomTextStyle().bold10(AppColors.white)
                                          ),
                                        ),
                                  ),
                                  ),
                                ),

                              GestureDetector(
                                onTap: (){
                                  viewModel.reportValues(4, viewModel.detailsReportModel!);
                                },
                                child:  Container(
                                  color:viewModel.currentDay=="monthly".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                          alignment: Alignment.center,
                                          child: Text("monthly".tr(), style:
                                           CustomTextStyle().bold10(AppColors.white)
                                          ),
                                        ),
                                  ),
                                  ),
                                ),

                              GestureDetector(
                                onTap: (){
                                  viewModel.reportValues(5, viewModel.detailsReportModel!);
                                },
                                child:  Container(
                                  color:viewModel.currentDay=="annual".tr() ? AppColors.grey :Colors.transparent,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2,right: 2),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("annual".tr(), style:
                                         CustomTextStyle().bold10(AppColors.white)
                                        ),
                                      ),
                                  ),
                                ),
                                ),

                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: sizeWidth(context).width*0.20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("totalSale".tr(),style: CustomTextStyle().regular18(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    Text("${viewModel.totalSales}",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: sizeWidth(context).width*0.20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("demos".tr(),style: CustomTextStyle().regular18(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    Text("${viewModel.totalDemos}",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: sizeWidth(context).width*0.20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("leads".tr(),style: CustomTextStyle().regular18(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    Text("${viewModel.totalLeads}",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/${PageName.adminSalesTab}',arguments: {'type':"Sale"});
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 4,),
                                Image.asset("assets/adminSales.png", width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("sales".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.boardPage}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 4,),
                                Image.asset("assets/board.png", width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("board".tr(), textAlign: TextAlign.center, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/${PageName.adminCustomerSalesTab}',arguments: {'type':"Customer"});
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 4,),
                                Image.asset("assets/customer.png", width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("customer".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.myAppointment}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/adminAppointment.png", width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("appointments".tr(), textAlign: TextAlign.center, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/${PageName.commissionPage}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/commission.png", width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("commission".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),


                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.liveDemo}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/livedemo.png",  width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("liveDemo".tr(), textAlign: TextAlign.center, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/${PageName.adminDistStock}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/distStock.png",width: double.infinity,height:sizeWidth(context).height*0.05,),
                                Text("distributorStock".tr(),textAlign: TextAlign.center, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),

                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.myLeads}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/adminLeads.png", width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("leads".tr(), textAlign: TextAlign.center, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/${PageName.expense}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/spending.png", width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("expense".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.adminProgress}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/AdminProgress.png", width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("officeProgress".tr(), textAlign: TextAlign.center, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/${PageName.adminCarousel}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/carousel.png",width: double.infinity,height:sizeWidth(context).height*0.05,),
                                Text("addCarousel".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/${PageName.bonusPage}');
                        },
                        child: SizedBox(
                          width: sizeWidth(context).width * 0.4,
                          height: sizeWidth(context).height*0.11,
                          child: Card(
                            color: ColorUtil().getColor(context, ColorEnums.background),
                            elevation: 4,
                            shape: cardShape(context),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/stock.png",width: double.infinity,height: sizeWidth(context).height*0.05,),
                                Text("bonus".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                const SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),


                  const SizedBox(height: 8,),
                  Visibility(
                    visible: user!.roleType =="SUPERADMIN" ? true : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/${PageName.adminReport}');
                          },
                          child: SizedBox(
                            width: sizeWidth(context).width * 0.4,
                            height: sizeWidth(context).height*0.11,
                            child: Card(
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              elevation: 4,
                              shape: cardShape(context),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/reports.png", width: double.infinity,height: sizeWidth(context).height*0.05,),
                                  Text("reports".tr(), textAlign: TextAlign.center, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/${PageName.overridePage}');

                          },
                          child: SizedBox(
                            width: sizeWidth(context).width * 0.4,
                            height: sizeWidth(context).height*0.11,
                            child: Card(
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              elevation: 4,
                              shape: cardShape(context),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/standart.png",width: double.infinity,height: sizeWidth(context).height*0.05,),
                                  Text("manageOverride".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Visibility(
                    visible: user!.roleType =="SUPERADMIN" ? true : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                           GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/${PageName.stockManagement}');
                            },
                            child: SizedBox(
                              width: sizeWidth(context).width * 0.4,
                              height: sizeWidth(context).height*0.11,
                              child: Card(
                                color: ColorUtil().getColor(context, ColorEnums.background),
                                elevation: 4,
                                shape: cardShape(context),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/stock.png",width: double.infinity,height: sizeWidth(context).height*0.05,),
                                    Text("importerInventory".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                    const SizedBox(height: 4,),
                                  ],
                                ),
                              ),
                            ),
                          ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Visibility(
                    visible: user!.roleType =="SUPERADMIN" ? false : true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/${PageName.setWarehouses}');
                          },
                          child: SizedBox(
                            width: sizeWidth(context).width * 0.4,
                            height: sizeWidth(context).height*0.11,
                            child: Card(
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              elevation: 4,
                              shape: cardShape(context),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/stock.png",width: double.infinity,height: sizeWidth(context).height*0.05,),
                                  Text("setWarehouses".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: viewModel.check==true ? true : false,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/${PageName.overrideReportDist}');
                            },
                            child: SizedBox(
                              width: sizeWidth(context).width * 0.4,
                              height: sizeWidth(context).height*0.11,
                              child: Card(
                                color: ColorUtil().getColor(context, ColorEnums.background),
                                elevation: 4,
                                shape: cardShape(context),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/standart.png",width: double.infinity,height: sizeWidth(context).height*0.05,),
                                    Text("overrideDetails".tr(),textAlign: TextAlign.center, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                    const SizedBox(height: 4,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                ],
              ),
            );
          }
        },
      )
    );
  }
  Future<void>getList() async{
    SharedPref pref = SharedPref();
    index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    user ??= await getUserUser(context);
    await viewModel.getOverrideUser(context);
    await viewModel.detailReport(context, loginUser!.profiles![index].id!, loginUser!.profiles![index].organisation_id!);
    
    List<int> loginId =[];
    for(int i=0;i<loginUser!.profiles!.length;i++){
      loginId.add(loginUser!.profiles![i].userId!);
    }
    await viewModel.checkOverrideUser(context,loginId);
  }
}
