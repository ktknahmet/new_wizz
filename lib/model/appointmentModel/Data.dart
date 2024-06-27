class Data {
  Data({
      this.id, 
      this.date, 
      this.saleId, 
      this.code, 
      this.user, 
      this.organisationId, 
      this.cname, 
      this.cphone, 
      this.caddress, 
      this.ccity, 
      this.cstate, 
      this.czipcode, 
      this.cfirstname, 
      this.clastname, 
      this.cemail, 
      this.ccountry, 
      this.ccounty, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.wherefrom, 
      this.parent, 
      this.type, 
      this.status, 
      this.relation, 
      this.confirmed, 
      this.gift, 
      this.leadtypeid, 
      this.age, 
      this.referredby, 
      this.work, 
      this.eventname, 
      this.whereprospect, 
      this.oldcustomer, 
      this.comment, 
      this.sname, 
      this.sfirstname, 
      this.slastname, 
      this.semail, 
      this.sphone, 
      this.drawing, 
      this.dated, 
      this.serialid, 
      this.orgname, 
      this.uname, 
      this.adate, 
      this.adate1, 
      this.adate2, 
      this.rdate, 
      this.rdate1, 
      this.rdate2, 
      this.timezone, 
      this.astatus, 
      this.leadtype, 
      this.leadtypename, 
      this.dealer, 
      this.dealername, 
      this.comfirmedname, 
      this.setname, 
      this.appointmentdate, 
      this.appointmenttime, 
      this.answers,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    saleId = json['sale_id'];
    code = json['code'];
    user = json['user'];
    organisationId = json['organisation_id'];
    cname = json['cname'];
    cphone = json['cphone'];
    caddress = json['caddress'];
    ccity = json['ccity'];
    cstate = json['cstate'];
    czipcode = json['czipcode'];
    cfirstname = json['cfirstname'];
    clastname = json['clastname'];
    cemail = json['cemail'];
    ccountry = json['ccountry'];
    ccounty = json['ccounty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    wherefrom = json['wherefrom'];
    parent = json['parent'];
    type = json['type'];
    status = json['status'];
    relation = json['relation'];
    confirmed = json['confirmed'];
    gift = json['gift'];
    leadtypeid = json['leadtypeid'];
    age = json['age'];
    referredby = json['referredby'];
    work = json['work'];
    eventname = json['eventname'];
    whereprospect = json['whereprospect'];
    oldcustomer = json['oldcustomer'];
    comment = json['comment'];
    sname = json['sname'];
    sfirstname = json['sfirstname'];
    slastname = json['slastname'];
    semail = json['semail'];
    sphone = json['sphone'];
    drawing = json['drawing'];
    dated = json['dated'];
    serialid = json['serialid'];
    orgname = json['orgname'];
    uname = json['uname'];
    adate = json['adate'];
    adate1 = json['adate1'];
    adate2 = json['adate2'];
    rdate = json['rdate'];
    rdate1 = json['rdate1'];
    rdate2 = json['rdate2'];
    timezone = json['timezone'];
    astatus = json['astatus'];
    leadtype = json['leadtype'];
    leadtypename = json['leadtypename'];
    dealer = json['dealer'];
    dealername = json['dealername'];
    comfirmedname = json['comfirmedname'];
    setname = json['setname'];
    appointmentdate = json['appointmentdate'];
    appointmenttime = json['appointmenttime'];

  }
  int? id;
  String? date;
  dynamic saleId;
  String? code;
  int? user;
  int? organisationId;
  String? cname;
  String? cphone;
  String? caddress;
  String? ccity;
  String? cstate;
  String? czipcode;
  String? cfirstname;
  String? clastname;
  dynamic cemail;
  dynamic ccountry;
  dynamic ccounty;
  String? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  int? wherefrom;
  String? parent;
  int? type;
  int? status;
  int? relation;
  int? confirmed;
  dynamic gift;
  int? leadtypeid;
  dynamic age;
  String? referredby;
  dynamic work;
  dynamic eventname;
  dynamic whereprospect;
  int? oldcustomer;
  dynamic comment;
  dynamic sname;
  dynamic sfirstname;
  dynamic slastname;
  dynamic semail;
  dynamic sphone;
  int? drawing;
  String? dated;
  dynamic serialid;
  String? orgname;
  String? uname;
  String? adate;
  String? adate1;
  String? adate2;
  dynamic rdate;
  dynamic rdate1;
  dynamic rdate2;
  dynamic timezone;
  int? astatus;
  int? leadtype;
  String? leadtypename;
  int? dealer;
  String? dealername;
  dynamic comfirmedname;
  dynamic setname;
  String? appointmentdate;
  String? appointmenttime;
  List<AnswerElement>? answers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['sale_id'] = saleId;
    map['code'] = code;
    map['user'] = user;
    map['organisation_id'] = organisationId;
    map['cname'] = cname;
    map['cphone'] = cphone;
    map['caddress'] = caddress;
    map['ccity'] = ccity;
    map['cstate'] = cstate;
    map['czipcode'] = czipcode;
    map['cfirstname'] = cfirstname;
    map['clastname'] = clastname;
    map['cemail'] = cemail;
    map['ccountry'] = ccountry;
    map['ccounty'] = ccounty;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['wherefrom'] = wherefrom;
    map['parent'] = parent;
    map['type'] = type;
    map['status'] = status;
    map['relation'] = relation;
    map['confirmed'] = confirmed;
    map['gift'] = gift;
    map['leadtypeid'] = leadtypeid;
    map['age'] = age;
    map['referredby'] = referredby;
    map['work'] = work;
    map['eventname'] = eventname;
    map['whereprospect'] = whereprospect;
    map['oldcustomer'] = oldcustomer;
    map['comment'] = comment;
    map['sname'] = sname;
    map['sfirstname'] = sfirstname;
    map['slastname'] = slastname;
    map['semail'] = semail;
    map['sphone'] = sphone;
    map['drawing'] = drawing;
    map['dated'] = dated;
    map['serialid'] = serialid;
    map['orgname'] = orgname;
    map['uname'] = uname;
    map['adate'] = adate;
    map['adate1'] = adate1;
    map['adate2'] = adate2;
    map['rdate'] = rdate;
    map['rdate1'] = rdate1;
    map['rdate2'] = rdate2;
    map['timezone'] = timezone;
    map['astatus'] = astatus;
    map['leadtype'] = leadtype;
    map['leadtypename'] = leadtypename;
    map['dealer'] = dealer;
    map['dealername'] = dealername;
    map['comfirmedname'] = comfirmedname;
    map['setname'] = setname;
    map['appointmentdate'] = appointmentdate;
    map['appointmenttime'] = appointmenttime;
    map['answers'] = answers!.map((v) => v.toJson()).toList();
      return map;
  }

}
class AnswerElement {
  String? code;
  int? questionId;
  dynamic answer;
  DateTime? createdAt;
  DateTime? updatedAt;
  Question? question;

  AnswerElement({
    this.code,
    this.questionId,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.question,
  });

  factory AnswerElement.fromJson(Map<String, dynamic> json) => AnswerElement(
    code: json["code"],
    questionId: json["question_id"],
    answer: json["answer"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    question: Question.fromJson(json["question"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "question_id": questionId,
    "answer": answer,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "question": question!.toJson(),
  };
}
class Question {
  int? id;
  String? question;
  int? status;
  int? mobile;
  int? web;
  int? appointment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? type;
  int? order;
  int? leadId;

  Question({
    this.id,
    this.question,
    this.status,
    this.mobile,
    this.web,
    this.appointment,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.order,
    this.leadId,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    question: json["question"],
    status: json["status"],
    mobile: json["mobile"],
    web: json["web"],
    appointment: json["appointment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    type: json["type"],
    order: json["order"],
    leadId: json["lead_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "status": status,
    "mobile": mobile,
    "web": web,
    "appointment": appointment,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "type": type,
    "order": order,
    "lead_id": leadId,
  };
}
