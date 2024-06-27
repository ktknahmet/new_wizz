// To parse this JSON data, do
//
//     final postLiveDemo = postLiveDemoFromJson(jsonString);

import 'dart:convert';

PostLiveDemo postLiveDemoFromJson(String str) => PostLiveDemo.fromJson(json.decode(str));

String postLiveDemoToJson(PostLiveDemo data) => json.encode(data.toJson());

class PostLiveDemo {
  int? organisationId;
  String? demoCustomerName;
  String? demoCustomerSurname;
  String? demoCustomerPhone;
  String? demoCustomerEmail;
  String? demoAddress;
  String? demoRegion;
  double? longitude;
  double? latitude;
  String? leadCode;
  String? demoCity;
  String? demoZipcode;
  String? demoCounty;
  String? demoState;
  String? demoCountry;

  PostLiveDemo({
    this.organisationId,
    this.demoCustomerName,
    this.demoCustomerSurname,
    this.demoCustomerPhone,
    this.demoCustomerEmail,
    this.demoAddress,
    this.demoRegion,
    this.longitude,
    this.latitude,
    this.leadCode,
    this.demoCity,
    this.demoZipcode,
    this.demoCounty,
    this.demoState,
    this.demoCountry
  });

  factory PostLiveDemo.fromJson(Map<String, dynamic> json) => PostLiveDemo(
    organisationId: json["organisation_id"],
    demoCustomerName: json["demo_customer_name"],
    demoCustomerSurname: json["demo_customer_surname"],
    demoCustomerPhone: json["demo_customer_phone"],
    demoCustomerEmail: json["demo_customer_email"],
    demoAddress: json["demo_address"],
    demoRegion: json["demo_region"],
    longitude: json["longitude"].toDouble(),
    latitude: json["latitude"].toDouble(),
    leadCode: json["lead_code"],
    demoCity: json["demo_city"],
    demoZipcode: json["demo_zipcode"],
    demoCounty: json["demo_county"],
    demoState: json["demo_state"],
    demoCountry: json["demo_country"],
  );

  Map<String, dynamic> toJson() => {
    "organisation_id": organisationId,
    "demo_customer_name": demoCustomerName,
    "demo_customer_surname": demoCustomerSurname,
    "demo_customer_phone": demoCustomerPhone,
    "demo_customer_email": demoCustomerEmail,
    "demo_address": demoAddress,
    "demo_region": demoRegion,
    "longitude": longitude,
    "latitude": latitude,
    "lead_code":leadCode,
    "demo_city":demoCity,
    "demo_zipcode":demoZipcode,
    "demo_county":demoCounty,
    "demo_state":demoState,
    "demo_country":demoCountry
  };
}