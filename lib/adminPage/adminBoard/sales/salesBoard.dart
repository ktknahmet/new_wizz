import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wizzsales/adminPage/adminBoard/sales/SalesBoardDataSource.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/saleBoard.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/saleMeeting.dart';
import 'package:wizzsales/adminPage/adminVm/adminBoardVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../../constants/AppColors.dart';
// ignore_for_file: use_build_context_synchronously

class SalesBoardPage extends BaseStatefulPage {
  const SalesBoardPage(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _SalesBoardPageState();
}

class _SalesBoardPageState extends BaseStatefulPageState<SalesBoardPage> {
  AdminBoardVm viewModel = AdminBoardVm();
  List<SaleMeeting> meetList=[];
  CalendarController controller = CalendarController();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AdminBoardVm>(
        builder: (context,value,_){
          if(viewModel.boardList == null){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: sizeWidth(context).width*0.8,
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
                                            Text(calculateCountsSale(viewModel.boardList!.sales!)[0].toString(), style: CustomTextStyle().bold10(AppColors.white)),

                                          ],
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 2,right: 2),
                                        child: Column(
                                          children: [
                                            Text("today".tr(), style: CustomTextStyle().bold10(AppColors.white)),
                                            Text(calculateCountsSale(viewModel.boardList!.sales!)[1].toString(), style: CustomTextStyle().bold10(AppColors.white)),

                                          ],
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 2,right: 2),
                                        child: Column(
                                          children: [
                                            Text("week".tr(), style: CustomTextStyle().bold10(AppColors.white)),
                                            Text(calculateCountsSale(viewModel.boardList!.sales!)[2].toString(), style: CustomTextStyle().bold10(AppColors.white)),

                                          ],
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 2,right: 2),
                                        child: Column(
                                          children: [
                                            Text("month".tr(), style: CustomTextStyle().bold10(AppColors.white)),
                                            Text(calculateCountsSale(viewModel.boardList!.sales!)[3].toString(), style: CustomTextStyle().bold10(AppColors.white)),

                                          ],
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 2,right: 2),
                                        child: Column(
                                          children: [
                                            Text("year".tr(), style: CustomTextStyle().bold10(AppColors.white)),
                                            Text(calculateCountsSale(viewModel.boardList!.sales!)[4].toString(), style: CustomTextStyle().bold10(AppColors.white)),

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

                      GestureDetector(
                        onTap: ()async{
                          showProgress(context, true);
                          await getList();
                          showProgress(context, false);
                        },
                        child: Icon(Icons.refresh,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: justList(context, sizeWidth(context).height),
                    child: SfCalendar(
                      headerStyle: CalendarHeaderStyle(
                        backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                        textStyle: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                      ),
              
                      selectionDecoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: ColorUtil().getColor(context, ColorEnums.wizzColor)),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        shape: BoxShape.rectangle,
                      ),
                      dataSource: SalesBoardDataSource(meetList),
                      view: CalendarView.month,
                      todayHighlightColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      todayTextStyle: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                      controller: controller,
                      monthViewSettings: MonthViewSettings(
                          showAgenda: true,
                          navigationDirection: MonthNavigationDirection.horizontal,
                          showTrailingAndLeadingDates: true,
                          dayFormat: 'EEE',
                          agendaViewHeight: sizeWidth(context).height*0.3,
                          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                          agendaStyle:  AgendaStyle(
                            placeholderTextStyle:CustomTextStyle().semiBold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)) ,
                            backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                            appointmentTextStyle: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                            dateTextStyle: CustomTextStyle().semiBold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                            dayTextStyle: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                          monthCellStyle: MonthCellStyle(
                              backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                              trailingDatesBackgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                              leadingDatesBackgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                              textStyle: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              todayTextStyle: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              trailingDatesTextStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              leadingDatesTextStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)))
                      ),
                      appointmentBuilder: (context, details) {
                        final SaleMeeting meeting = details.appointments.first;
                        return Container(
                          decoration: BoxDecoration(
                            color: meeting.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (meeting.notes.isNotEmpty)
                                  GestureDetector(
                                    onTap:(){
                                     showPhoto(context, meeting.notes);
                                    },
                                    child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/loading.gif',
                                    image:  meeting.notes,
                                    fit: BoxFit.contain,
                                    height: 32,
                                   ),
                                  ) else Image.asset(
                                  "assets/uploadPhoto.webp",
                                  fit: BoxFit.contain,
                                  height: 32,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(meeting.eventName,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                      ],
                                    ),
                                  ),
                                ),
                                Text("seeDetails".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                              ],
                            ),
                          ),
                        );
                      },
                        onLongPress: (CalendarLongPressDetails details){
              
                            if (details.appointments == null || details.appointments!.isEmpty) {
                              showAskNewSale(context);
                            }
                        },
                        onTap: (CalendarTapDetails details) {
                           if (details.targetElement == CalendarElement.appointment) {
                            final int appointmentIndex = meetList.indexOf(details.appointments![0]);
                            showSalesBoardDetails(context,viewModel.boardList!.sales![appointmentIndex]);
                          }
                        }
              
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
  getList()async{
    await viewModel.getBoard(context);
    meetList.clear();
    if(viewModel.boardList!.sales!.isNotEmpty){
      for(int i=0;i<viewModel.boardList!.sales!.length;i++){
        SaleBoard value = viewModel.boardList!.sales![i];
        DateTime startDate = value.date!;
        SaleMeeting meet = SaleMeeting(
            value.cname!,
            startDate,startDate,
            ColorUtil().getColor(context, ColorEnums.wizzColor),
            value.image ?? "");
        meetList.add(meet);
      }
    }
  }
}
