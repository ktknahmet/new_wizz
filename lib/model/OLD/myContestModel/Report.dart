class Report {
  int? yasales;
  int? ysales;
  int? wasales;
  int? wsales;
  int? masales;
  int? msales;
  int? dasales;
  int? dsales;

  Report(
      {
        this.yasales,
        this.ysales,
        this.wasales,
        this.wsales,
        this.masales,
        this.msales,
        this.dasales,
        this.dsales,
      });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      yasales: json['yasales'],
      ysales: json['ysales'],
      wasales: json['wasales'],
      wsales: json['wsales'],
      masales: json['masales'],
      msales: json['msales'],
      dasales: json['dasales'],
      dsales: json['dsales'],
    );
  }
}
