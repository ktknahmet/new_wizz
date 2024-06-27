// To parse this JSON data, do
//
//     final postGoalReport = postGoalReportFromJson(jsonString);

import 'dart:convert';

PostGoalReport postGoalReportFromJson(String str) => PostGoalReport.fromJson(json.decode(str));

String postGoalReportToJson(PostGoalReport data) => json.encode(data.toJson());

class PostGoalReport {
  String? dayLeads;
  String? dayAppointments;
  String? dayDemos;
  String? dayEstimated;
  String? weekLeads;
  String? weekAppointments;
  String? weekDemos;
  String? weekEstimated;
  String? monthLeads;
  String? monthAppointments;
  String? monthDemos;
  String? monthEstimated;
  String? dayActualLeads;
  String? dayActualAppointments;
  String? dayActualDemos;
  String? dayActualEstimated;
  String? weekActualLeads;
  String? weekActualAppointments;
  String? weekActualDemos;
  String? weekActualEstimated;
  String? monthActualLeads;
  String? monthActualAppointments;
  String? monthActualDemos;
  String? monthActualEstimated;

  PostGoalReport({
     this.dayLeads,
     this.dayAppointments,
     this.dayDemos,
     this.dayEstimated,
     this.weekLeads,
     this.weekAppointments,
     this.weekDemos,
     this.weekEstimated,
     this.monthLeads,
     this.monthAppointments,
     this.monthDemos,
     this.monthEstimated,
     this.dayActualLeads,
     this.dayActualAppointments,
     this.dayActualDemos,
     this.dayActualEstimated,
     this.weekActualLeads,
     this.weekActualAppointments,
     this.weekActualDemos,
     this.weekActualEstimated,
     this.monthActualLeads,
     this.monthActualAppointments,
     this.monthActualDemos,
     this.monthActualEstimated,
  });

  factory PostGoalReport.fromJson(Map<String, dynamic> json) => PostGoalReport(
    dayLeads: json["day_leads"],
    dayAppointments: json["day_appointments"],
    dayDemos: json["day_demos"],
    dayEstimated: json["day_estimated"],
    weekLeads: json["week_leads"],
    weekAppointments: json["week_appointments"],
    weekDemos: json["week_demos"],
    weekEstimated: json["week_estimated"],
    monthLeads: json["month_leads"],
    monthAppointments: json["month_appointments"],
    monthDemos: json["month_demos"],
    monthEstimated: json["month_estimated"],
    dayActualLeads: json["day_actual_leads"],
    dayActualAppointments: json["day_actual_appointments"],
    dayActualDemos: json["day_actual_demos"],
    dayActualEstimated: json["day_actual_estimated"],
    weekActualLeads: json["week_actual_leads"],
    weekActualAppointments: json["week_actual_appointments"],
    weekActualDemos: json["week_actual_demos"],
    weekActualEstimated: json["week_actual_estimated"],
    monthActualLeads: json["month_actual_leads"],
    monthActualAppointments: json["month_actual_appointments"],
    monthActualDemos: json["month_actual_demos"],
    monthActualEstimated: json["month_actual_estimated"],
  );

  Map<String, dynamic> toJson() => {
    "day_leads": dayLeads,
    "day_appointments": dayAppointments,
    "day_demos": dayDemos,
    "day_estimated": dayEstimated,
    "week_leads": weekLeads,
    "week_appointments": weekAppointments,
    "week_demos": weekDemos,
    "week_estimated": weekEstimated,
    "month_leads": monthLeads,
    "month_appointments": monthAppointments,
    "month_demos": monthDemos,
    "month_estimated": monthEstimated,
    "day_actual_leads": dayActualLeads,
    "day_actual_appointments": dayActualAppointments,
    "day_actual_demos": dayActualDemos,
    "day_actual_estimated": dayActualEstimated,
    "week_actual_leads": weekActualLeads,
    "week_actual_appointments": weekActualAppointments,
    "week_actual_demos": weekActualDemos,
    "week_actual_estimated": weekActualEstimated,
    "month_actual_leads": monthActualLeads,
    "month_actual_appointments": monthActualAppointments,
    "month_actual_demos": monthActualDemos,
    "month_actual_estimated": monthActualEstimated,
  };
}
