class Data {
  Data({
      this.id, 
      this.serialId, 
      this.customerId, 
      this.customerFirstname, 
      this.customerLastname, 
      this.customerPhone, 
      this.customerEmail, 
      this.organisationName, 
      this.enteredDate,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    serialId = json['serialId'];
    customerId = json['customerId'];
    customerFirstname = json['customerFirstname'];
    customerLastname = json['customerLastname'];
    customerPhone = json['customerPhone'];
    customerEmail = json['customerEmail'];
    organisationName = json['organisationName'];
    enteredDate = json['enteredDate'];
  }
  int? id;
  String? serialId;
  int? customerId;
  String? customerFirstname;
  String? customerLastname;
  String? customerPhone;
  String? customerEmail;
  String? organisationName;
  String? enteredDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['serialId'] = serialId;
    map['customerId'] = customerId;
    map['customerFirstname'] = customerFirstname;
    map['customerLastname'] = customerLastname;
    map['customerPhone'] = customerPhone;
    map['customerEmail'] = customerEmail;
    map['organisationName'] = organisationName;
    map['enteredDate'] = enteredDate;
    return map;
  }

}