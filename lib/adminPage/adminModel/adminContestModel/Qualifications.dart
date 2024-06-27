class Qualifications {
  Qualifications({
      this.id, 
      this.competitionId, 
      this.roleId, 
      this.type, 
      this.period, 
      this.time, 
      this.quantity, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.ib, 
      this.userid,});

  Qualifications.fromJson(dynamic json) {
    id = json['id'];
    competitionId = json['competition_id'];
    roleId = json['role_id'];
    type = json['type'];
    period = json['period'];
    time = json['time'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    ib = json['ib'];
    userid = json['userid'];
  }
  int? id;
  int? competitionId;
  int? roleId;
  String? type;
  String? period;
  int? time;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? ib;
  int? userid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['competition_id'] = competitionId;
    map['role_id'] = roleId;
    map['type'] = type;
    map['period'] = period;
    map['time'] = time;
    map['quantity'] = quantity;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['ib'] = ib;
    map['userid'] = userid;
    return map;
  }

}