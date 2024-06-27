// ignore_for_file: use_build_context_synchronously
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/leadReportModel/demoLeadReportModel.dart';
import 'package:wizzsales/model/leadReportModel/leadReportModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/resources/resourceTabBar.dart';
import 'package:wizzsales/viewModel/HomeVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class Home extends BaseStatefulPage {
  const Home(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends BaseStatefulPageState<Home> {
  HomeVm viewModel = HomeVm();

  LoginUser? loginUser;
  int value=0;
  int index=0;
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
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<HomeVm>(
        builder: (context,value,_){
          if(viewModel.detailsReportModel ==null){
            return spinKit(context);
          }else{
            return RefreshIndicator(
              onRefresh: getList,
              color: ColorUtil().getColor(context, ColorEnums.wizzColor),
              child: SingleChildScrollView(
                child: Column(

                  children: [
                    Text("${dayTime()},${loginUser!.name}!",style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    const SizedBox(height: 4,),
                    Text(
                      loginUser!.profiles![index].orgname ?? "",
                      style: CustomTextStyle().bold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight)),
                    ),
                    const SizedBox(height: 4,),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            loginUser!.profiles![index].salesrolename!.toUpperCase(),
                            style: CustomTextStyle().bold12(ColorUtil().getColor(context,ColorEnums.textDefaultLight)),
                          ),

                          VerticalDivider(
                            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            thickness: 1,
                          ),

                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: loginUser!.profiles![index].ranking == null ? 0.0 :
                            loginUser!.profiles![index].ranking!.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            unratedColor: ColorUtil().getColor(context, ColorEnums.appColor),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            ),
                            onRatingUpdate: (rating) {

                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4,),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: sizeWidth(context).width*0.30,
                            height: 43,
                            decoration: decorationTransparent(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: emptyDecoration(context),
                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                controller: viewModel.daySelect,
                                readOnly: true,
                                onTap: (){
                                  selectGraphReport(context,viewModel);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8,),
                          SizedBox(
                            height: 42,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/${PageName.liveDemo}');
                              },
                              style: buttonStyle(context),
                              child: Text("liveDemo".tr(),style:CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                          ),
                        ],
                      ),
                     const SizedBox(height: 8,),

                     Padding(
                       padding: const EdgeInsets.only(bottom: 8),
                       child: Container(
                          color: ColorUtil().getColor(context, ColorEnums.graphColor),
                          child: viewModel.reportName =="totalSale".tr() ?
                          FadeInUp(
                            duration: const Duration(seconds:2),
                            delay:const Duration(seconds:1),
                            child: SizedBox(
                              height: viewModel.reportTotalSaleValue(viewModel.reportIndex,viewModel.detailsReportModel!).length * 25+sizeWidth(context).height*0.3,

                              child: SfCartesianChart(

                                plotAreaBorderColor: ColorUtil().getColor(context, ColorEnums.transparant),
                                isTransposed: true,
                                tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                    textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                                    color: ColorUtil().getColor(context, ColorEnums.wizzColor)
                                ),
                                legend: Legend(
                                    textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textTitleLight)),
                                    isVisible: true,
                                    iconWidth: 8,
                                    isResponsive:true,
                                    alignment: ChartAlignment.near
                                ),
                                series : [
                                  LineSeries<LeadReportModel, dynamic>(
                                    opacity: 0.8,
                                    width: 0.8,
                                    markerSettings: const MarkerSettings(
                                      isVisible: true,
                                      width: 10,
                                      shape: DataMarkerType.diamond
                                    ),
                                    color: ColorUtil().getColor(context,ColorEnums.wizzColor),
                                    enableTooltip: true,
                                    name: "mySales".tr(),
                                    dataSource: viewModel.reportTotalSaleValue(viewModel.reportIndex,viewModel.detailsReportModel!),
                                    xValueMapper: (LeadReportModel data,_) => data.time,
                                    yValueMapper: (LeadReportModel data,_) => data.value,
                                    dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        textStyle: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight))
                                    ),
                                    //dashArray: const [2,8], //çizgi uzunluğu , aralarındaki boşluk
                                  ),
                                ],
                                primaryXAxis: CategoryAxis(

                                  isVisible: true,
                                  //labelRotation: -45,
                                  majorGridLines: const MajorGridLines(width: 0.2),
                                  labelStyle:CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                ),
                                primaryYAxis: NumericAxis(
                                  // Y ekseni ayarları...
                                  majorGridLines: const MajorGridLines(width: 0),
                                  labelStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                  interval: 1,
                                ),

                              ),
                            )
                          ):viewModel.reportName =="demos".tr() ?
                          ZoomIn(
                            duration: const Duration(seconds:3),
                            delay:const Duration(seconds:1),
                            child: SfCartesianChart(
                              plotAreaBorderColor: ColorUtil().getColor(context, ColorEnums.transparant),
                              isTransposed: true,
                              tooltipBehavior: TooltipBehavior(
                                  enable: true,
                                  textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                                  color: ColorUtil().getColor(context, ColorEnums.wizzColor)
                              ),
                              legend: Legend(
                                  textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textTitleLight)),
                                  isVisible: true,
                                  iconWidth: 8,
                                  isResponsive:true,
                                  alignment: ChartAlignment.near
                              ),
                              series:[
                                BarSeries<DemoLeadReportModel,String>(
                                  width: 0.1,
                                  color: ColorUtil().getColor(context,ColorEnums.wizzColor),
                                  enableTooltip: true,
                                  name: "demos".tr(),
                                  dataSource: viewModel.reportTotalAppointmentValues(viewModel.reportIndex,viewModel.detailsReportModel!),
                                  xValueMapper: (DemoLeadReportModel data,_) => data.name.tr(),
                                  yValueMapper: (DemoLeadReportModel data,_) => data.value,
                                  dataLabelSettings: DataLabelSettings(
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      isVisible: true,
                                      textStyle: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight))
                                  ),
                                ),

                              ],
                              primaryXAxis: CategoryAxis(

                                isVisible: true,
                                labelRotation: -45,
                                majorGridLines: const MajorGridLines(width: 0.2),
                                labelStyle:CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                              ),
                              primaryYAxis: NumericAxis(
                                // Y ekseni ayarları...
                                majorGridLines: const MajorGridLines(width: 0),
                                labelStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                interval: 1,
                              ),
                            ),
                          ):
                        BounceInLeft(
                          duration: const Duration(seconds:3),
                          delay:const Duration(seconds:1),
                          child: SfCartesianChart(
                            plotAreaBorderColor: ColorUtil().getColor(context, ColorEnums.transparant),
                            isTransposed: true,
                            tooltipBehavior: TooltipBehavior(
                                enable: true,
                                textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                                color: ColorUtil().getColor(context, ColorEnums.wizzColor)
                            ),
                            legend: Legend(
                                textStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textTitleLight)),
                                isVisible: true,
                                iconWidth: 8,
                                isResponsive:true,
                                alignment: ChartAlignment.near
                            ),
                            series : [
                              BarSeries<DemoLeadReportModel, dynamic>(
                                width: 0.2,
                                color: ColorUtil().getColor(context,ColorEnums.wizzColor),
                                enableTooltip: true,
                                name: "leads".tr(),
                                dataSource: viewModel.reportTotalLeadValues(viewModel.reportIndex,viewModel.detailsReportModel!),
                                xValueMapper: (DemoLeadReportModel data,_) => data.name.tr(),
                                yValueMapper: (DemoLeadReportModel data,_) => data.value,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight))
                                ),
                              ),
                            ],
                            primaryXAxis: CategoryAxis(
                              isVisible: true,
                              labelRotation: -45,
                              majorGridLines: const MajorGridLines(width: 0.2),
                              labelStyle:CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            ),
                            primaryYAxis: NumericAxis(
                              // Y ekseni ayarları...
                              majorGridLines: const MajorGridLines(width: 0),
                              labelStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                              interval: 1,
                            ),

                          )
                        )

                          ),
                     ),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               GestureDetector(
                                   onTap: (){
                                     viewModel.setReportName(0);
                                   },
                                   child: Container(
                                     width: sizeWidth(context).width*0.25,
                                     height: 40,
                                     decoration: viewModel.reportName=="totalSale".tr() ? containerWhiteDecoration(context) : containerDecoration(context),
                                     child: Column(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("totalSale".tr(), style:
                                           viewModel.reportName=="totalSale".tr() ?
                                           CustomTextStyle().bold10(AppColors.white):
                                           CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                           ),
                                           Text("${viewModel.totalSales}", style:
                                           viewModel.reportName=="totalSale".tr() ?
                                           CustomTextStyle().semiBold10(AppColors.white):
                                           CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                           ),

                                         ],
                                       ),
                                   ),
                                   ),

                               GestureDetector(
                                 onTap: (){
                                   viewModel.setReportName(1);
                                 },
                                 child: Container(
                                   width: sizeWidth(context).width*0.35,
                                   height: 40,
                                   decoration: viewModel.reportName=="demos".tr() ? containerWhiteDecoration(context) : containerDecoration(context),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("demos".tr(), style:
                                       viewModel.reportName=="demos".tr() ?
                                       CustomTextStyle().bold10(AppColors.white):
                                       CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                       ),
                                       Text("${viewModel.totalAppointment}", style:
                                       viewModel.reportName=="demos".tr() ?
                                       CustomTextStyle().semiBold10(AppColors.white):
                                       CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                       ),

                                     ],
                                   ),
                                 ),
                               ),
                               GestureDetector(
                                 onTap: (){
                                   viewModel.setReportName(2);
                                 },
                                 child: Container(
                                   width: sizeWidth(context).width*0.25,
                                   height: 40,
                                   decoration: viewModel.reportName=="leads".tr() ? containerWhiteDecoration(context) : containerDecoration(context),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("leads".tr(), style:
                                       viewModel.reportName=="leads".tr() ?
                                       CustomTextStyle().bold10(AppColors.white):
                                       CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                       ),
                                       Text("${viewModel.totalLeads}", style:
                                       viewModel.reportName=="leads".tr() ?
                                       CustomTextStyle().semiBold10(AppColors.white):
                                       CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                       ),

                                     ],
                                   ),
                                 ),
                               ),

                             ],
                           ),
                          const SizedBox(height: 8,),
                          viewModel.getSlider == null ?
                              spinKit(context)
                          : Visibility(
                            visible: viewModel.getSlider!.isNotEmpty ? true:false,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: sizeWidth(context).width,
                                  height: autoHeightSlider(context, sizeWidth(context).height),
                                  child:  CarouselSlider.builder(
                                    itemCount: viewModel.getSlider!.length,
                                    options: CarouselOptions(
                                        viewportFraction:0.9,
                                        initialPage: 0,
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        autoPlayInterval: const Duration(seconds: 8),
                                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                                        onPageChanged: (index, reason) {

                                        }),
                                    itemBuilder: (context, index, realIndex) {
                                      return  Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: sizeWidth(context).width * 0.70,
                                            height: sizeWidth(context).height * 0.15,
                                            child: GestureDetector(
                                                onTap: () {
                                                  sliderClick(context,viewModel.getSlider![index].sliderViewName!,viewModel.getSlider![index].sliderType!,viewModel.getSlider![index].onClick!);
                                                },
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: 'assets/loading.gif',
                                                  image: viewModel.getSlider![index].filePath!,
                                                  fit: BoxFit.cover,)
                                            ),
                                          ),
                                          Text(viewModel.getSlider![index].sliderViewName!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                        ],
                                      );
                                    },
                                  ),


                                ),
                              ],
                            ),
                          ),

                           Stack(
                               children: [
                                 Image.asset("assets/homePhoto.png",
                                   opacity: const AlwaysStoppedAnimation(.8),
                                   fit: BoxFit.cover,
                                   height: autoHeight(context,sizeWidth(context).height),
                                   width: sizeWidth(context).width,),
                                   Padding(
                                     padding: const EdgeInsets.all(16),
                                     child: Column(
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               GestureDetector(
                                                 onTap: (){
                                                   Navigator.pushNamed(context, '/${PageName.contests}');
                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child: Card(
                                                     elevation:2,
                                                     shape: homeCard(context),
                                                     child: Container(
                                                       decoration: mainDecoration(context),
                                                       child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Image.asset("assets/contest.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                           Text("myContests".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                           const SizedBox(height: 2,),
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                               GestureDetector(
                                                 onTap: () {
                                                   Navigator.pushNamed(context, '/${PageName.mySaleTabBar}',arguments: {'index':0});
                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child:  Card(
                                                       elevation:2,
                                                       shape: homeCard(context),
                                                       child: Container(
                                                         decoration: mainDecoration(context),
                                                         child: Column(
                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                           children: [
                                                             Image.asset("assets/sales.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                             Text("mySales".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                             const SizedBox(height: 4,),
                                                           ],
                                                         ),
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
                                                 onTap: ()async{
                                                   await viewModel.getTypeResource(context, "demoBooks".tr());
                                                   if(viewModel.resourcesList.length ==1 && viewModel.resourcesList.isNotEmpty){
                                                     Navigator.pushNamed(context, '/${PageName.pdfPage}', arguments: {'title': viewModel.allResourcesLists["demoBooks".tr()]![0].title ,
                                                       'url': viewModel.allResourcesLists["demoBooks".tr()]![0].file},);

                                                   }else{
                                                     if(viewModel.names.isNotEmpty){
                                                       Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceTabBar(viewModel.names[0], viewModel.allResourcesLists[viewModel.names[0]])));
                                                     }else{
                                                       snackBarDesign(context, StringUtil.error, "errorCreated".tr());
                                                     }
                                                   }

                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child: Card(

                                                       elevation:2,
                                                       shape: homeCard(context),
                                                       child: Container(
                                                         decoration: mainDecoration(context),
                                                         child: Column(
                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                           children: [
                                                             Image.asset("assets/demo.png", width: double.infinity,height: sizeWidth(context).height*0.12),
                                                             Text("demoBook".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                             const SizedBox(height: 4,),
                                                           ],
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                 ),


                                               GestureDetector(
                                                 onTap: ()async{
                                                   await viewModel.getTypeResource(context,"Training Materials");
                                                   if(viewModel.names.isNotEmpty){
                                                     Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceTabBar(viewModel.names[0], viewModel.allResourcesLists[viewModel.names[0]])));
                                                   }else{
                                                     snackBarDesign(context, StringUtil.error, "errorCreated".tr());
                                                   }
                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child: Card(
                                                     elevation:2,
                                                     shape: homeCard(context),
                                                     child: Container(
                                                       decoration: mainDecoration(context),
                                                       child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Image.asset("assets/resources.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                           Text("trainingResources".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                           const SizedBox(height: 4,),
                                                         ],
                                                       ),
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
                                                 onTap: () async{
                                                   await viewModel.getTypeResource(context, "certificates".tr());
                                                     if(viewModel.names.isNotEmpty){

                                                       Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceTabBar(viewModel.names[0], viewModel.allResourcesLists[viewModel.names[0]])));
                                                     }else{
                                                       snackBarDesign(context, StringUtil.error, "errorCreated".tr());
                                                     }

                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child: Card(
                                                     elevation:2,
                                                     shape: homeCard(context),
                                                     child: Container(
                                                       decoration: mainDecoration(context),
                                                       child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Image.asset("assets/certificate.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                           Text("certificates".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                           const SizedBox(height: 4,),
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                               GestureDetector(
                                                 onTap: () async{
                                                   await viewModel.getTypeResource(context, "salesClinchers".tr());
                                                   if(viewModel.resourcesList.length ==1 && viewModel.resourcesList.isNotEmpty){
                                                     Navigator.pushNamed(context, '/${PageName.pdfPage}', arguments: {'title': viewModel.allResourcesLists["salesClinchers".tr()]![0].title ,
                                                       'url': viewModel.allResourcesLists["salesClinchers".tr()]![0].file},);

                                                   }else{
                                                     if(viewModel.names.isNotEmpty){
                                                       Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceTabBar(viewModel.names[0], viewModel.allResourcesLists[viewModel.names[0]])));
                                                     }else{
                                                       snackBarDesign(context, StringUtil.error, "errorCreated".tr());
                                                     }
                                                   }
                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child: Card(
                                                     elevation:2,
                                                     shape: homeCard(context),
                                                     child: Container(
                                                       decoration: mainDecoration(context),
                                                       child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Image.asset("assets/clinchers.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                           Text("salesClinchers".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                           const SizedBox(height: 4,),
                                                         ],
                                                       ),
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
                                            onTap: () {
                                              Navigator.pushNamed(context, '/${PageName.dealerStockList}');
                                            },
                                            child: SizedBox(
                                              width: sizeWidth(context).width*0.4,
                                              height: sizeWidth(context).height*0.17,
                                              child: Card(
                                                elevation:2,
                                                shape: homeCard(context),
                                                child: Container(
                                                  decoration: mainDecoration(context),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Image.asset("assets/inventory.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                      Text("assignList".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                      const SizedBox(height: 4,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushNamed(context, '/${PageName.businessCenter}');
                                            },
                                            child: SizedBox(
                                              width: sizeWidth(context).width*0.4,
                                              height: sizeWidth(context).height*0.17,
                                              child: Card(
                                                elevation:2,
                                                shape: homeCard(context),
                                                child: Container(
                                                  decoration: mainDecoration(context),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Image.asset("assets/business.png",width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                      Text("businessCenter".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                      const SizedBox(height: 4,),
                                                    ],
                                                  ),
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
                                                   Navigator.pushNamed(context, '/${PageName.myAppointment}');
                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child: Card(
                                                     elevation:2,
                                                     shape: homeCard(context),
                                                     child: Container(
                                                       decoration: mainDecoration(context),
                                                       child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Image.asset("assets/appointment.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                           Text("myAppointments".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                           const SizedBox(height: 4,),
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                               GestureDetector(
                                                 onTap: () {
                                                   Navigator.pushNamed(context, '/${PageName.sale}');

                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child: Card(
                                                     elevation:2,
                                                     shape: homeCard(context),
                                                     child: Container(
                                                       decoration: mainDecoration(context),
                                                       child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Image.asset("assets/sales.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                           Text("salesActivity".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                           const SizedBox(height: 4,),
                                                         ],
                                                       ),
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
                                                   Navigator.pushNamed(context, '/${PageName.myLeads}');
                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child: Card(
                                                     elevation:2,
                                                     shape: homeCard(context),
                                                     child: Container(
                                                       decoration: mainDecoration(context),
                                                       child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Image.asset("assets/leads.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                           Text("myLeads".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                           const SizedBox(height: 4,),
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                               GestureDetector(
                                                 onTap: (){
                                                   Navigator.pushNamed(context, '/${PageName.myProgress}');
                                                 },
                                                 child: SizedBox(
                                                   width: sizeWidth(context).width*0.4,
                                                   height: sizeWidth(context).height*0.17,
                                                   child: Card(
                                                     elevation:2,
                                                     shape: homeCard(context),
                                                     child: Container(
                                                       decoration: mainDecoration(context),
                                                       child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Image.asset("assets/progress.png", width: double.infinity,height: sizeWidth(context).height*0.12,),
                                                           Text("myProgress".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                           const SizedBox(height: 4,),
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ],
                                       ),
                                   ),
                               ],
                             ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
 Future<void>getList() async{
   SharedPref pref = SharedPref();
   index = await pref.getInt(context, SharedUtils.profileIndex);
   loginUser ??= await getUser(context);

   await viewModel.detailReport(context, loginUser!.profiles![index].id!, loginUser!.profiles![index].organisation_id!);
   await viewModel.allSlider(context);
  }
}

