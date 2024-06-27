import 'package:wizzsales/model/OLD/contestModel/LeaderBoard.dart';


class Cont {
  int? id;
  String? name;
  String? startdate;
  String? enddate;
  String? subtitle;
  String? subtitle2;
  String? qualifytitle;
  String? image;
  String? winners;
  String? createdat;
  String? updatedat;
  String? period;
  String? rolename;
  String? startTime;
  String? endTime;
  String? promoter;
  String? participants;
  int? index;
  int? limit;
  int? approved;
  int? sold;
  int? runner;
  List<LeaderBoard>? leaderBoard;

  Cont(
      {this.id,
        this.name,
        this.startdate,
        this.enddate,
        this.subtitle,
        this.subtitle2,
        this.qualifytitle,
        this.image,
        this.winners,
        this.createdat,
        this.updatedat,
        this.period,
        this.rolename,
        this.startTime,
        this.endTime,
        this.limit,
        this.index,
        this.approved,
        this.promoter,
        this.participants,
        this.sold,
        this.runner,
        this.leaderBoard});

  factory Cont.fromJson(Map<String, dynamic> json) {
    return Cont(
      id: json['id'],
      name: json['name'],
      startdate: json['startdate'],
      enddate: json['enddate'],
      subtitle: json['subtitle'],
      subtitle2: json['subtitle2'],
      qualifytitle: json['qualifytitle'],
      image: json['image'],
      winners: json['winners'],
      createdat: json['created_at'],
      updatedat: json['updated_at'],
      period: json['period'],
      rolename: json['rolename'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      promoter: json['promoter'],
      participants: json['participants'],
      limit: json['limit'],
      index: json['index'],
      approved: json['approved'],
      sold: json['sold'],
      runner: json['runner'],
      leaderBoard: json["leaderBoard"] != null
          ? List<LeaderBoard>.from(
          json["leaderBoard"].map((x) => LeaderBoard.fromJson(x)))
          : null,
    );
  }
}
