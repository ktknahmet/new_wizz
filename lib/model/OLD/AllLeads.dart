class AllLeads {
  int? id;
  String? name;
  int? status;
  int? type;
  int? fillfromlocation;
  int? showaddress;

  AllLeads({
    this.id,
    this.name,
    this.status,
    this.type,
    this.fillfromlocation,
    this.showaddress,
  });

  factory AllLeads.fromJson(Map<String, dynamic> json) {
    return AllLeads(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      type: json['type'],
      fillfromlocation: json['fillfromlocation'],
      showaddress: json['showaddress'],
    );
  }
}
