class Organisation {
  Organisation({
      this.id, 
      this.name, 
      this.organisationCode, 
      this.organisationPerfix, 
      this.organisationInformation,});

  Organisation.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    organisationCode = json['organisationCode'];
    organisationPerfix = json['organisationPerfix'];
    organisationInformation = json['organisationInformation'];
  }
  int? id;
  dynamic name;
  dynamic organisationCode;
  dynamic organisationPerfix;
  dynamic organisationInformation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['organisationCode'] = organisationCode;
    map['organisationPerfix'] = organisationPerfix;
    map['organisationInformation'] = organisationInformation;
    return map;
  }

}