// To parse this JSON data, do
//
//     final postSocial = postSocialFromJson(jsonString);

import 'dart:convert';

PostSocial postSocialFromJson(String str) => PostSocial.fromJson(json.decode(str));

String postSocialToJson(PostSocial data) => json.encode(data.toJson());

class PostSocial {
  String? facebookUserName;
  String? twitterUserName;
  String? instagramUserName;
  String? tiktokUserName;

  PostSocial({
    this.facebookUserName,
    this.twitterUserName,
    this.instagramUserName,
    this.tiktokUserName,
  });

  factory PostSocial.fromJson(Map<String, dynamic> json) => PostSocial(
    facebookUserName: json["facebookUserName"],
    twitterUserName: json["twitterUserName"],
    instagramUserName: json["instagramUserName"],
    tiktokUserName: json["tiktokUserName"],
  );

  Map<String, dynamic> toJson() => {
    "facebookUserName": facebookUserName,
    "twitterUserName": twitterUserName,
    "instagramUserName": instagramUserName,
    "tiktokUserName": tiktokUserName,
  };
}
