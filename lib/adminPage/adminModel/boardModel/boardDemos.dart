// To parse this JSON data, do
//
//     final boardDemos = boardDemosFromJson(jsonString);

import 'dart:convert';

BoardDemos boardDemosFromJson(String str) => BoardDemos.fromJson(json.decode(str));

String boardDemosToJson(BoardDemos data) => json.encode(data.toJson());

class BoardDemos {
  int? demoLiveId;
  int? userId;
  int? organisationId;
  String? leadCode;
  int? saleId;
  dynamic demoStartTime;
  dynamic demoEndTime;
  int? totalDemoTime;
  bool? isLive;
  String? demoCustomerName;
  String? demoCustomerSurname;
  String? demoCustomerPhone;
  String? demoCustomerEmail;
  String? demoAddress;
  dynamic demoRegion;
  String? longitude;
  String? latitude;
  DateTime? createdAt;
  String? demoCity;
  String? demoZipcode;
  String? demoCounty;
  String? demoState;
  dynamic demoCountry;
  String? status;

  BoardDemos({
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
  });

  factory BoardDemos.fromJson(Map<String, dynamic> json) => BoardDemos(
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
    createdAt: DateTime.parse(json["created_at"]),
    demoCity: json["demo_city"],
    demoZipcode: json["demo_zipcode"],
    demoCounty: json["demo_county"],
    demoState: json["demo_state"],
    demoCountry: json["demo_country"],
    status: json["status"],
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
    "created_at": createdAt!.toIso8601String(),
    "demo_city": demoCity,
    "demo_zipcode": demoZipcode,
    "demo_county": demoCounty,
    "demo_state": demoState,
    "demo_country": demoCountry,
    "status": status,
  };
}
