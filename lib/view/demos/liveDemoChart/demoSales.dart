import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/demoModel/liveDemoList.dart';
import 'package:wizzsales/model/quickSaleModel/quickSaleModel.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/LiveDemoVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';


class DemoSales extends StatefulWidget {
  const DemoSales({super.key});

  @override
  State<DemoSales> createState() => _DemoSalesState();
}

class _DemoSalesState extends State<DemoSales> {
  LiveDemoVm viewModel = LiveDemoVm();
  ScrollController controller = ScrollController();
  late GoogleMapController mapController;
  List<LiveDemoList> demoList=[];
  Set<Marker> markers = <Marker>{};
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
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<LiveDemoVm>(
        builder: (context,value,_){
          if(viewModel.liveDemoList ==null){
            return spinKit(context);
          }else{
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8,top: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Total : ${demoList.length}",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                ),

                   SizedBox(
                     height: sizeWidth(context).height*0.30,
                     child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GoogleMap(
                            onMapCreated: (controller) {
                              setState(() {
                                mapController = controller;
                              });
                            },
                            initialCameraPosition: const CameraPosition(
                              target: LatLng(42.3967237, -105.236424),
                              zoom: 3.5,
                            ),
                            markers: markers
                        ),
                      ),
                   ),
                demoList.isEmpty ? emptyView(context, "thereIsNoDemo") :
                RefreshIndicator(
                  onRefresh: getList,
                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                  child: SizedBox(
                    height: sizeWidth(context).height*0.40,
                    child: RawScrollbar(
                      thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                      thumbVisibility: true,
                      thickness: 1,
                      trackVisibility: true,
                      controller: controller,
                      child: ListView.builder(
                        itemCount: demoList.length,
                        controller: controller,
                        itemBuilder: (context,index){
                          LiveDemoList item = demoList[index];
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
                                            child: Text("dealer".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.user![0].name ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        SizedBox(
                                            width:sizeWidth(context).width*0.30,
                                            child: Text(item.status=="Demo Completed" ? "prospectCustomer".tr() :"cName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text("${item.demoCustomerName ?? ""} ${item.demoCustomerSurname ?? ""}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    if(item.demoCustomerPhone !=null)
                                    Column(
                                      children: [
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.40,
                                                child: Text("phone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.demoCustomerPhone ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    if(item.demoCustomerEmail !=null)
                                    Column(
                                      children: [
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width:sizeWidth(context).width*0.30,
                                                child: Text("email".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.demoCustomerEmail ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:sizeWidth(context).width*0.30,
                                            child: Text("address".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.demoAddress ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                            child: Text("zipCode".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.demoZipcode ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                            child: Text("state".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(item.demoState ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                                              Text(mmDDYDate(item.demoEndTime.toString()),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("demoStatus".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.status!,style: demoStatusStyle(context,item.status!)),
                                      ],
                                    ),
                                    const SizedBox(height: 2,),
                                    Divider(
                                      color: demoDivider(context,item.status!),
                                    ),
                                    Visibility(
                                      visible: item.status=="Demo Completed" ? true :false,
                                      child: SizedBox(
                                        width:sizeWidth(context).width*0.80,
                                        child: ElevatedButton(
                                            onPressed: ()async{
                                              await registerSale(item.demoLiveId!,index);

                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("registerAddSale".tr(),style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                        ),
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
                ),

              ],
            );
          }
        },
      ),
    );
  }
  Future<void>getList() async{
    //ikon yeşil olacak
    final Uint8List markerIcon = await getBytesFromAsset('assets/app.png', 150);
    if(demoList.isNotEmpty){
      demoList.clear();
    }
    await viewModel.getLiveDemoList(context);
    if(viewModel.liveDemoList !=null){
      for(int i=0;i<viewModel.liveDemoList!.length;i++){
        if(viewModel.liveDemoList![i].status =="Sold/Registered" || viewModel.liveDemoList![i].status =="Demo Completed") {
          demoList.add(viewModel.liveDemoList![i]);
        }
      }
      for (var i = 0; i < demoList.length; i++) {
        var demo = demoList[i];
        markers.add(
          Marker(
              icon: BitmapDescriptor.fromBytes(markerIcon),
              markerId: MarkerId(demo.demoLiveId.toString()),
              position: LatLng(double.parse(demo.latitude!), double.parse(demo.longitude!)),
              infoWindow: InfoWindow(
                title: demo.demoCustomerName!,
                snippet: demo.demoCustomerPhone ?? "",
              ),
              onTap: (){

                //overlayNotification(context, "Demo time", findTimeDifference(demo.demoStartTime));
              }
          ),
        );
      }
    }

  }
  registerSale(int id,int index)async{
    Map<String, dynamic> phoneType = {};
    phoneType = smashPhoneNumber(demoList[index].demoCustomerPhone ?? "");
    QuickSaleModel model = QuickSaleModel(
      id,
      demoList[index].demoCustomerName,
      demoList[index].demoCustomerName,
      demoList[index].demoCustomerSurname,
      "${phoneType["cCode"]}${phoneType["phone"]}",
      demoList[index].demoCustomerEmail,
      phoneType["cCode"],
      demoList[index].demoAddress,
      demoList[index].demoCounty,
      demoList[index].demoCountry,
      demoList[index].demoState,
      demoList[index].demoCity,
      demoList[index].demoZipcode,
      demoList[index].leadType!.leadtypeid

    );
    Navigator.pushNamed(context, '/${PageName.quickAddSale}',arguments: {'quick':model,'demoId':id});
  }
}
