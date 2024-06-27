class RewardEventActivityDetailDocuments {
  RewardEventActivityDetailDocuments({
      this.id, 
      this.rewardEventActivityDetailId, 
      this.documentPath, 
      this.uploadedDate,});

  RewardEventActivityDetailDocuments.fromJson(dynamic json) {
    id = json['id'];
    rewardEventActivityDetailId = json['rewardEventActivityDetailId'];
    documentPath = json['documentPath'];
    uploadedDate = json['uploadedDate'];
  }
  int? id;
  int? rewardEventActivityDetailId;
  String? documentPath;
  String? uploadedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rewardEventActivityDetailId'] = rewardEventActivityDetailId;
    map['documentPath'] = documentPath;
    map['uploadedDate'] = uploadedDate;
    return map;
  }

}