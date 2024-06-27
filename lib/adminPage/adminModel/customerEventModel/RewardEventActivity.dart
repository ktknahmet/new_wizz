class RewardEventActivity {
  RewardEventActivity({
      this.id, 
      this.rewardEventId, 
      this.customerId, 
      this.issueQuantity, 
      this.isClosed,});

  RewardEventActivity.fromJson(dynamic json) {
    id = json['id'];
    rewardEventId = json['rewardEventId'];
    customerId = json['customerId'];
    issueQuantity = json['issueQuantity'];
    isClosed = json['isClosed'];
  }
  int? id;
  int? rewardEventId;
  int? customerId;
  int? issueQuantity;
  bool? isClosed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rewardEventId'] = rewardEventId;
    map['customerId'] = customerId;
    map['issueQuantity'] = issueQuantity;
    map['isClosed'] = isClosed;
    return map;
  }

}