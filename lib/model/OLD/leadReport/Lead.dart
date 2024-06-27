import 'package:wizzsales/model/OLD/leadReport/LeadReport.dart';

class Lead {
  int? id;
  dynamic date;
  int? saleId;
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
  String? cemail;
  String? ccountry;
  String? ccounty;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  int? wherefrom;
  String? parent;
  int? type;
  int? status;
  dynamic relation;
  int? confirmed;
  String? gift;
  int? leadtypeid;
  String? age;
  String? referredby;
  dynamic work;
  dynamic eventname;
  dynamic whereprospect;
  dynamic oldcustomer;
  dynamic comment;
  String? sname;
  String? sfirstname;
  String? slastname;
  String? semail;
  String? sphone;
  dynamic drawing;
  dynamic dated;
  dynamic serialid;
  dynamic orgname;
  dynamic uname;
  dynamic adate;
  dynamic adate1;
  dynamic adate2;
  dynamic rdate;
  dynamic rdate1;
  dynamic rdate2;
  dynamic timezone;
  dynamic astatus;
  dynamic leadtype;
  dynamic leadtypename;
  String? pcname;
  dynamic dealer;
  dynamic dealername;
  dynamic comfirmedname;
  dynamic setname;
  List<Answer?>? answers;
  dynamic astatusText;

  Lead({
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
    this.pcname,
    this.dealer,
    this.dealername,
    this.comfirmedname,
    this.setname,
    this.answers,
    this.astatusText,
  });

  factory Lead.fromJson(Map<String?, dynamic> json) => Lead(
    id: json["id"],
    date: json["date"],
    saleId: json["sale_id"],
    code: json["code"],
    user: json["user"],
    organisationId: json["organisation_id"],
    cname: json["cname"],
    cphone: json["cphone"],
    caddress: json["caddress"],
    ccity: json["ccity"],
    cstate: json["cstate"],
    czipcode: json["czipcode"],
    cfirstname: json["cfirstname"],
    clastname: json["clastname"],
    cemail: json["cemail"],
    ccountry: json["ccountry"],
    ccounty: json["ccounty"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    wherefrom: json["wherefrom"],
    parent: json["parent"],
    type: json["type"],
    status: json["status"],
    relation: json["relation"],
    confirmed: json["confirmed"],
    gift: json["gift"],
    leadtypeid: json["leadtypeid"],
    age: json["age"],
    referredby: json["referredby"],
    work: json["work"],
    eventname: json["eventname"],
    whereprospect: json["whereprospect"],
    oldcustomer: json["oldcustomer"],
    comment: json["comment"],
    sname: json["sname"],
    sfirstname: json["sfirstname"],
    slastname: json["slastname"],
    semail: json["semail"],
    sphone: json["sphone"],
    drawing: json["drawing"],
    dated: json["dated"],
    serialid: json["serialid"],
    orgname: json["orgname"],
    uname: json["uname"],
    adate: json["adate"],
    adate1: json["adate1"],
    adate2: json["adate2"],
    rdate: json["rdate"],
    rdate1: json["rdate1"],
    rdate2: json["rdate2"],
    timezone: json["timezone"],
    astatus: json["astatus"],
    leadtype: json["leadtype"],
    leadtypename: json["leadtypename"],
    pcname: json["pcname"],
    dealer: json["dealer"],
    dealername: json["dealername"],
    comfirmedname: json["comfirmedname"],
    setname: json["setname"],
    answers: json["answers"] != null ? List<Answer?>.from(json["answers"].map((x) => Answer.fromJson(x))) : [],
    astatusText: json["astatus_text"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "date": date,
    "sale_id": saleId,
    "code": code,
    "user": user,
    "organisation_id": organisationId,
    "cname": cname,
    "cphone": cphone,
    "caddress": caddress,
    "ccity": ccity,
    "cstate": cstate,
    "czipcode": czipcode,
    "cfirstname": cfirstname,
    "clastname": clastname,
    "cemail": cemail,
    "ccountry": ccountry,
    "ccounty": ccounty,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "wherefrom": wherefrom,
    "parent": parent,
    "type": type,
    "status": status,
    "relation": relation,
    "confirmed": confirmed,
    "gift": gift,
    "leadtypeid": leadtypeid,
    "age": age,
    "referredby": referredby,
    "work": work,
    "eventname": eventname,
    "whereprospect": whereprospect,
    "oldcustomer": oldcustomer,
    "comment": comment,
    "sname": sname,
    "sfirstname": sfirstname,
    "slastname": slastname,
    "semail": semail,
    "sphone": sphone,
    "drawing": drawing,
    "dated": dated,
    "serialid": serialid,
    "orgname": orgname,
    "uname": uname,
    "adate": adate,
    "adate1": adate1,
    "adate2": adate2,
    "rdate": rdate,
    "rdate1": rdate1,
    "rdate2": rdate2,
    "timezone": timezone,
    "astatus": astatus,
    "leadtype": leadtype,
    "leadtypename": leadtypename,
    "pcname": pcname,
    "dealer": dealer,
    "dealername": dealername,
    "comfirmedname": comfirmedname,
    "setname": setname,
    "answers": List<Answer>.from(answers!.map((x) => x!.toJson())),
    "astatus_text": astatusText,
  };
}