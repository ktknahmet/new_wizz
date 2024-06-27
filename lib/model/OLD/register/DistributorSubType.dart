class DistributorSubType {
  int? id;
  int? organisation_id;
  String? name;
  String? salesrolename;
  int? ranking;
  String? orgname;
  int? salesroleid;


  DistributorSubType({
    this.id,
    this.organisation_id,
    this.name,
    this.salesrolename,
    this.ranking,
    this.orgname,
    this.salesroleid
  });

  factory DistributorSubType.fromJson(Map<String, dynamic> json) {
    return DistributorSubType(
        id: json['id'],
        organisation_id: json['organisation_id'],
        name: json['name'],
        salesrolename: json['salesrolename'],
        ranking: json['ranking'],
        orgname: json['orgname'],
        salesroleid: json['salesroleid']
    );
  }

  Map toJson() {
    return {
      'id' : id,
      'organisation_id':organisation_id,
      'name' : name,
      'salesrolename' : salesrolename,
      'ranking' : ranking,
      'orgname' : orgname,
      'salesroleid' : salesroleid
    };
  }
}
