import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/demoModel/postLiveDemo.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/providerFunc/LocationProvider.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/AddAppBar.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/setAppointment/editAppointment.dart';
import 'package:wizzsales/viewModel/MyAppointmentVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../constants/AppColors.dart';
import '../../model/appointmentModel/Data.dart';
import '../../utils/res/SharedUtils.dart';
// ignore_for_file: use_build_context_synchronously

class MyAppointment extends StatefulWidget {
  const MyAppointment( {super.key});

  @override
  State<StatefulWidget> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  LoginUser? loginUser;
  MyAppointmentVm viewModel = MyAppointmentVm();
  ScrollController controller = ScrollController();
  LocationProvider provider = LocationProvider();


  @override
  void initState() {
    allAppointment();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: AddAppBar(
        name: "myAppointment".tr(),
        func: () async {
          Navigator.pushNamed(context, '/${PageName.leadsAppointment}');
        },
      ),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<MyAppointmentVm>(
            builder: (context,value,_){
              if(viewModel.allAppointment == null){
                return spinKit(context);
              }else{
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (viewModel.detailsReportModel == null) spinKit(context)
                        else   Container(
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
                                    SizedBox(
                                      child:  Padding(
                                        padding: const EdgeInsets.only(left: 2,right: 2),
                                        child: Column(
                                          children: [
                                            Text("yesterday".tr(), style: CustomTextStyle().bold10(AppColors.white)),
                                            Text(viewModel.yesterdayApt.toString(), style: CustomTextStyle().bold10(AppColors.white)),

                                          ],
                                        )
                                      ),
                                    ),
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2,right: 2),
                                        child: Column(
                                          children: [
                                            Text("daily".tr(), style: CustomTextStyle().bold10(AppColors.white)),
                                            Text(viewModel.todayApt.toString(), style: CustomTextStyle().bold10(AppColors.white)),

                                          ],
                                        )
                                      ),
                                    ),
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2,right: 2),
                                        child: Column(
                                          children: [
                                            Text("weekly".tr(), style: CustomTextStyle().bold10(AppColors.white)),
                                            Text(viewModel.weekApt.toString(), style: CustomTextStyle().bold10(AppColors.white)),

                                          ],
                                        )
                                      ),
                                    ),
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2,right: 2),
                                        child: Column(
                                          children: [
                                            Text("monthly".tr(), style: CustomTextStyle().bold10(AppColors.white)),
                                            Text(viewModel.monthApt.toString(), style: CustomTextStyle().bold10(AppColors.white)),

                                          ],
                                        )
                                      ),
                                    ),
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2,right: 2),
                                        child: Column(
                                          children: [
                                            Text("annual".tr(), style: CustomTextStyle().bold10(AppColors.white)),
                                            Text(viewModel.yearApt.toString(), style: CustomTextStyle().bold10(AppColors.white)),

                                          ],
                                        )
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 8,),
                        Container(
                          height: 40,
                          decoration: containerDecoration(context),
                          width: sizeWidth(context).width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                              underline: const SizedBox(),
                              hint:Text(viewModel.leadType,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                              value: viewModel.leadType,
                              onChanged: (newValue) async{
                                viewModel.setLeadType(newValue!);
                                viewModel.setQuery(newValue);
                                viewModel.searchAppointment(viewModel.allAppointment!,viewModel.query);
                              },
                              items: viewModel.chooseLead.keys.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,

                                  child: Row(
                                    children: [
                                      Text(value,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:40,
                                width: sizeWidth(context).width*0.60,
                                child: TextField(
                                  onChanged: (value) {
                                    viewModel.setQuery(value);

                                    viewModel.searchAppointment(viewModel.allAppointment!,viewModel.query);
                                  },
                                  decoration: searchTextDesign(context, "search"),
                                  cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                                ),
                              ),
                              const SizedBox(width: 16,),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, '/${PageName.appointmentReport}');
                                    },
                                    style: elevatedButtonStyle(context),
                                    child: Text("report".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                              ),
                            ],
                          ),
                        ),
                        RefreshIndicator(
                          onRefresh:allAppointment,
                          color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          child: SizedBox(
                            height: justList(context, sizeWidth(context).height),
                            child: RawScrollbar(
                              thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                              thumbVisibility: true,
                              thickness: 1,
                              trackVisibility: true,
                              controller: controller,
                              child: ListView.builder(
                                controller: controller,
                                itemCount: viewModel.searchAppointment(viewModel.allAppointment!,viewModel.query).length,
                                itemBuilder: (context,index){
                                  Data item = viewModel.searchAppointment(viewModel.allAppointment!,viewModel.query)[index];
                                  int startIndex = (viewModel.searchAppointment(viewModel.allAppointment!,viewModel.query).length == 1) ? 1 : viewModel.searchAppointment(viewModel.allAppointment!,viewModel.query).length;
                                  List<int> indices = List.generate(viewModel.searchAppointment(viewModel.allAppointment!,viewModel.query).length, (index) => startIndex - index);
                                  return Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text("${indices[index]}",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("date".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(mmDDYDate(item.appointmentdate ?? ""),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("time".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.appointmenttime ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("cName".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.cname ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("address".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.caddress ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("cPhone".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.cphone ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("email".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.cemail ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("city".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.ccity ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("state".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.cstate ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("zipCode".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.czipcode ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          if(item.referredby!.isNotEmpty)
                                          Column(
                                            children: [
                                              const SizedBox(height: 8,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                      width:sizeWidth(context).width*0.30,
                                                      child: Text("referredBy".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                                  Expanded(child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(item.referredby ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ],
                                          ),


                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("distributor".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.orgname ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),

                                          if(item.dealername !=null)
                                            Column(
                                              children: [
                                                const SizedBox(height: 8,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width:sizeWidth(context).width*0.30,
                                                        child: Text("dealerRunBy".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                                    Expanded(child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(item.dealername ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("leadType".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.leadtypename ?? "",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:sizeWidth(context).width*0.30,
                                                  child: Text("status".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(statusCase(item.astatus!),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ))
                                            ],
                                          ),
                                          if(item.answers !=null)
                                            Column(
                                              children: [
                                               SizedBox(
                                                 height:sizeWidth(context).height*0.1,
                                                 child: ListView.builder(
                                                   itemCount: item.answers!.length,
                                                   itemBuilder: (context,index){
                                                     return Row(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         Text(item.answers![index].question!.question ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                         Text(item.answers![index].answer ,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                                       ],
                                                     );
                                                   },
                                                 ),
                                               )
                                              ],
                                            ),

                                          if(item.astatus! !=6 && item.astatus! !=8)
                                            Column(
                                              children: [
                                                const SizedBox(height: 4,),
                                                Divider(
                                                  thickness: 1,
                                                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                ),
                                                GestureDetector(
                                                  onTap: ()async{
                                                    await startDemo(index);

                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                          width:sizeWidth(context).width*0.30,
                                                          child: Text("startDemo".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.wizzColor)),)),
                                                      Expanded(child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Icon(Icons.arrow_forward,color: ColorUtil().getColor(context, ColorEnums.wizzColor),)
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 4,),
                                                Divider(
                                                  thickness: 1,
                                                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (_) => EditAppointment(item)));

                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                          width:sizeWidth(context).width*0.30,
                                                          child: Text("edit".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.wizzColor)),)),
                                                      Expanded(child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Icon(Icons.arrow_forward,color: ColorUtil().getColor(context, ColorEnums.wizzColor),)
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 4,),
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
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  Future<void> allAppointment()async{
    SharedPref pref = SharedPref();
    await viewModel.getAllAppointment(context);
    int index = await pref.getInt(context, SharedUtils.profileIndex);
    loginUser ??= await getUser(context);
    await viewModel.detailReport(context, loginUser!.profiles![index].id!, loginUser!.profiles![index].organisation_id!);

    viewModel.appointmentTotalValue(viewModel.detailsReportModel!);
    viewModel.chooseLead["All"]=-1;
    for(int i =0;i<viewModel.allAppointment!.length;i++){
      String status = statusCase(viewModel.allAppointment![i].astatus!).toString();
      viewModel.chooseLead[status] = viewModel.allAppointment![i].astatus!;
    }
  }
  startDemo(int index)async{
    SharedPref pref = SharedPref();
    int orgId = await pref.getInt(context, SharedUtils.orgId);
    double? latitude;
    double? longitude;
    String? zipCode;

    await provider.getLocationDetails(context);
    latitude = provider.locationDetails["latitude"];
    longitude = provider.locationDetails["longitude"];
    zipCode = provider.locationDetails["zipcode"];


    Data item = viewModel.searchAppointment(viewModel.allAppointment!,viewModel.query)[index];
    print("zipkodlar :$zipCode -- ${item.czipcode}");
    if(zipCode == item.czipcode!){
      PostLiveDemo postLiveDemo = PostLiveDemo(
          organisationId: orgId,
          demoCustomerName: item.cfirstname,
          demoCustomerSurname: item.clastname,
          demoCustomerPhone: item.cphone,
          demoCustomerEmail: item.cemail,
          demoAddress: item.caddress,
          demoRegion: "",
          longitude: longitude,
          latitude: latitude,
          demoCity: item.ccity,
          demoZipcode: item.czipcode,
          demoCounty: item.ccounty,
          demoState: item.cstate,
          demoCountry: item.ccountry
      );
      await viewModel.postStartDemo(context, postLiveDemo);
    }else{
      snackBarDesign(context, StringUtil.error, "wrongZipCode".tr());
    }
  }
}
