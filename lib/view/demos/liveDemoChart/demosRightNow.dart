import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/model/demoModel/liveDemoList.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/LiveDemoVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../../constants/colorsUtil.dart';

class DemosRightNow extends StatefulWidget {
  const DemosRightNow({super.key});

  @override
  State<DemosRightNow> createState() => _DemosRightNowState();
}

class _DemosRightNowState extends State<DemosRightNow> {
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
                                            width:sizeWidth(context).width*0.40,
                                            child: Text("cName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
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
                                            child: Text("demoDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(mmDDYDate(item.demoStartTime.toString()),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 2,),
                                    Divider(
                                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    ),
                                    const SizedBox(height: 2,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("demoStatus".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.status!,style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.wizzColor)),)
                                      ],
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
    //ikonlar yanıp sönecek


    final Uint8List markerIcon = await getBytesFromAsset('assets/app.png', 150);
    if(demoList.isNotEmpty){
      demoList.clear();
    }
    await viewModel.getLiveDemoList(context);
    if(viewModel.liveDemoList !=null){
      for(int i=0;i<viewModel.liveDemoList!.length;i++){
        if(viewModel.liveDemoList![i].status == "Active"){
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
                snackBarDesign(context, StringUtil.success, findTimeDifference(demo.demoStartTime));
              }
          ),
        );
      }
    }
  }
}
