// To parse this JSON data, do
//
//     final sliderPayload = sliderPayloadFromJson(jsonString);

import 'dart:convert';

List<SliderPayload> sliderPayloadFromJson(String str) => List<SliderPayload>.from(json.decode(str).map((x) => SliderPayload.fromJson(x)));

String sliderPayloadToJson(List<SliderPayload> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderPayload {
  int? id;
  String? sliderViewName;
  int? sliderOrder;
  String? onClick;
  String? filePath;
  String? sliderType;
  bool? isActive;
  dynamic onClickType;
  String? companyCode;
  int? organisationId;
  String? applicationSource;
  int? createdBy;
  dynamic createdAt;
  dynamic updatedBy;
  dynamic updatedAt;

  SliderPayload({
    this.id,
    this.sliderViewName,
    this.sliderOrder,
    this.onClick,
    this.filePath,
    this.sliderType,
    this.isActive,
    this.onClickType,
    this.companyCode,
    this.organisationId,
    this.applicationSource,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory SliderPayload.fromJson(Map<String, dynamic> json) => SliderPayload(
    id: json["id"],
    sliderViewName: json["sliderViewName"],
    sliderOrder: json["sliderOrder"],
    onClick: json["onClick"],
    filePath: json["filePath"],
    sliderType: json["sliderType"],
    isActive: json["isActive"],
    onClickType: json["onClickType"],
    companyCode: json["companyCode"],
    organisationId: json["organisationId"],
    applicationSource: json["applicationSource"],
    createdBy: json["createdBy"],
    createdAt: json["createdAt"],
    updatedBy: json["updatedBy"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sliderViewName": sliderViewName,
    "sliderOrder": sliderOrder,
    "onClick": onClick,
    "filePath": filePath,
    "sliderType": sliderType,
    "isActive": isActive,
    "onClickType": onClickType,
    "companyCode": companyCode,
    "organisationId": organisationId,
    "applicationSource": applicationSource,
    "createdBy": createdBy,
    "createdAt": createdAt,
    "updatedBy": updatedBy,
    "updatedAt": updatedAt,
  };
}
