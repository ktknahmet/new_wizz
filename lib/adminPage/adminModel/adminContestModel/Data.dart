import 'Qualifications.dart';

class Data {
  Data({
      this.id, 
      this.promoterId, 
      this.name, 
      this.startdate, 
      this.enddate, 
      this.status, 
      this.display, 
      this.destination, 
      this.organisationId, 
      this.image, 
      this.typeId, 
      this.salestatus, 
      this.prior, 
      this.sortId, 
      this.orgname, 
      this.statusName, 
      this.announcementyn, 
      this.adate, 
      this.atime, 
      this.notificationyn, 
      this.notification, 
      this.emailyn, 
      this.email, 
      this.astatus, 
      this.atz, 
      this.qualifications,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    promoterId = json['promoter_id'];
    name = json['name'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    status = json['status'];
    display = json['display'];
    destination = json['destination'];
    organisationId = json['organisation_id'];
    image = json['image'];
    typeId = json['type_id'];
    salestatus = json['salestatus'];
    prior = json['prior'];
    sortId = json['sort_id'];
    orgname = json['orgname'];
    statusName = json['status_name'];
    announcementyn = json['announcementyn'];
    adate = json['adate'];
    atime = json['atime'];
    notificationyn = json['notificationyn'];
    notification = json['notification'];
    emailyn = json['emailyn'];
    email = json['email'];
    astatus = json['astatus'];
    atz = json['atz'];
    if (json['qualifications'] != null) {
      qualifications = [];
      json['qualifications'].forEach((v) {
        qualifications?.add(Qualifications.fromJson(v));
      });
    }
  }
  int? id;
  int? promoterId;
  String? name;
  String? startdate;
  String? enddate;
  int? status;
  int? display;
  int? destination;
  int? organisationId;
  String? image;
  int? typeId;
  int? salestatus;
  dynamic prior;
  int? sortId;
  String? orgname;
  String? statusName;
  int? announcementyn;
  String? adate;
  String? atime;
  int? notificationyn;
  String? notification;
  int? emailyn;
  String? email;
  int? astatus;
  int? atz;
  List<Qualifications>? qualifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['promoter_id'] = promoterId;
    map['name'] = name;
    map['startdate'] = startdate;
    map['enddate'] = enddate;
    map['status'] = status;
    map['display'] = display;
    map['destination'] = destination;
    map['organisation_id'] = organisationId;
    map['image'] = image;
    map['type_id'] = typeId;
    map['salestatus'] = salestatus;
    map['prior'] = prior;
    map['sort_id'] = sortId;
    map['orgname'] = orgname;
    map['status_name'] = statusName;
    map['announcementyn'] = announcementyn;
    map['adate'] = adate;
    map['atime'] = atime;
    map['notificationyn'] = notificationyn;
    map['notification'] = notification;
    map['emailyn'] = emailyn;
    map['email'] = email;
    map['astatus'] = astatus;
    map['atz'] = atz;
    if (qualifications != null) {
      map['qualifications'] = qualifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}