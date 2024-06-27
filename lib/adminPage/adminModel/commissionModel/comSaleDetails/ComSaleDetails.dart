class ComSaleDetails {
  ComSaleDetails({
     this.id,
     this.serialid,
     this.date,
     this.cname,
     this.cfirstname,
     this.clastname,
     this.cphone,
     this.caddress,
     this.office,
     this.distributor,
     this.organisationId,
     this.dealer,
     this.da,
     this.dps,
     this.finance,
     this.status,
     this.user,
     this.leader,
     this.sm,
     this.leadtype,
     this.ccity,
     this.cstate,
     this.czipcode,
     this.cemail,
     this.price,
     this.tax,
     this.ccountry,
     this.ccounty,
     this.comision,
     this.financeby,
     this.netprice,
     this.financepercentage,
     this.reserve,
     this.note,
     this.fee1,
     this.fee2,
     this.down,
     this.downType,
     this.image,
     this.otherDeductions,
     this.cash,
     this.frecv,
     this.cc,
     this.receiveAmount,
     this.latitude,
     this.longitude,
  });

   dynamic id;
   String? serialid;
   dynamic date;
   String? cname;
   String? cfirstname;
   String? clastname;
   String? cphone;
   String? caddress;
   dynamic office;
   Distributor? distributor;
   dynamic organisationId;
   Distributor? dealer;
   Distributor? da;
   Distributor? dps;
   dynamic finance;
   dynamic status;
   Distributor? user;
   Distributor? leader;
   Distributor?  sm;
   dynamic leadtype;
   String? ccity;
   String? cstate;
   String? czipcode;
   String? cemail;
   dynamic price;
   dynamic tax;
   String? ccountry;
   String? ccounty;
   dynamic comision;
   dynamic financeby;
   dynamic netprice;
   dynamic financepercentage;
   dynamic reserve;
   String? note;
   String? fee1;
   String? fee2;
   String? down;
   String? downType;
   String? image;
   String? otherDeductions;
   dynamic cash;
   dynamic frecv;
   dynamic cc;
   dynamic receiveAmount;
   dynamic latitude;
   dynamic longitude;

  factory ComSaleDetails.fromJson(Map<String, dynamic> json){
    return ComSaleDetails(
      id: json["id"],
      serialid: json["serialid"],
      date: json["date"],
      cname: json["cname"],
      cfirstname: json["cfirstname"],
      clastname: json["clastname"],
      cphone: json["cphone"],
      caddress: json["caddress"],
      office: json["office"],
      distributor: json["distributor"] == null ? null  : Distributor.fromJson(json["distributor"]),
      organisationId: json["organisation_id"],
      dealer: json["dealer"] == null ? null  : Distributor.fromJson(json["dealer"]),
      da: json["da"] == null ? null  : Distributor.fromJson(json["da"]),
      dps: json["dps"] == null ? null : Distributor.fromJson(json["dps"]),
      finance: json["finance"],
      status: json["status"],
      user: json["user"] == null ? null  : Distributor.fromJson(json["user"]),
      leader: json["leader"] == null ? null  : Distributor.fromJson(json["leader"]),
      sm: json["sm"] == null ? null  : Distributor.fromJson(json["sm"]),
      leadtype: json["leadtype"],
      ccity: json["ccity"],
      cstate: json["cstate"],
      czipcode: json["czipcode"],
      cemail: json["cemail"],
      price: json["price"],
      tax: json["tax"],
      ccountry: json["ccountry"],
      ccounty: json["ccounty"],
      comision: json["comision"],
      financeby: json["financeby"],
      netprice: json["netprice"],
      financepercentage: json["financepercentage"],
      reserve: json["reserve"],
      note: json["note"],
      fee1: json["fee1"],
      fee2: json["fee2"],
      down: json["down"],
      downType: json["down_type"],
      image: json["image"],
      otherDeductions: json["other_deductions"],
      cash: json["cash"],
      frecv: json["frecv"],
      cc: json["cc"],
      receiveAmount: json["receive_amount"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "serialid": serialid,
    "date": date,
    "cname": cname,
    "cfirstname": cfirstname,
    "clastname": clastname,
    "cphone": cphone,
    "caddress": caddress,
    "office": office,
    "distributor": distributor?.toJson(),
    "organisation_id": organisationId,
    "dealer": dealer?.toJson(),
    "da": da?.toJson(),
    "dps":  dps?.toJson(),
    "finance": finance,
    "status": status,
    "user":  user?.toJson(),
    "leader": leader?.toJson(),
    "sm": sm!.toJson(),
    "leadtype": leadtype,
    "ccity": ccity,
    "cstate": cstate,
    "czipcode": czipcode,
    "cemail": cemail,
    "price": price,
    "tax": tax,
    "ccountry": ccountry,
    "ccounty": ccounty,
    "comision": comision,
    "financeby": financeby,
    "netprice": netprice,
    "financepercentage": financepercentage,
    "reserve": reserve,
    "note": note,
    "fee1": fee1,
    "fee2": fee2,
    "down": down,
    "down_type": downType,
    "image": image,
    "other_deductions": otherDeductions,
    "cash": cash,
    "frecv": frecv,
    "cc": cc,
    "receive_amount": receiveAmount,
    "latitude": latitude,
    "longitude": longitude,
  };

}


class Distributor {
  Distributor({
    this.id,
    this.userId,
    this.organisationId,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.menuroles,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.address,
    this.username,
    this.city,
    this.zipcode,
    this.lang,
    this.createdBy,
    this.image,
    this.phone,
    this.state,
    this.statusId,
    this.newrole,
    this.ranking,
    this.firstname,
    this.lastname,
    this.country,
    this.county,
    this.exSales,
    this.salesOrganisationId,
    this.goal,
    this.notification,
    this.startranking,
    this.newexSales,
    this.newdealer,
    this.newda,
    this.birthday,
    this.officeSales,
    this.mainprofile,
  });

  dynamic id;
  dynamic userId;
  dynamic organisationId;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic password;
  dynamic menuroles;
  dynamic rememberToken;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String? address;
  String? username;
  String? city;
  String? zipcode;
  dynamic lang;
  dynamic createdBy;
  String? image;
  String? phone;
  String? state;
  dynamic statusId;
  dynamic newrole;
  dynamic ranking;
  String? firstname;
  String? lastname;
  String? country;
  String? county;
  dynamic exSales;
  dynamic salesOrganisationId;
  dynamic goal;
  dynamic notification;
  dynamic startranking;
  dynamic newexSales;
  dynamic newdealer;
  dynamic newda;
  dynamic birthday;
  dynamic officeSales;
  dynamic mainprofile;

  factory Distributor.fromJson(Map<String, dynamic> json){
    return Distributor(
      id: json["id"],
      userId: json["user_id"],
      organisationId: json["organisation_id"],
      name: json["name"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      password: json["password"],
      menuroles: json["menuroles"],
      rememberToken: json["remember_token"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      deletedAt: json["deleted_at"],
      address: json["address"],
      username: json["username"],
      city: json["city"],
      zipcode: json["zipcode"],
      lang: json["lang"],
      createdBy: json["created_by"],
      image: json["image"],
      phone: json["phone"],
      state: json["state"],
      statusId: json["status_id"],
      newrole: json["newrole"],
      ranking: json["ranking"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      country: json["country"],
      county: json["county"],
      exSales: json["ex_sales"],
      salesOrganisationId: json["sales_organisation_id"],
      goal: json["goal"],
      notification: json["notification"],
      startranking: json["startranking"],
      newexSales: json["newex_sales"],
      newdealer: json["newdealer"],
      newda: json["newda"],
      birthday: json["birthday"],
      officeSales: json["office_sales"],
      mainprofile: json["mainprofile"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "organisation_id": organisationId,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "menuroles": menuroles,
    "remember_token": rememberToken,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "address": address,
    "username": username,
    "city": city,
    "zipcode": zipcode,
    "lang": lang,
    "created_by": createdBy,
    "image": image,
    "phone": phone,
    "state": state,
    "status_id": statusId,
    "newrole": newrole,
    "ranking": ranking,
    "firstname": firstname,
    "lastname": lastname,
    "country": country,
    "county": county,
    "ex_sales": exSales,
    "sales_organisation_id": salesOrganisationId,
    "goal": goal,
    "notification": notification,
    "startranking": startranking,
    "newex_sales": newexSales,
    "newdealer": newdealer,
    "newda": newda,
    "birthday": birthday,
    "office_sales": officeSales,
    "mainprofile": mainprofile,
  };

}


