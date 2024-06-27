// To parse this JSON data, do
//
//     final liveDemoList = liveDemoListFromJson(jsonString);

import 'dart:convert';

import 'package:wizzsales/model/demoModel/demoSale.dart';
import 'package:wizzsales/model/demoModel/liveDemo/LivedemoListQuestion.dart';
import 'package:wizzsales/model/demoModel/liveDemo/Reason.dart';

List<LiveDemoList> liveDemoListFromJson(String str) => List<LiveDemoList>.from(json.decode(str).map((x) => LiveDemoList.fromJson(x)));

String liveDemoListToJson(List<LiveDemoList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveDemoList {
  int? demoLiveId;
  int? userId;
  int? organisationId;
  dynamic leadCode;
  dynamic saleId;
  dynamic demoStartTime;
  dynamic demoEndTime;
  int? totalDemoTime;
  bool? isLive;
  String? demoCustomerName;
  String? demoCustomerSurname;
  String? demoCustomerPhone;
  String? demoCustomerEmail;
  String? demoAddress;
  String? demoRegion;
  String? longitude;
  String? latitude;
  dynamic createdAt;
  String? demoCity;
  String? demoZipcode;
  String? demoCounty;
  String? demoState;
  String? demoCountry;
  String? status;
  dynamic demoNoteId;
  dynamic demoId;
  dynamic demoText;
  List<LiveDemoListQuestion>? questions;
  List<Reason>? reasons;
  List<User>? user;
  DemoSale? sale;
  LeadType? leadType;

  LiveDemoList({
    this.demoLiveId,
    this.userId,
    this.organisationId,
    this.leadCode,
    this.saleId,
    this.demoStartTime,
    this.demoEndTime,
    this.totalDemoTime,
    this.isLive,
    this.demoCustomerName,
    this.demoCustomerSurname,
    this.demoCustomerPhone,
    this.demoCustomerEmail,
    this.demoAddress,
    this.demoRegion,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.demoCity,
    this.demoZipcode,
    this.demoCounty,
    this.demoState,
    this.demoCountry,
    this.status,
    this.demoNoteId,
    this.demoId,
    this.demoText,
    this.questions,
    this.reasons,
    this.user,
    this.sale,
    this.leadType
  });

  factory LiveDemoList.fromJson(Map<String, dynamic> json) => LiveDemoList(
    demoLiveId: json["demo_live_id"],
    userId: json["user_id"],
    organisationId: json["organisation_id"],
    leadCode: json["lead_code"],
    saleId: json["sale_id"],
    demoStartTime: json["demo_start_time"],
    demoEndTime: json["demo_end_time"],
    totalDemoTime: json["total_demo_time"],
    isLive: json["is_live"],
    demoCustomerName: json["demo_customer_name"],
    demoCustomerSurname: json["demo_customer_surname"],
    demoCustomerPhone: json["demo_customer_phone"],
    demoCustomerEmail: json["demo_customer_email"],
    demoAddress: json["demo_address"],
    demoRegion: json["demo_region"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    createdAt: json["created_at"],
    demoCity: json["demo_city"],
    demoZipcode: json["demo_zipcode"],
    demoCounty: json["demo_county"],
    demoState: json["demo_state"],
    demoCountry: json["demo_country"],
    status: json["status"],
    demoNoteId: json["demo_note_id"],
    demoId: json["demo_id"],
    demoText: json["demo_text"],
    questions: List<LiveDemoListQuestion>.from(json["questions"].map((x) => LiveDemoListQuestion.fromJson(x))),
    reasons: List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x))),
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    sale: json["sale"] != null ? DemoSale.fromJson(json["sale"]) : null,
    leadType: json["leadtypeid"] != null ? LeadType.fromJson(json["leadtypeid"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "demo_live_id": demoLiveId,
    "user_id": userId,
    "organisation_id": organisationId,
    "lead_code": leadCode,
    "sale_id": saleId,
    "demo_start_time": demoStartTime,
    "demo_end_time": demoEndTime,
    "total_demo_time": totalDemoTime,
    "is_live": isLive,
    "demo_customer_name": demoCustomerName,
    "demo_customer_surname": demoCustomerSurname,
    "demo_customer_phone": demoCustomerPhone,
    "demo_customer_email": demoCustomerEmail,
    "demo_address": demoAddress,
    "demo_region": demoRegion,
    "longitude": longitude,
    "latitude": latitude,
    "created_at": createdAt,
    "demo_city": demoCity,
    "demo_zipcode": demoZipcode,
    "demo_county": demoCounty,
    "demo_state": demoState,
    "demo_country": demoCountry,
    "status": status,
    "demo_note_id": demoNoteId,
    "demo_id": demoId,
    "demo_text": demoText,
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
    "reasons": List<dynamic>.from(reasons!.map((x) => x.toJson())),
    "user": List<dynamic>.from(user!.map((x) => x.toJson())),
    "sale": sale!.toJson(),
    "leadtypeid": leadType!.toJson(),
  };
}







class User {
  int? id;
  String? name;

  User({
    this.id,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
class LeadType {
  int? leadtypeid;

  LeadType({
    this.leadtypeid,
  });

  factory LeadType.fromJson(Map<String, dynamic> json) => LeadType(
    leadtypeid: json["leadtypeid"],
  );

  Map<String, dynamic> toJson() => {
    "leadtypeid": leadtypeid,
  };
}
