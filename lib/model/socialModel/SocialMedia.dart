// To parse this JSON data, do
//
//     final socialMedia = socialMediaFromJson(jsonString);

import 'dart:convert';

List<SocialMedia> socialMediaFromJson(String str) => List<SocialMedia>.from(json.decode(str).map((x) => SocialMedia.fromJson(x)));

String socialMediaToJson(List<SocialMedia> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SocialMedia {
  int? id;
  int? user_id;
  String? facebook_user_name;
  String? twitter_user_name;
  String? instagram_user_name;
  String? tiktok_user_name;

  SocialMedia({
     this.id,
     this.user_id,
     this.facebook_user_name,
     this.twitter_user_name,
     this.instagram_user_name,
     this.tiktok_user_name,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
    id: json["id"],
    user_id: json["user_id"],
    facebook_user_name: json["facebook_user_name"],
    twitter_user_name: json["twitter_user_name"],
    instagram_user_name: json["instagram_user_name"],
    tiktok_user_name: json["tiktok_user_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "facebook_user_name": facebook_user_name,
    "twitter_user_name": twitter_user_name,
    "instagram_user_name": instagram_user_name,
    "tiktok_user_name": tiktok_user_name,
  };
}
