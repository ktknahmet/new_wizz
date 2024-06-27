import 'dart:convert';

import 'package:wizzsales/model/OLD/register/DistributorSubType.dart';

class LoginUser {
  String? token;
  int? userId;
  int? salesroleid;
  String? email;
  String? name;
  String? password;
  List<DistributorSubType>? profiles = [];

  LoginUser(
      {this.token,
        this.userId,
        this.email,
        this.name,
        this.password,
        this.profiles,
        this.salesroleid});

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      token: json['token'],
      userId: (json['userId'] == null) ? json['user_id'] : json['userId'],
      salesroleid: json['salesroleid'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
      profiles: json["profiles"] != null
          ? List<DistributorSubType>.from((json["profiles"] is String ? jsonDecode(json["profiles"]) : json["profiles"]).map((x) => DistributorSubType.fromJson(x)))
          : null,
    );
  }

  Map toJson() {
    return {
      'token': token,
      'userId': userId,
      'salesroleid': salesroleid,
      'email': email,
      'name': name,
      'password': password,
      'profiles': jsonEncode(profiles)
    };
  }
}

extension ExtCap on String {
  String get inCapss =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get allInCapss => toUpperCase();
  String get capitalizeFirstofEachh => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCapss)
      .join(" ");
}
