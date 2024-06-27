// To parse this JSON data, do
//
//     final userGoals = userGoalsFromJson(jsonString);

import 'dart:convert';

List<UserGoals> userGoalsFromJson(String str) => List<UserGoals>.from(json.decode(str).map((x) => UserGoals.fromJson(x)));

String userGoalsToJson(List<UserGoals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserGoals {
  int? id;
  int? userId;
  dynamic date;
  String? period;
  int? leads;
  int? appointments;
  int? demos;
  int? estimated;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? role;
  int? actualLeads;
  int? actualAppointments;
  int? actualDemos;
  int? actualEstimated;

  UserGoals({
    this.id,
    this.userId,
    this.date,
    this.period,
    this.leads,
    this.appointments,
    this.demos,
    this.estimated,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.actualLeads,
    this.actualAppointments,
    this.actualDemos,
    this.actualEstimated,
  });

  factory UserGoals.fromJson(Map<String, dynamic> json) => UserGoals(
    id: json["id"],
    userId: json["user_id"],
    date: json["date"],
    period: json["period"],
    leads: json["leads"],
    appointments: json["appointments"],
    demos: json["demos"],
    estimated: json["estimated"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    role: json["role"],
    actualLeads: json["actual_leads"],
    actualAppointments: json["actual_appointments"],
    actualDemos: json["actual_demos"],
    actualEstimated: json["actual_estimated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "date": date,
    "period": period,
    "leads": leads,
    "appointments": appointments,
    "demos": demos,
    "estimated": estimated,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "role": role,
    "actual_leads": actualLeads,
    "actual_appointments": actualAppointments,
    "actual_demos": actualDemos,
    "actual_estimated": actualEstimated,
  };
}
