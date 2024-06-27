
// ignore_for_file: file_names

import 'dart:convert';
String leadsToJson(Leads data) => json.encode(data.toJson());
class Leads{
  DateTime? date;
  int? leadid;
  String? cname;
  String? cfirstname;
  String? clastname;
  String? cCdode;
  String? cphone;
  String? cCountyCode;
  String? dialCode;
  String? caddress;
  String? sname;
  String? sfirstname;
  String? slastname;
  String? sCode;
  String? sphone;
  String? sCountyCode;
  String? semail;
  String? cemail;
  String? ccounty;
  String? ccountry;
  String? ccity;
  String? cstate;
  String? czipcode;
  String? referredby;
  String? work;
  String? eventname;
  String? whereprospect;
  int? appointment;
  String? adate;
  String? atime;
  Map<int,String>? listQuestion;
  List<int>? questionKeys;
  List<Questions>? questions;

  Leads({
    this.date,
    this.leadid,
    this.cname,
    this.cfirstname,
    this.clastname,
    this.cCdode,
    this.cphone,
    this.cCountyCode,
    this.dialCode,
    this.caddress,
    this.sname,
    this.sfirstname,
    this.slastname,
    this.sCode,
    this.sphone,
    this.sCountyCode,
    this.semail,
    this.cemail,
    this.ccounty,
    this.ccountry,
    this.ccity,
    this.cstate,
    this.czipcode,
    this.referredby,
    this.work,
    this.eventname,
    this.whereprospect,
    this.appointment,
    this.adate,
    this.atime,
    this.listQuestion,
    this.questionKeys,
    this.questions
  });
  factory Leads.fromJson(Map<String, dynamic> json) {
    return Leads(
      date: json['date'],
      leadid: json['leadid'],
      cname: json['cname'],
      cfirstname: json['cfirstname'],
      clastname: json['clastname'],
      cphone: json['cphone'],
      caddress: json['caddress'],
      sname: json['sname'],
      sfirstname: json['sfirstname'],
      slastname: json['slastname'],
      sphone: json['sphone'],
      semail: json['semail'],
      cemail :json['cemail'],
      ccountry :json['ccountry'],
      ccity :json['ccity'],
      cstate :json['cstate'],
      czipcode :json['czipcode'],
      referredby :json['referredby'],
      work :json['work'],
      eventname :json['eventname'],
      whereprospect :json['whereprospect'],
      appointment :json['appointment'],
      adate :json['adate'],
      atime :json['atime'],
      listQuestion:json['listQuestions'],
      questions :List<Questions>.from(json["questions"].map((x) => Questions.fromJson(x))),
    );

  }
  Map<String, dynamic> toJson() => {
    "date": date.toString(),
    "leadid": leadid,
    "cname": cname,
    "cfirstname": cfirstname,
    "clastname": clastname,
    "cphone": cphone,
    "caddress": caddress,
    "sphone": sphone,
    "cemail": cemail,
    "semail": semail,
    "ccountry": ccountry,
    "ccounty": ccounty,
    "ccity": ccity,
    "cstate": cstate,
    "czipcode": czipcode,
    "referredby": referredby,
    "work": work,
    "eventname": eventname,
    "whereprospect": whereprospect,
    "appointment": appointment,
    "adate" :adate,
    "atime":atime,
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
  };

}
class Questions{
  int? id;
  String? answer;

  Questions(
      {
        this.id,
        this.answer
      });
  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
    id: json["id"],
    answer: json["answer"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "answer": answer,
  };
}