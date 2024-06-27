import 'dart:convert' show json;

List<CompetitionsReports> competitionsReportsFromJson(String str) => List<CompetitionsReports>.from(json.decode(str).map((x) => CompetitionsReports.fromJson(x)));

String competitionsReportsToJson(List<CompetitionsReports> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompetitionsReports {
  List<Winners>? winners;
  String? title;
  List<String>? subtitle;

  CompetitionsReports({this.winners, this.title, this.subtitle});

  CompetitionsReports.fromJson(Map<String, dynamic> json) {
    if (json['winners'] != null) {
      winners = <Winners>[];
      json['winners'].forEach((v) {
        winners!.add(Winners.fromJson(v));
      });
    }
    title = json['title'];
    subtitle = json['subtitle'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (winners != null) {
      data['winners'] = winners!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    data['subtitle'] = subtitle;
    return data;
  }
}

class Winners {
  String? name;
  String? location;
  int? total;
  String? qualification;

  Winners({this.name, this.location, this.total, this.qualification});

  Winners.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    total = json['total'];
    qualification = json['qualification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['location'] = location;
    data['total'] = total;
    data['qualification'] = qualification;
    return data;
  }
}
