import 'package:flutter/material.dart';

class WeeklyMeet {
  WeeklyMeet(this.eventName, this.from,this.to,this.background,this.notes);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  String notes;
}