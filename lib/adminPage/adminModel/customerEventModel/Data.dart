import 'Customer.dart';
import 'RewardEvent.dart';
import 'RewardEventActivity.dart';
import 'RewardEventActivityDetailDocuments.dart';

class Data {
  Data({
      this.id, 
      this.rewardEventActivityId, 
      this.eventPoint, 
      this.issueDate, 
      this.eventState, 
      this.customer, 
      this.rewardEvent, 
      this.rewardEventActivity, 
      this.rewardEventActivityDetailDocuments,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    rewardEventActivityId = json['rewardEventActivityId'];
    eventPoint = json['eventPoint'];
    issueDate = json['issueDate'];
    eventState = json['eventState'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    rewardEvent = json['rewardEvent'] != null ? RewardEvent.fromJson(json['rewardEvent']) : null;
    rewardEventActivity = json['rewardEventActivity'] != null ? RewardEventActivity.fromJson(json['rewardEventActivity']) : null;
    if (json['rewardEventActivityDetailDocuments'] != null) {
      rewardEventActivityDetailDocuments = [];
      json['rewardEventActivityDetailDocuments'].forEach((v) {
        rewardEventActivityDetailDocuments?.add(RewardEventActivityDetailDocuments.fromJson(v));
      });
    }
  }
  int? id;
  int? rewardEventActivityId;
  int? eventPoint;
  String? issueDate;
  String? eventState;
  Customer? customer;
  RewardEvent? rewardEvent;
  RewardEventActivity? rewardEventActivity;
  List<RewardEventActivityDetailDocuments>? rewardEventActivityDetailDocuments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rewardEventActivityId'] = rewardEventActivityId;
    map['eventPoint'] = eventPoint;
    map['issueDate'] = issueDate;
    map['eventState'] = eventState;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    if (rewardEvent != null) {
      map['rewardEvent'] = rewardEvent?.toJson();
    }
    if (rewardEventActivity != null) {
      map['rewardEventActivity'] = rewardEventActivity?.toJson();
    }
    if (rewardEventActivityDetailDocuments != null) {
      map['rewardEventActivityDetailDocuments'] = rewardEventActivityDetailDocuments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}