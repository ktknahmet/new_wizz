import 'Organisation.dart';

class Customer {
  Customer({
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
      this.organisation,});

  Customer.fromJson(dynamic json) {
    id = json['id'];
    uuid = json['uuid'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    loginEmail = json['loginEmail'];
    loginPhone = json['loginPhone'];
    dateOfBirth = json['dateOfBirth'];
    avatar = json['avatar'];
    isActive = json['isActive'];
    spouseFirstName = json['spouseFirstName'];
    spouseLastName = json['spouseLastName'];
    spouseEmail = json['spouseEmail'];
    spousePhone = json['spousePhone'];
    organisationName = json['organisationName'];
    productSerialNumbers = json['productSerialNumbers'];
    createdAt = json['createdAt'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    tiktok = json['tiktok'];
    facebook = json['facebook'];
    organisation = json['organisation'] != null ? Organisation.fromJson(json['organisation']) : null;
  }
  int? id;
  String? uuid;
  String? firstName;
  String? middleName;
  String? lastName;
  String? loginEmail;
  String? loginPhone;
  String? dateOfBirth;
  dynamic avatar;
  bool? isActive;
  dynamic spouseFirstName;
  dynamic spouseLastName;
  dynamic spouseEmail;
  String? spousePhone;
  dynamic organisationName;
  dynamic productSerialNumbers;
  String? createdAt;
  dynamic instagram;
  dynamic twitter;
  dynamic tiktok;
  dynamic facebook;
  Organisation? organisation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['uuid'] = uuid;
    map['firstName'] = firstName;
    map['middleName'] = middleName;
    map['lastName'] = lastName;
    map['loginEmail'] = loginEmail;
    map['loginPhone'] = loginPhone;
    map['dateOfBirth'] = dateOfBirth;
    map['avatar'] = avatar;
    map['isActive'] = isActive;
    map['spouseFirstName'] = spouseFirstName;
    map['spouseLastName'] = spouseLastName;
    map['spouseEmail'] = spouseEmail;
    map['spousePhone'] = spousePhone;
    map['organisationName'] = organisationName;
    map['productSerialNumbers'] = productSerialNumbers;
    map['createdAt'] = createdAt;
    map['instagram'] = instagram;
    map['twitter'] = twitter;
    map['tiktok'] = tiktok;
    map['facebook'] = facebook;
    if (organisation != null) {
      map['organisation'] = organisation?.toJson();
    }
    return map;
  }

}