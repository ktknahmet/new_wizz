class Lead {
  int? id;
  String? date;
  String? code;
  String? cname;
  String? cfirstname;
  String? clastname;
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
  String? ccounty;
  String? ccountry;
  String? referredby;
  String? age;
  String? work;
  String? eventname;
  String? whereprospect;

  Lead(
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
        this.ccity,
        this.referredby,
        this.age,
        this.work,
        this.eventname,
        this.whereprospect});

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
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
      ccity: json['ccity'],
      referredby: json['referredby'],
      age: json['age'],
      work: json['work'],
      eventname: json['eventname'],
      whereprospect: json['whereprospect'],
    );
  }
}
