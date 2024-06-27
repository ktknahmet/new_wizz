
class Draw {
  int? id;
  String? date;
  String? code;
  String? cname;
  String? cphone;
  String? cphone2;
  String? cemail;

  String? sname;
  String? sfirstname;
  String? slastname;
  String? sphone;
  String? sphone2;
  String? semail;

  String? caddress;
  String? cstate;
  String? ccity;
  String? czipcode;
  String? cfirstname;
  String? clastname;
  String? ccounty;
  String? ccountry;

  Draw(
      {this.id,
        this.date,
        this.code,
        this.cname,
        this.cfirstname,
        this.clastname,
        this.cphone,
        this.cphone2,
        this.sname,
        this.sfirstname,
        this.slastname,
        this.sphone,
        this.sphone2,
        this.semail,
        this.caddress,
        this.ccounty,
        this.ccountry,
        this.cemail,
        this.cstate,
        this.czipcode,
        this.ccity});

  factory Draw.fromJson(Map<String, dynamic> json) {
    return Draw(
        id: json['id'],
        code: json['code'],
        date: json['date'],
        cname: json['cname'],
        cfirstname: json['cfirstname'],
        clastname: json['clastname'],
        cphone: json['cphone'],
        cphone2: json['cphone2'],
        sname: json['sname'],
        sfirstname: json['sfirstname'],
        slastname: json['slastname'],
        sphone: json['sphone'],
        sphone2: json['sphone2'],
        semail: json['semail'],
        caddress: json['caddress'],
        ccounty: json['ccounty'],
        ccountry: json['ccountry'],
        cemail: json['cemail'],
        cstate: json['cstate'],
        czipcode: json['czipcode'],
        ccity: json['ccity']);
  }
}