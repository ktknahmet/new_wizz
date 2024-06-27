// To parse this JSON data, do
//
//     final postReferral = postReferralFromJson(jsonString);

import 'dart:convert';

List<PostReferral> postReferralFromJson(String str) => List<PostReferral>.from(json.decode(str).map((x) => PostReferral.fromJson(x)));

String postReferralToJson(List<PostReferral> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostReferral {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;

  PostReferral({
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
  });

  factory PostReferral.fromJson(Map<String, dynamic> json) => PostReferral(
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "phone": phone,
  };
}