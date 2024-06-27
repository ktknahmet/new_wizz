// To parse this JSON data, do
//
//     final demoSale = demoSaleFromJson(jsonString);

import 'dart:convert';

DemoSale demoSaleFromJson(String str) => DemoSale.fromJson(json.decode(str));

String demoSaleToJson(DemoSale data) => json.encode(data.toJson());

class DemoSale {
  int? id;
  String? serialid;
  dynamic date;
  String? cname;
  String? cphone;
  String? caddress;
  int? distributor;
  dynamic office;
  dynamic dealer;
  dynamic da;
  dynamic dps;
  dynamic finance;
  int? status;
  int? user;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic leader;
  dynamic sm;
  dynamic distributorId;
  int? leadtype;
  String? ccity;
  String? cstate;
  String? czipcode;
  String? cfirstname;
  String? clastname;
  String? cemail;
  String? price;
  dynamic tax;
  int? organisationId;
  dynamic ccountry;
  String? ccounty;
  dynamic comision;
  dynamic financeby;
  String? netprice;
  dynamic financepercentage;
  dynamic reserve;
  dynamic deletedAt;
  dynamic approveDate;
  dynamic note;
  String? uuid;
  dynamic image;
  dynamic down;
  dynamic downType;
  dynamic fee1;
  dynamic fee2;
  int? wherefrom;
  dynamic otherDeductions;
  dynamic smcomision;
  dynamic dpscomision;
  dynamic leadercomision;
  dynamic dealercomision;
  dynamic dacomision;
  String? sname;
  dynamic sfirstname;
  dynamic slastname;
  dynamic semail;
  dynamic sphone;
  dynamic cash;
  dynamic frecv;
  dynamic cc;

  DemoSale({
    this.id,
    this.serialid,
    this.date,
    this.cname,
    this.cphone,
    this.caddress,
    this.distributor,
    this.office,
    this.dealer,
    this.da,
    this.dps,
    this.finance,
    this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.leader,
    this.sm,
    this.distributorId,
    this.leadtype,
    this.ccity,
    this.cstate,
    this.czipcode,
    this.cfirstname,
    this.clastname,
    this.cemail,
    this.price,
    this.tax,
    this.organisationId,
    this.ccountry,
    this.ccounty,
    this.comision,
    this.financeby,
    this.netprice,
    this.financepercentage,
    this.reserve,
    this.deletedAt,
    this.approveDate,
    this.note,
    this.uuid,
    this.image,
    this.down,
    this.downType,
    this.fee1,
    this.fee2,
    this.wherefrom,
    this.otherDeductions,
    this.smcomision,
    this.dpscomision,
    this.leadercomision,
    this.dealercomision,
    this.dacomision,
    this.sname,
    this.sfirstname,
    this.slastname,
    this.semail,
    this.sphone,
    this.cash,
    this.frecv,
    this.cc,
  });

  factory DemoSale.fromJson(Map<String, dynamic> json) => DemoSale(
    id: json["id"],
    serialid: json["serialid"],
    date: DateTime.parse(json["date"]),
    cname: json["cname"],
    cphone: json["cphone"],
    caddress: json["caddress"],
    distributor: json["distributor"],
    office: json["office"],
    dealer: json["dealer"],
    da: json["da"],
    dps: json["dps"],
    finance: json["finance"],
    status: json["status"],
    user: json["user"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    leader: json["leader"],
    sm: json["sm"],
    distributorId: json["distributor_id"],
    leadtype: json["leadtype"],
    ccity: json["ccity"],
    cstate: json["cstate"],
    czipcode: json["czipcode"],
    cfirstname: json["cfirstname"],
    clastname: json["clastname"],
    cemail: json["cemail"],
    price: json["price"],
    tax: json["tax"],
    organisationId: json["organisation_id"],
    ccountry: json["ccountry"],
    ccounty: json["ccounty"],
    comision: json["comision"],
    financeby: json["financeby"],
    netprice: json["netprice"],
    financepercentage: json["financepercentage"],
    reserve: json["reserve"],
    deletedAt: json["deleted_at"],
    approveDate: json["approve_date"],
    note: json["note"],
    uuid: json["uuid"],
    image: json["image"],
    down: json["down"],
    downType: json["down_type"],
    fee1: json["fee1"],
    fee2: json["fee2"],
    wherefrom: json["wherefrom"],
    otherDeductions: json["other_deductions"],
    smcomision: json["smcomision"],
    dpscomision: json["dpscomision"],
    leadercomision: json["leadercomision"],
    dealercomision: json["dealercomision"],
    dacomision: json["dacomision"],
    sname: json["sname"],
    sfirstname: json["sfirstname"],
    slastname: json["slastname"],
    semail: json["semail"],
    sphone: json["sphone"],
    cash: json["cash"],
    frecv: json["frecv"],
    cc: json["cc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serialid": serialid,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "cname": cname,
    "cphone": cphone,
    "caddress": caddress,
    "distributor": distributor,
    "office": office,
    "dealer": dealer,
    "da": da,
    "dps": dps,
    "finance": finance,
    "status": status,
    "user": user,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "leader": leader,
    "sm": sm,
    "distributor_id": distributorId,
    "leadtype": leadtype,
    "ccity": ccity,
    "cstate": cstate,
    "czipcode": czipcode,
    "cfirstname": cfirstname,
    "clastname": clastname,
    "cemail": cemail,
    "price": price,
    "tax": tax,
    "organisation_id": organisationId,
    "ccountry": ccountry,
    "ccounty": ccounty,
    "comision": comision,
    "financeby": financeby,
    "netprice": netprice,
    "financepercentage": financepercentage,
    "reserve": reserve,
    "deleted_at": deletedAt,
    "approve_date": approveDate,
    "note": note,
    "uuid": uuid,
    "image": image,
    "down": down,
    "down_type": downType,
    "fee1": fee1,
    "fee2": fee2,
    "wherefrom": wherefrom,
    "other_deductions": otherDeductions,
    "smcomision": smcomision,
    "dpscomision": dpscomision,
    "leadercomision": leadercomision,
    "dealercomision": dealercomision,
    "dacomision": dacomision,
    "sname": sname,
    "sfirstname": sfirstname,
    "slastname": slastname,
    "semail": semail,
    "sphone": sphone,
    "cash": cash,
    "frecv": frecv,
    "cc": cc,
  };
}
