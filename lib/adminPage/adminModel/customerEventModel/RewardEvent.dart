class RewardEvent {
  RewardEvent({
      this.rewardEventId, 
      this.eventName, 
      this.eventGroupViewName, 
      this.eventAction, 
      this.eventParticipant, 
      this.affectToScoreName, 
      this.eventViewName, 
      this.eventViewDescription, 
      this.eventActionPoint, 
      this.minRequirementQuantityToWin, 
      this.hasRecursive, 
      this.recursiveQuantity, 
      this.beginDate, 
      this.endDate, 
      this.isActive, 
      this.needApproval, 
      this.eventDocument, 
      this.isNeedUploadContent, 
      this.orderBy, 
      this.isVideoUploadContent, 
      this.underGroupOrdering,});

  RewardEvent.fromJson(dynamic json) {
    rewardEventId = json['rewardEventId'];
    eventName = json['eventName'];
    eventGroupViewName = json['eventGroupViewName'];
    eventAction = json['eventAction'];
    eventParticipant = json['eventParticipant'];
    affectToScoreName = json['affectToScoreName'];
    eventViewName = json['eventViewName'];
    eventViewDescription = json['eventViewDescription'];
    eventActionPoint = json['eventActionPoint'];
    minRequirementQuantityToWin = json['minRequirementQuantityToWin'];
    hasRecursive = json['hasRecursive'];
    recursiveQuantity = json['recursiveQuantity'];
    beginDate = json['beginDate'];
    endDate = json['endDate'];
    isActive = json['isActive'];
    needApproval = json['needApproval'];
    eventDocument = json['eventDocument'];
    isNeedUploadContent = json['isNeedUploadContent'];
    orderBy = json['orderBy'];
    isVideoUploadContent = json['isVideoUploadContent'];
    underGroupOrdering = json['underGroupOrdering'];
  }
  int? rewardEventId;
  String? eventName;
  String? eventGroupViewName;
  String? eventAction;
  String? eventParticipant;
  String? affectToScoreName;
  String? eventViewName;
  String? eventViewDescription;
  int? eventActionPoint;
  int? minRequirementQuantityToWin;
  bool? hasRecursive;
  int? recursiveQuantity;
  String? beginDate;
  String? endDate;
  bool? isActive;
  bool? needApproval;
  String? eventDocument;
  bool? isNeedUploadContent;
  int? orderBy;
  bool? isVideoUploadContent;
  int? underGroupOrdering;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rewardEventId'] = rewardEventId;
    map['eventName'] = eventName;
    map['eventGroupViewName'] = eventGroupViewName;
    map['eventAction'] = eventAction;
    map['eventParticipant'] = eventParticipant;
    map['affectToScoreName'] = affectToScoreName;
    map['eventViewName'] = eventViewName;
    map['eventViewDescription'] = eventViewDescription;
    map['eventActionPoint'] = eventActionPoint;
    map['minRequirementQuantityToWin'] = minRequirementQuantityToWin;
    map['hasRecursive'] = hasRecursive;
    map['recursiveQuantity'] = recursiveQuantity;
    map['beginDate'] = beginDate;
    map['endDate'] = endDate;
    map['isActive'] = isActive;
    map['needApproval'] = needApproval;
    map['eventDocument'] = eventDocument;
    map['isNeedUploadContent'] = isNeedUploadContent;
    map['orderBy'] = orderBy;
    map['isVideoUploadContent'] = isVideoUploadContent;
    map['underGroupOrdering'] = underGroupOrdering;
    return map;
  }

}