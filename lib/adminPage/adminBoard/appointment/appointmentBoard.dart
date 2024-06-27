import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wizzsales/adminPage/adminBoard/appointment/appointmentDataSource.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/appointmentBoard.dart';
import 'package:wizzsales/adminPage/adminVm/adminBoardVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../adminModel/boardModel/meeting.dart';

class AppointmentBoardPage extends BaseStatefulPage {
  const AppointmentBoardPage(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AppointmentBoardPageState();
}

class _AppointmentBoardPageState extends BaseStatefulPageState<AppointmentBoardPage> {
  AdminBoardVm viewModel = AdminBoardVm();
  List<Meeting> meetList=[];
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
          if(viewModel.boardList == null ){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: sizeWidth(context).height*0.08,
                        width: sizeWidth(context).width*0.8,
                        child:  ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: calculateCounts(viewModel.boardList!.appointments!).length,
                          itemBuilder: (context,index){
                            return SizedBox(
                              height: 30,
                              width: sizeWidth(context).width*0.21,
                              child: Card(
                                  elevation: 2,
                                  shape: cardShape(context),
                                  color: ColorUtil().getColor(context, ColorEnums.background),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(appointmentDays[index],style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                        Text(calculateCounts(viewModel.boardList!.appointments!)[index].toString(),style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                      ],
                                    ),
                                  )
                              ),
                            );
                          },
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
                    height: sizeWidth(context).height*0.75,
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
                      controller: controller,
                      dataSource: AppointmentDataSource(meetList),
                      view: CalendarView.month,
                      todayHighlightColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      todayTextStyle: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
              
                      monthViewSettings: MonthViewSettings(
                        agendaItemHeight: sizeWidth(context).width*0.18,
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
                        final Meeting meeting = details.appointments.first;
                        return Container(
                          decoration: BoxDecoration(
                            color: meeting.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(meeting.eventName,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                        Text(meeting.notes,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),

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
                            showAskNewAppt(context);
                          }
                        },
                        onTap: (CalendarTapDetails details) {
                            if (details.targetElement == CalendarElement.appointment) {
                              final int appointmentIndex = meetList.indexOf(details.appointments![0]);
                              showApptBoardDetails(context, viewModel.boardList!.appointments![appointmentIndex]);
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
    if(viewModel.boardList!.appointments!.isNotEmpty){
      for(int i=0;i<viewModel.boardList!.appointments!.length;i++){
        AppointmentBoard value = viewModel.boardList!.appointments![i];
        DateTime startDate = value.date!;
        DateTime endDate = parseTime(value.adate2!, startDate);
        Meeting meet = Meeting("${value.uname!} / ${value.ccity}",startDate,endDate,ColorUtil().getColor(context, ColorEnums.wizzColor),"${mmDDYDate(value.adate1)} ${value.adate2 ?? ""}");
        meetList.add(meet);
      }
    }
  }
}
