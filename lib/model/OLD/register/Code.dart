class Code {
  List<String>? code = [];
  List<String>? email = [];
  List<String>? name = [];
  List<String>? password = [];
  List<String>? cpassword = [];
  List<String>? role = [];

  Code(
      {this.code,
        this.email,
        this.name,
        this.password,
        this.cpassword,
        this.role});

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      code: json["code"] != null
          ? List<String>.from(json["code"].map((x) => x))
          : [],
      email: json["email"] != null
          ? List<String>.from(json["email"].map((x) => x))
          : [],
      name: json["name"] != null
          ? List<String>.from(json["name"].map((x) => x))
          : [],
      password: json["password"] != null
          ? List<String>.from(json["password"].map((x) => x))
          : [],
      cpassword: json["c_password"] != null
          ? List<String>.from(json["c_password"].map((x) => x))
          : [],
      role: json["role"] != null
          ? List<String>.from(json["role"].map((x) => x))
          : [],
    );
  }
}
