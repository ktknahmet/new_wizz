class Codedraw {
  List<String>? cname = [];
  List<String>? cfirstname = [];
  List<String>? clastname = [];
  List<String>? date = [];
  List<String>? cphone = [];
  List<String>? caddress = [];

  Codedraw(
      {this.cname,
        this.cfirstname,
        this.clastname,
        this.date,
        this.cphone,
        this.caddress});

  factory Codedraw.fromJson(Map<String, dynamic> json) {
    return Codedraw(
      cname: json["cname"] != null
          ? List<String>.from(json["cname"].map((x) => x))
          : [],
      cfirstname: json["cfirstname"] != null
          ? List<String>.from(json["cfirstname"].map((x) => x))
          : [],
      clastname: json["clastname"] != null
          ? List<String>.from(json["clastname"].map((x) => x))
          : [],
      date: json["date"] != null
          ? List<String>.from(json["date"].map((x) => x))
          : [],
      cphone: json["cphone"] != null
          ? List<String>.from(json["cphone"].map((x) => x))
          : [],
      caddress: json["caddress"] != null
          ? List<String>.from(json["caddress"].map((x) => x))
          : [],
    );
  }
}
