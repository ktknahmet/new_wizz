// To parse this JSON data, do
//
//     final editAppintment = editAppintmentFromJson(jsonString);

import 'dart:convert';

EditAppointmentModel editAppointmentModelFromJson(String str) => EditAppointmentModel.fromJson(json.decode(str));

String editAppointmentModelToJson(EditAppointmentModel data) => json.encode(data.toJson());

class EditAppointmentModel {
  int? id;
  String? cfirstname;
  String? clastname;
  String? cphone;
  int? astatus;
  dynamic sfirstname;
  dynamic slastname;
  dynamic sphone;
  String? cemail;
  dynamic semail;
  int? registerby;
  String? caddress;
  String? ccity;
  String? cstate;
  String? czipcode;
  String? ccounty;
  String? ccountry;
  dynamic comment;
  int? dealer;
  String? rdate1;
  String? rdate2;

  EditAppointmentModel({
    this.id,
    this.cfirstname,
    this.clastname,
    this.cphone,
    this.astatus,
    this.sfirstname,
    this.slastname,
    this.sphone,
    this.cemail,
    this.semail,
    this.registerby,
    this.caddress,
    this.ccity,
    this.cstate,
    this.czipcode,
    this.ccounty,
    this.ccountry,
    this.comment,
    this.dealer,
    this.rdate1,
    this.rdate2,
  });

  factory EditAppointmentModel.fromJson(Map<String, dynamic> json) => EditAppointmentModel(
    id: json["id"],
    cfirstname: json["cfirstname"],
    clastname: json["clastname"],
    cphone: json["cphone"],
    astatus: json["astatus"],
    sfirstname: json["sfirstname"],
    slastname: json["slastname"],
    sphone: json["sphone"],
    cemail: json["cemail"],
    semail: json["semail"],
    registerby: json["registerby"],
    caddress: json["caddress"],
    ccity: json["ccity"],
    cstate: json["cstate"],
    czipcode: json["czipcode"],
    ccounty: json["ccounty"],
    ccountry: json["ccountry"],
    comment: json["comment"],
    dealer: json["dealer"],
    rdate1: json["rdate1"],
    rdate2: json["rdate2"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cfirstname": cfirstname,
    "clastname": clastname,
    "cphone": cphone,
    "astatus": astatus,
    "sfirstname": sfirstname,
    "slastname": slastname,
    "sphone": sphone,
    "cemail": cemail,
    "semail": semail,
    "registerby": registerby,
    "caddress": caddress,
    "ccity": ccity,
    "cstate": cstate,
    "czipcode": czipcode,
    "ccounty": ccounty,
    "ccountry": ccountry,
    "comment": comment,
    "dealer": dealer,
    "rdate1": rdate1,
    "rdate2": rdate2,
  };
}
