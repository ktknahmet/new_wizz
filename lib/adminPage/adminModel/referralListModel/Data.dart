import 'Customer.dart';

class Data {
  Data({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.phone, 
      this.email, 
      this.socialMediaUserName, 
      this.relotionId, 
      this.referralSourceType, 
      this.customerReferralCode, 
      this.referralEventName, 
      this.isSentDemoSmS, 
      this.demoSmsSentDate, 
      this.isAcceptAppointment, 
      this.dateAcceptedAppointment, 
      this.isBecameCustomer, 
      this.dateBecameCustomer, 
      this.customerId, 
      this.createdAt, 
      this.customer, 
      this.smsLogs,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
    socialMediaUserName = json['socialMediaUserName'];
    relotionId = json['relotionId'];
    referralSourceType = json['referralSourceType'];
    customerReferralCode = json['customerReferralCode'];
    referralEventName = json['referralEventName'];
    isSentDemoSmS = json['isSentDemoSmS'];
    demoSmsSentDate = json['demoSmsSentDate'];
    isAcceptAppointment = json['isAcceptAppointment'];
    dateAcceptedAppointment = json['dateAcceptedAppointment'];
    isBecameCustomer = json['isBecameCustomer'];
    dateBecameCustomer = json['dateBecameCustomer'];
    customerId = json['customerId'];
    createdAt = json['createdAt'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    if (json['smsLogs'] != null) {
      smsLogs = [];
      json['smsLogs'].forEach((v) {
        smsLogs?.add(SmsLog.fromJson(v));
      });
    }
  }
  int? id;
  String? firstName;
  dynamic lastName;
  String? phone;
  dynamic email;
  dynamic socialMediaUserName;
  int? relotionId;
  String? referralSourceType;
  String? customerReferralCode;
  String? referralEventName;
  bool? isSentDemoSmS;
  dynamic demoSmsSentDate;
  bool? isAcceptAppointment;
  dynamic dateAcceptedAppointment;
  bool? isBecameCustomer;
  dynamic dateBecameCustomer;
  int? customerId;
  String? createdAt;
  Customer? customer;
  List<SmsLog>? smsLogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['phone'] = phone;
    map['email'] = email;
    map['socialMediaUserName'] = socialMediaUserName;
    map['relotionId'] = relotionId;
    map['referralSourceType'] = referralSourceType;
    map['customerReferralCode'] = customerReferralCode;
    map['referralEventName'] = referralEventName;
    map['isSentDemoSmS'] = isSentDemoSmS;
    map['demoSmsSentDate'] = demoSmsSentDate;
    map['isAcceptAppointment'] = isAcceptAppointment;
    map['dateAcceptedAppointment'] = dateAcceptedAppointment;
    map['isBecameCustomer'] = isBecameCustomer;
    map['dateBecameCustomer'] = dateBecameCustomer;
    map['customerId'] = customerId;
    map['createdAt'] = createdAt;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    if (smsLogs != null) {
      map['smsLogs'] = smsLogs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class SmsLog {
  int? id;
  String? smsKey;
  String? smsTitle;
  String? smsBody;
  String? from;
  String? to;
  DateTime? sentDate;
  int? referralId;
  int? customerId;

  SmsLog({
    this.id,
    this.smsKey,
    this.smsTitle,
    this.smsBody,
    this.from,
    this.to,
    this.sentDate,
    this.referralId,
    this.customerId,
  });

  factory SmsLog.fromJson(Map<String, dynamic> json) => SmsLog(
    id: json["id"],
    smsKey: json["smsKey"],
    smsTitle: json["smsTitle"],
    smsBody: json["smsBody"],
    from: json["from"],
    to: json["to"],
    sentDate: DateTime.parse(json["sentDate"]),
    referralId: json["referralId"],
    customerId: json["customerId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "smsKey": smsKey,
    "smsTitle": smsTitle,
    "smsBody": smsBody,
    "from": from,
    "to": to,
    "sentDate": sentDate!.toIso8601String(),
    "referralId": referralId,
    "customerId": customerId,
  };
}