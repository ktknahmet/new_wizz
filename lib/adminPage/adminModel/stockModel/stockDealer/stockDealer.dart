// To parse this JSON data, do
//
//     final stockDealer = stockDealerFromJson(jsonString);

import 'dart:convert';

List<StockDealer> stockDealerFromJson(String str) => List<StockDealer>.from(json.decode(str).map((x) => StockDealer.fromJson(x)));

String stockDealerToJson(List<StockDealer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockDealer {
  String? profilemenurole;
  int? id;
  String? name;
  String? firstname;
  int? newdealer;
  int? newda;
  int? exSales;
  int? ranking;
  int? startranking;
  int? notification;
  dynamic goal;
  dynamic sgoal;
  String? image;
  dynamic birthday;
  String? address;
  String? city;
  String? state;
  String? county;
  String? country;
  String? zipcode;
  String? phone;
  String? lastname;
  String? email;
  int? statusId;
  int? organisationId;
  dynamic newrole;
  int? distributor;
  String? distributorname;
  int? parent;
  String? parentname;
  int? careerSales;
  dynamic tshirtsize;
  dynamic token;
  int? mainprofile;
  int? totalprofile;

  StockDealer({
    this.profilemenurole,
    this.id,
    this.name,
    this.firstname,
    this.newdealer,
    this.newda,
    this.exSales,
    this.ranking,
    this.startranking,
    this.notification,
    this.goal,
    this.sgoal,
    this.image,
    this.birthday,
    this.address,
    this.city,
    this.state,
    this.county,
    this.country,
    this.zipcode,
    this.phone,
    this.lastname,
    this.email,
    this.statusId,
    this.organisationId,
    this.newrole,
    this.distributor,
    this.distributorname,
    this.parent,
    this.parentname,
    this.careerSales,
    this.tshirtsize,
    this.token,
    this.mainprofile,
    this.totalprofile,
  });

  factory StockDealer.fromJson(Map<String, dynamic> json) => StockDealer(
    profilemenurole: json["profilemenurole"],
    id: json["id"],
    name: json["name"],
    firstname: json["firstname"],
    newdealer: json["newdealer"],
    newda: json["newda"],
    exSales: json["ex_sales"],
    ranking: json["ranking"],
    startranking: json["startranking"],
    notification: json["notification"],
    goal: json["goal"],
    sgoal: json["sgoal"],
    image: json["image"],
    birthday: json["birthday"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    county: json["county"],
    country: json["country"],
    zipcode: json["zipcode"],
    phone: json["phone"],
    lastname: json["lastname"],
    email: json["email"],
    statusId: json["status_id"],
    organisationId: json["organisation_id"],
    newrole: json["newrole"],
    distributor: json["distributor"],
    distributorname: json["distributorname"],
    parent: json["parent"],
    parentname: json["parentname"],
    careerSales: json["career_sales"],
    tshirtsize: json["tshirtsize"],
    token: json["token"],
    mainprofile: json["mainprofile"],
    totalprofile: json["totalprofile"],
  );

  Map<String, dynamic> toJson() => {
    "profilemenurole": profilemenurole,
    "id": id,
    "name": name,
    "firstname": firstname,
    "newdealer": newdealer,
    "newda": newda,
    "ex_sales": exSales,
    "ranking": ranking,
    "startranking": startranking,
    "notification": notification,
    "goal": goal,
    "sgoal": sgoal,
    "image": image,
    "birthday": birthday,
    "address": address,
    "city": city,
    "state": state,
    "county": county,
    "country": country,
    "zipcode": zipcode,
    "phone": phone,
    "lastname": lastname,
    "email": email,
    "status_id": statusId,
    "organisation_id": organisationId,
    "newrole": newrole,
    "distributor": distributor,
    "distributorname": distributorname,
    "parent": parent,
    "parentname": parentname,
    "career_sales": careerSales,
    "tshirtsize": tshirtsize,
    "token": token,
    "mainprofile": mainprofile,
    "totalprofile": totalprofile,
  };
}
