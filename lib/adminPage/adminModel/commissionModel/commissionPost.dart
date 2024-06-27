// To parse this JSON data, do
//
//     final commisionPost = commisionPostFromJson(jsonString);

import 'dart:convert';

CommisionPost commisionPostFromJson(String str) => CommisionPost.fromJson(json.decode(str));

String commisionPostToJson(CommisionPost data) => json.encode(data.toJson());

class CommisionPost {
  int? roleId;
  int? profileId;
  dynamic calcBeginDate;
  dynamic calcExpireDate;


  CommisionPost({
    this.roleId,
    this.profileId,
    this.calcBeginDate,
    this.calcExpireDate,

  });

  factory CommisionPost.fromJson(Map<String, dynamic> json) => CommisionPost(
    roleId: json["role_id"],
    profileId: json["profile_id"],
    calcBeginDate: json["calc_begin_date"],
    calcExpireDate: json["calc_expire_date"],
  );

  Map<String, dynamic> toJson() => {
    "role_id": roleId,
    "profile_id":profileId,
    "calc_begin_date": calcBeginDate,
    "calc_expire_date": calcExpireDate,

  };
}

