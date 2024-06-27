import 'package:wizzsales/model/demoModel/liveDemo/ReasonType.dart';

class Reason {
  int? unsuccessReasonId;
  int? demoId;
  int? userId;
  int? reasonTypeId;
  dynamic createdAt;
  dynamic updatedAt;
  List<ReasonType>? reasonType;

  Reason({
    this.unsuccessReasonId,
    this.demoId,
    this.userId,
    this.reasonTypeId,
    this.createdAt,
    this.updatedAt,
    this.reasonType,
  });

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
    unsuccessReasonId: json["unsuccess_reason_id"],
    demoId: json["demo_id"],
    userId: json["user_id"],
    reasonTypeId: json["reason_type_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    reasonType: List<ReasonType>.from(json["reason_type"].map((x) => ReasonType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "unsuccess_reason_id": unsuccessReasonId,
    "demo_id": demoId,
    "user_id": userId,
    "reason_type_id": reasonTypeId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "reason_type": List<dynamic>.from(reasonType!.map((x) => x.toJson())),
  };
}
