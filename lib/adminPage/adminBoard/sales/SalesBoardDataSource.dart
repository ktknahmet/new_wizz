import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/saleMeeting.dart';

class SalesBoardDataSource extends CalendarDataSource{
  SalesBoardDataSource(List<SaleMeeting> source){
    appointments = source;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
  @override
  String getNotes(int index) {
    return appointments![index].notes;
  }

}
