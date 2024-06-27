// To parse this JSON data, do
//
//     final appointmentValues = appointmentValuesFromJson(jsonString);

import 'dart:convert';

AppointmentValues appointmentValuesFromJson(String str) => AppointmentValues.fromJson(json.decode(str));

String appointmentValuesToJson(AppointmentValues data) => json.encode(data.toJson());

class AppointmentValues {
  List<Employee>? statusForm;
  int? adid;
  List<Employee>? employee;
  List<Employee>? employee2;

  AppointmentValues({
    this.statusForm,
    this.adid,
    this.employee,
    this.employee2,
  });

  factory AppointmentValues.fromJson(Map<String, dynamic> json) => AppointmentValues(
    statusForm: List<Employee>.from(json["statusForm"].map((x) => Employee.fromJson(x))),
    adid: json["adid"],
    employee: List<Employee>.from(json["employee"].map((x) => Employee.fromJson(x))),
    employee2: List<Employee>.from(json["employee2"].map((x) => Employee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusForm": List<dynamic>.from(statusForm!.map((x) => x.toJson())),
    "adid": adid,
    "employee": List<dynamic>.from(employee!.map((x) => x.toJson())),
    "employee2": List<dynamic>.from(employee2!.map((x) => x.toJson())),
  };
}

class Employee {
  int? id;
  String? name;

  Employee({
    this.id,
    this.name,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
