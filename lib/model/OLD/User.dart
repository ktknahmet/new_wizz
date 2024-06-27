class User {
  int? id;
  String? name;
  String? firstname;
  String? lastname;
  String? birthday;
  int? career;
  String? email;
  String? emailverifiedat;
  String? menuroles;
  String? createdat;
  String? updatedat;
  String? deletedat;
  List<String>? role;
  List<String>? role2;
  String? address;
  String? username;
  String? sgoal;
  String? goal;
  String? city;
  String? zipcode;
  String? lang;
  int? distributorid;
  String? image;
  String? phone;
  String? phone2;
  String? newrole;
  String? state;
  int? ranking;
  int? tshirtsize;
  User? distributor;
  User? supervisor;
  User? distributorc;
  User? supervisorc;
  String? country;
  String? county;
  String? assistboxUsername;
  String? assistboxPassword;
  String? assistboxToken;
  String? roleType;

  User(
      {this.id,
        this.name,
        this.firstname,
        this.lastname,
        this.birthday,
        this.email,
        this.emailverifiedat,
        this.menuroles,
        this.createdat,
        this.updatedat,
        this.deletedat,
        this.role,
        this.role2,
        this.address,
        this.username,
        this.sgoal,
        this.goal,
        this.city,
        this.zipcode,
        this.lang,
        this.distributorid,
        this.image,
        this.phone,
        this.phone2,
        this.newrole,
        this.state,
        this.ranking,
        this.tshirtsize,
        this.distributor,
        this.career,
        this.supervisor,
        this.distributorc,
        this.supervisorc,
        this.country,
        this.county,
        this.assistboxUsername,
        this.assistboxPassword,
        this.assistboxToken,
        this.roleType});

  factory User.fromJson(Map<String, dynamic> json) {
    String? phone2;
    if (json.containsKey('phone2')) phone2 = json['phone2'];
    return User(
      id: json['id'],
      name: json['name'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      birthday: json['birthday'],
      career: json['career'],
      email: json['email'],
      emailverifiedat: json['email_verified_at'],
      menuroles: json['menuroles'],
      createdat: json['created_at'],
      updatedat: json['updated_at'],
      deletedat: json['deleted_at'],
      role: json["role"] != null
          ? (json["role"] is String
          ? [json["role"] as String]
          : List<String>.from(json["role"]))
          : null,
      role2: json["role2"] != null
          ? List<String>.from(json["role2"].map((x) => x))
          : null,
      address: json['address'],
      username: json['username'],
      sgoal: json['sgoal'],
      goal: json['goal'],
      city: json['city'],
      zipcode: json['zipcode'],
      lang: json['lang'],
      distributorid: json['distributor_id'],
      image: json['image'],
      phone: json['phone'],
      phone2: phone2,
      newrole: json['newrole'],
      state: json['state'],
      ranking: json['ranking'],
      tshirtsize: json['tshirtsize'],
      distributor: json['distributor'] != null
          ? User.fromJson(json['distributor'])
          : null,
      supervisor:
      json['supervisor'] != null ? User.fromJson(json['supervisor']) : null,
      distributorc: json['distributorc'] != null
          ? User.fromJson(json['distributorc'])
          : null,
      supervisorc: json['supervisorc'] != null
          ? User.fromJson(json['supervisorc'])
          : null,
      country: json['country'],
      county: json['county'],
      assistboxUsername: json['assistbox_username'],
      assistboxPassword: json['assistbox_password'],
      assistboxToken: json['assistbox_token'],
      roleType: json['roleType'],
    );
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'firstname': firstname,
      'lastname': lastname,
      'birthday': birthday,
      'email': email,
      'emailverifiedat': emailverifiedat,
      'menuroles': menuroles,
      'createdat': createdat,
      'updatedat': updatedat,
      'deletedat': deletedat,
      'role': role.toString(),
      'address': address,
      'username': username,
      'sgoal': sgoal,
      'goal': goal,
      'city': city,
      'zipcode': zipcode,
      'lang': lang,
      'distributorid': distributorid,
      'image': image,
      'phone': phone,
      'phone2': phone2,
      'state': state,
      'ranking': ranking,
      'tshirtsize': tshirtsize,
      'country': country,
      'county': county,
      'assistbox_username': assistboxUsername,
      'assistbox_password': assistboxPassword,
      'assistbox_token': assistboxToken,
      'roleType':roleType
    };
  }
}
