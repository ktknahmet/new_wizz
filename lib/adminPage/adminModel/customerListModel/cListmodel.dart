// To parse this JSON data, do
//
//     final cListModel = cListModelFromJson(jsonString);

import 'dart:convert';

CListModel cListModelFromJson(String str) => CListModel.fromJson(json.decode(str));

String cListModelToJson(CListModel data) => json.encode(data.toJson());

class CListModel {
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  int? totalRecords;
  String? nextPage;
  String? previousPage;
  String? firstPage;
  String? lastPage;
  List<Datum>? data;

  CListModel({
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.totalRecords,
    this.nextPage,
    this.previousPage,
    this.firstPage,
    this.lastPage,
    this.data,
  });

  factory CListModel.fromJson(Map<String, dynamic> json) => CListModel(
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    totalPages: json["totalPages"],
    totalRecords: json["totalRecords"],
    nextPage: json["nextPage"],
    previousPage: json["previousPage"],
    firstPage: json["firstPage"],
    lastPage: json["lastPage"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "totalPages": totalPages,
    "totalRecords": totalRecords,
    "nextPage": nextPage,
    "previousPage": previousPage,
    "firstPage": firstPage,
    "lastPage": lastPage,
    "data": List<dynamic>.from(data!.map((x) => x!.toJson())),
  };
}

class Datum {
  int? id;
  String? uuid;
  String? firstName;
  String? middleName;
  String? lastName;
  String? loginEmail;
  String? loginPhone;
  String? dateOfBirth;
  String? avatar;
  bool? isActive;
  String? spouseFirstName;
  String? spouseLastName;
  String? spouseEmail;
  String? spousePhone;
  String? organisationName;
  String? productSerialNumbers;
  String? createdAt;
  String? instagram;
  String? twitter;
  String? tiktok;
  String? facebook;
  Organisation? organisation;

  Datum({
    this.id,
    this.uuid,
    this.firstName,
    this.middleName,
    this.lastName,
    this.loginEmail,
    this.loginPhone,
    this.dateOfBirth,
    this.avatar,
    this.isActive,
    this.spouseFirstName,
    this.spouseLastName,
    this.spouseEmail,
    this.spousePhone,
    this.organisationName,
    this.productSerialNumbers,
    this.createdAt,
    this.instagram,
    this.twitter,
    this.tiktok,
    this.facebook,
    this.organisation,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    uuid: json["uuid"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    loginEmail: json["loginEmail"],
    loginPhone: json["loginPhone"],
    dateOfBirth: json["dateOfBirth"],
    avatar: json["avatar"],
    isActive: json["isActive"],
    spouseFirstName: json["spouseFirstName"],
    spouseLastName: json["spouseLastName"],
    spouseEmail: json["spouseEmail"],
    spousePhone: json["spousePhone"],
    organisationName: json["organisationName"],
    productSerialNumbers: json["productSerialNumbers"],
    createdAt: json["createdAt"],
    instagram: json["instagram"],
    twitter: json["twitter"],
    tiktok: json["tiktok"],
    facebook: json["facebook"],
    organisation: json["organisation"] != null ? Organisation.fromJson(json["organisation"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "loginEmail": loginEmail,
    "loginPhone": loginPhone,
    "dateOfBirth": dateOfBirth,
    "avatar": avatar,
    "isActive": isActive,
    "spouseFirstName": spouseFirstName,
    "spouseLastName": spouseLastName,
    "spouseEmail": spouseEmail,
    "spousePhone": spousePhone,
    "organisationName": organisationName,
    "productSerialNumbers": productSerialNumbers,
    "createdAt": createdAt,
    "instagram": instagram,
    "twitter": twitter,
    "tiktok": tiktok,
    "facebook": facebook,
    "organisation": organisation!.toJson(),
  };
}

class Organisation {
  int? id;
  String? name;
  String? organisationCode;
  String? organisationPerfix;
  OrganisationInformation? organisationInformation;

  Organisation({
    this.id,
    this.name,
    this.organisationCode,
    this.organisationPerfix,
    this.organisationInformation,
  });

  factory Organisation.fromJson(Map<String, dynamic> json) => Organisation(
    id: json["id"],
    name: json["name"],
    organisationCode: json["organisationCode"],
    organisationPerfix: json["organisationPerfix"],
    organisationInformation: OrganisationInformation.fromJson(json["organisationInformation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "organisationCode": organisationCode,
    "organisationPerfix": organisationPerfix,
    "organisationInformation": organisationInformation!.toJson(),
  };
}

class OrganisationInformation {
  int? id;
  int? organisationId;
  String? description;
  String? country;
  String? county;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  String? phone;
  String? email;
  String? webSite;
  String? organisationName;

  OrganisationInformation({
    this.id,
    this.organisationId,
    this.description,
    this.country,
    this.county,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    this.phone,
    this.email,
    this.webSite,
    this.organisationName,
  });

  factory OrganisationInformation.fromJson(Map<String, dynamic> json) => OrganisationInformation(
    id: json["id"],
    organisationId: json["organisationId"],
    description: json["description"],
    country: json["country"],
    county: json["county"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    zipcode: json["zipcode"],
    phone: json["phone"],
    email: json["email"],
    webSite: json["webSite"],
    organisationName: json["organisationName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "organisationId": organisationId,
    "description": description,
    "country": country,
    "county": county,
    "address": address,
    "city": city,
    "state": state,
    "zipcode": zipcode,
    "phone": phone,
    "email": email,
    "webSite": webSite,
    "organisationName": organisationName,
  };
}