import 'dart:convert';
import 'dart:io';

import 'package:wizzsales/model/OLD/LeadQuestion.dart';
import 'package:wizzsales/model/OLD/User.dart';

String saleToJson(Sale data) => json.encode(data.toJson());


class Sale {
  int? id;
  List<LeadsQuestion>? salesQuestion;
  int? appointment;
  String? serialid;
  String? date;
  String? cname;
  String? cfirstname;
  String? clastname;
  String? cphone;
  String? cCode;
  String? cphone2;
  String? caddress;
  String? ccounty;
  String? ccountry;
  String? cemail;
  String? sname;
  String? sfirstname;
  String? slastname;
  String? sphone;
  String? sphone2;
  String? semail;
  String? cstate;
  String? ccity;
  String? czipcode;
  String? office;
  String? note;
  User? distributor = User();
  User? dealer = User();
  User? da = User();
  User? dps = User();
  int? finance;
  String? price;
  String? down;
  int? downType;
  String? fee1;
  String? fee2;
  String? comision;
  String? financeby;
  String? reserve;
  String? otherDeductions;
  String? netprice;
  String? tax;
  String? financepercentage;
  int? status;
  int? leadtype;
  String? image;
  dynamic cash;
  dynamic frecv;
  dynamic cc;
  dynamic receive_amount;
  User? user = User();
  User? leader = User();
  User? sm = User();
  int? color;
  File? imageFile;
  int? selectedCustomerType;
  String? totalPrice;
  String? drawCode;

  Sale(
      {this.id,
        this.salesQuestion,
        this.appointment,
        this.serialid,
        this.date,
        this.cname,
        this.cfirstname,
        this.clastname,
        this.cphone,
        this.cCode,
        this.cphone2,
        this.cemail,
        this.sname,
        this.sfirstname,
        this.slastname,
        this.sphone,
        this.sphone2,
        this.semail,
        this.caddress,
        this.note,
        this.ccounty,
        this.ccountry,
        this.office,
        this.distributor,
        this.dealer,
        this.da,
        this.dps,
        this.finance,
        this.status,
        this.user,
        this.leader,
        this.sm,
        this.leadtype,
        this.price,
        this.down,
        this.downType,
        this.fee1,
        this.fee2,
        this.comision,
        this.financeby,
        this.financepercentage,
        this.reserve,
        this.otherDeductions,
        this.netprice,
        this.tax,
        this.cstate,
        this.czipcode,
        this.image,
        this.cc,
        this.cash,
        this.frecv,
        this.receive_amount,
        this.ccity});


  Map toJson() {
    return {
      "id": id,
      "serialid":serialid,
      "date": date,
      "cname": cname,
      "cfirstname": cfirstname,
      "clastname": clastname,
      "cphone": cphone,
      "cphone2": cphone2,
      "cemail": cemail,
      "sname": sname,
      "sfirstname": sfirstname,
      "slastname": slastname,
      "sphone": sphone,
      "sphone2": sphone2,
      "semail": semail,
      "caddress": caddress,
      "note": note,
      "ccounty": ccounty,
      "ccountry": ccountry,
      "office": office,
      "distributor": distributor != null && distributor != ""
          ? distributor != 0 :null,

      "dealer": dealer != null && dealer != ""
          ? dealer != 0: null,
      "da": da != null && da != ""
          ? da != 0 : null,
      "dps": dps != null && dps != ""
          ? dps != 0 : null,
      "finance": finance,
      "leadtype": leadtype,
      "status":status,
      "user": user != null && user != "",
      "leader": leader != null && leader != ""
          ? leader!= 0 : null,
      "sm": sm != null && sm != ""
          ? sm != 0 : null,
      "price": price,
      "down": down,
      "downType": downType,
      "image": image,
      "cash": cash,
      "frecv": frecv,
      "cc": cc,
      "receive_amount": receive_amount,
      "fee1": fee1,
      "fee2": fee2,
      "comision": comision,
      "financeby": financeby,
      "reserve": reserve,
      "otherDeductions": otherDeductions,
      "netprice": netprice,
      "tax": tax,
      "financepercentage": financepercentage,
      "cstate": cstate,
      "czipcode": czipcode,
      "ccity": ccity
    };
  }


  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
        id: json['id'],
        serialid: json['serialid'],
        date: json['date'],
        cname: json['cname'],
        cfirstname: json['cfirstname'],
        clastname: json['clastname'],
        cphone: json['cphone'],
        cphone2: json['cphone2'],
        cemail: json['cemail'],
        sname: json['sname'],
        sfirstname: json['sfirstname'],
        slastname: json['slastname'],
        sphone: json['sphone'],
        sphone2: json['sphone2'],
        semail: json['semail'],
        caddress: json['caddress'],
        note: json['note'],
        ccounty: json['ccounty'],
        ccountry: json['ccountry'],
        office: json['office'],
        distributor: json['distributor'] != null && json['distributor'] != ""
            ? json['distributor'] != 0
            ? User.fromJson(json['distributor'])
            : User(id: 0, firstname: "None")
            : null,
        dealer: json['dealer'] != null && json['dealer'] != ""
            ? json['dealer'] != 0
            ? User.fromJson(json['dealer'])
            : User(id: 0, firstname: "None")
            : null,
        da: json['da'] != null && json['da'] != ""
            ? json['da'] != 0
            ? User.fromJson(json['da'])
            : User(id: 0, firstname: "None")
            : null,
        dps: json['dps'] != null && json['dps'] != ""
            ? json['dps'] != 0
            ? User.fromJson(json['dps'])
            : User(id: 0, firstname: "None")
            : null,
        finance: json['finance'],
        leadtype: json['leadtype'],
        status: json['status'],
        user: json['user'] != null && json['user'] != ""
            ? User.fromJson(json['user'])
            : null,
        leader: json['leader'] != null && json['leader'] != ""
            ? json['leader'] != 0
            ? User.fromJson(json['leader'])
            : User(id: 0, firstname: "None")
            : null,
        sm: json['sm'] != null && json['sm'] != ""
            ? json['sm'] != 0
            ? User.fromJson(json['sm'])
            : User(id: 0, firstname: "None")
            : null,
        price: json['price'],
        down: json['down'],
        downType: json['down_type'],
        image: json['image'],
        cash: json['cash'],
        frecv: json['frecv'],
        cc: json['cc'],
        receive_amount: json['receive_amount'],
        fee1: json['fee1'],
        fee2: json['fee2'],
        comision: json['comision'],
        financeby: json['financeby'],
        reserve: json['reserve'],
        otherDeductions: json['other_deductions'],
        netprice: json['netprice'],
        tax: json['tax'],
        financepercentage: json['financepercentage'],
        cstate: json['cstate'],
        czipcode: json['czipcode'],
        ccity: json['ccity']);

  }
}
