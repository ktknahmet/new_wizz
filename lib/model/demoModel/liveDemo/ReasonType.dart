class ReasonType {
  int? reasonTypeId;
  String? reasonType;
  dynamic notes;
  int? reasonTypeDesc;
  DateTime? createdAt;
  dynamic updatedAt;

  ReasonType({
    this.reasonTypeId,
    this.reasonType,
    this.notes,
    this.reasonTypeDesc,
    this.createdAt,
    this.updatedAt,
  });

  factory ReasonType.fromJson(Map<String, dynamic> json) => ReasonType(
    reasonTypeId: json["reason_type_id"],
    reasonType: json["reason_type"],
    notes: json["notes"],
    reasonTypeDesc: json["reason_type_desc"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "reason_type_id": reasonTypeId,
    "reason_type": reasonType,
    "notes": notes,
    "reason_type_desc": reasonTypeDesc,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt,
  };
}