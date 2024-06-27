// To parse this JSON data, do
//
//     final postCustomerEvent = postCustomerEventFromJson(jsonString);

import 'dart:convert';

PostCList postCListFromJson(String str) => PostCList.fromJson(json.decode(str));

String postCListToJson(PostCList data) => json.encode(data.toJson());

class PostCList {
  String? eventName;
  String? eventAction;
  int? rewardEventActivityDetailId;
  int? participantId;

  PostCList({
    this.eventName,
    this.eventAction,
    this.rewardEventActivityDetailId,
    this.participantId,
  });

  factory PostCList.fromJson(Map<String, dynamic> json) => PostCList(
    eventName: json["eventName"],
    eventAction: json["eventAction"],
    rewardEventActivityDetailId: json["rewardEventActivityDetailId"],
    participantId: json["participantId"],
  );

  Map<String, dynamic> toJson() => {
    "eventName": eventName,
    "eventAction": eventAction,
    "rewardEventActivityDetailId": rewardEventActivityDetailId,
    "participantId": participantId,
  };
}