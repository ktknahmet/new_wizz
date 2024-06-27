import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/MyAppointmentVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../../constants/ColorsUtil.dart';
import '../../../model/appointmentModel/Data.dart';

class DemoAppointment extends StatefulWidget {
  const DemoAppointment({super.key});

  @override
  State<DemoAppointment> createState() => _DemoAppointmentState();
}

class _DemoAppointmentState extends State<DemoAppointment> {
  MyAppointmentVm viewModel = MyAppointmentVm();
  ScrollController controller = ScrollController();
  late GoogleMapController mapController;
  List<Data> appointment =[];
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
      child: Consumer<MyAppointmentVm>(
        builder: (context,value,_){
          if(viewModel.allAppointment ==null){
            return spinKit(context);
          }else{
            return Column(
              children: [
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
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: getList,
                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                  child: SizedBox(
                    height:sizeWidth(context).height*0.40,
                    child: RawScrollbar(
                      thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                      thumbVisibility: true,
                      thickness: 1,
                      trackVisibility: true,
                      controller: controller,
                      child: ListView.builder(
                        itemCount: appointment.length,
                        controller: controller,
                        itemBuilder: (context,index){
                          Data item = appointment[index];
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
                                        Text("cName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text("${item.cfirstname ?? ""} ${item.clastname ?? ""}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("phone".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.cphone ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("email".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.cemail ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("address".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.caddress ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("state".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.cstate ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("city".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.ccity ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("appointmentDate".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(mmDDYDate(item.appointmentdate ?? ""),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("appointmentTime".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        Text(item.appointmenttime ?? "",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
  Future<void> getList()async{
    await viewModel.getAllAppointment(context);
    if(appointment.isNotEmpty){
      appointment.clear();
    }
    String today = formatDate(DateTime.now().toIso8601String());


    for(int i=0;i<viewModel.allAppointment!.length;i++){
      if(viewModel.allAppointment![i].adate1! == today && isWithinHours(viewModel.allAppointment![i].adate2!)){
        appointment.add(viewModel.allAppointment![i]);
      }
    }
  }
}
