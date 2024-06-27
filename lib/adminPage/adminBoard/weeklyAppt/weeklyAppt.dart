import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wizzsales/adminPage/adminBoard/weeklyAppt/weeklyApptDataSource.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/appointmentBoard.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/meeting.dart';
import 'package:wizzsales/adminPage/adminVm/adminBoardVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class WeeklyAppt extends BaseStatefulPage {
  const WeeklyAppt(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _WeeklyApptState();
}

class _WeeklyApptState extends BaseStatefulPageState<WeeklyAppt> {
  AdminBoardVm viewModel = AdminBoardVm();
  List<Meeting> meetList=[];
  CalendarController controller = CalendarController();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
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
                       Container(
                         width: sizeWidth(context).width*0.3,
                         decoration: containerDecoration(context),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("total".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                             Text(viewModel.boardList!.boardDemo!.length.toString(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                           ],
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
                      showDatePickerButton: true,
                      showNavigationArrow: true,
                      view: CalendarView.week,
                      timeZone: 'Central America Standard Time',
                      firstDayOfWeek: 1, // Monday
                      initialSelectedDate: DateTime.now(),
                      selectionDecoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: ColorUtil().getColor(context, ColorEnums.wizzColor)),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        shape: BoxShape.rectangle,
                      ),
                      allowAppointmentResize: true,
                      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                      todayHighlightColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      headerStyle: CalendarHeaderStyle(
                        backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                        textStyle: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                        backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
                        dateTextStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        dayTextStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                      ),

                      controller: controller,
                      dataSource: WeeklyApptDataSource(meetList),
                      todayTextStyle: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),

                        timeSlotViewSettings: TimeSlotViewSettings(
                          startHour: 8,
                          endHour: 18,
                          timeIntervalHeight: 50,
                          timeInterval: const Duration(minutes: 30),
                          timeFormat: 'h:mm a', // Time format
                          timeTextStyle: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)), // Customize the time text style
                        ),
                      appointmentBuilder: (context, CalendarAppointmentDetails details) {

                        return Icon(Icons.person,color: ColorUtil().getColor(context, ColorEnums.wizzColor),size: sizeWidth(context).width*0.04,);
                      },
                      onLongPress: (CalendarLongPressDetails details) {
                        if (details.appointments == null || details.appointments!.isEmpty) {
                          showAskNewAppt(context);
                        }
                      },
                      onTap: (CalendarTapDetails details) {
                        if (details.targetElement == CalendarElement.appointment) {
                          final int appointmentIndex = meetList.indexOf(details.appointments![0]);
                          showApptBoardDetails(context, viewModel.boardList!.appointments![appointmentIndex]);
                        }
                      },
                    )
                    ),

                ],
              ),
            );
          }
        },
      ),
    );
  }
  getList() async {
    await viewModel.getBoard(context);
    meetList.clear();

    if (viewModel.boardList?.appointments?.isNotEmpty ?? false) {
      for (int i = 0; i < viewModel.boardList!.appointments!.length; i++) {
        AppointmentBoard value = viewModel.boardList!.appointments![i];
        DateTime startDate = value.date!;
        DateTime endDate = parseTime(value.adate2!, startDate); // Ensure endDate is correct

        // Create the meeting with the appropriate details
        Meeting meet = Meeting(
          "${value.uname!} / ${value.ccity}",
          startDate,
          endDate,
          ColorUtil().getColor(context, ColorEnums.wizzColor),
          "${mmDDYDate(value.adate1)} ${value.adate2 ?? ""}",
        );
        meetList.add(meet);
      }
    }
  }
}
