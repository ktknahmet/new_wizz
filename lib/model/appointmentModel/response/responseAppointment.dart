// To parse this JSON data, do
//
//     final responseAppointment = responseAppointmentFromJson(jsonString);

import 'dart:convert';

ResponseAppointment responseAppointmentFromJson(String str) => ResponseAppointment.fromJson(json.decode(str));

String responseAppointmentToJson(ResponseAppointment data) => json.encode(data.toJson());

class ResponseAppointment {
  int? id;
  DateTime? date;
  dynamic saleId;
  String? code;
  int? user;
  int? organisationId;
  String? cname;
  String? cphone;
  String? caddress;
  String? ccity;
  String? cstate;
  String? czipcode;
  String? cfirstname;
  String? clastname;
  String? cemail;
  String? ccountry;
  String? ccounty;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? wherefrom;
  dynamic parent;
  int? type;
  int? status;
  dynamic relation;
  int? confirmed;
  dynamic gift;
  int? leadtypeid;
  dynamic age;
  dynamic referredby;
  dynamic work;
  dynamic eventname;
  dynamic whereprospect;
  int? oldcustomer;
  dynamic comment;
  String? sname;
  dynamic sfirstname;
  dynamic slastname;
  dynamic semail;
  dynamic sphone;
  int? drawing;

  ResponseAppointment({
    this.id,
    this.date,
    this.saleId,
    this.code,
    this.user,
    this.organisationId,
    this.cname,
    this.cphone,
    this.caddress,
    this.ccity,
    this.cstate,
    this.czipcode,
    this.cfirstname,
    this.clastname,
    this.cemail,
    this.ccountry,
    this.ccounty,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.wherefrom,
    this.parent,
    this.type,
    this.status,
    this.relation,
    this.confirmed,
    this.gift,
    this.leadtypeid,
    this.age,
    this.referredby,
    this.work,
    this.eventname,
    this.whereprospect,
    this.oldcustomer,
    this.comment,
    this.sname,
    this.sfirstname,
    this.slastname,
    this.semail,
    this.sphone,
    this.drawing,
  });

  factory ResponseAppointment.fromJson(Map<String, dynamic> json) => ResponseAppointment(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    saleId: json["sale_id"],
    code: json["code"],
    user: json["user"],
    organisationId: json["organisation_id"],
    cname: json["cname"],
    cphone: json["cphone"],
    caddress: json["caddress"],
    ccity: json["ccity"],
    cstate: json["cstate"],
    czipcode: json["czipcode"],
    cfirstname: json["cfirstname"],
    clastname: json["clastname"],
    cemail: json["cemail"],
    ccountry: json["ccountry"],
    ccounty: json["ccounty"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    wherefrom: json["wherefrom"],
    parent: json["parent"],
    type: json["type"],
    status: json["status"],
    relation: json["relation"],
    confirmed: json["confirmed"],
    gift: json["gift"],
    leadtypeid: json["leadtypeid"],
    age: json["age"],
    referredby: json["referredby"],
    work: json["work"],
    eventname: json["eventname"],
    whereprospect: json["whereprospect"],
    oldcustomer: json["oldcustomer"],
    comment: json["comment"],
    sname: json["sname"],
    sfirstname: json["sfirstname"],
    slastname: json["slastname"],
    semail: json["semail"],
    sphone: json["sphone"],
    drawing: json["drawing"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "sale_id": saleId,
    "code": code,
    "user": user,
    "organisation_id": organisationId,
    "cname": cname,
    "cphone": cphone,
    "caddress": caddress,
    "ccity": ccity,
    "cstate": cstate,
    "czipcode": czipcode,
    "cfirstname": cfirstname,
    "clastname": clastname,
    "cemail": cemail,
    "ccountry": ccountry,
    "ccounty": ccounty,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "wherefrom": wherefrom,
    "parent": parent,
    "type": type,
    "status": status,
    "relation": relation,
    "confirmed": confirmed,
    "gift": gift,
    "leadtypeid": leadtypeid,
    "age": age,
    "referredby": referredby,
    "work": work,
    "eventname": eventname,
    "whereprospect": whereprospect,
    "oldcustomer": oldcustomer,
    "comment": comment,
    "sname": sname,
    "sfirstname": sfirstname,
    "slastname": slastname,
    "semail": semail,
    "sphone": sphone,
    "drawing": drawing,
  };
}
