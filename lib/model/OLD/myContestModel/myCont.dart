import 'package:wizzsales/model/OLD/myContestModel/Cont.dart';
import 'package:wizzsales/model/OLD/myContestModel/Report.dart';

class MyCont {
  List<Cont>? contests;
  List<Report>? report;

  MyCont({
    this.contests,
    this.report,
  });

  factory MyCont.fromJson(Map<String, dynamic> json) {
    return MyCont(
      contests: json["contests"] != null
          ? List<Cont>.from(
          json["contests"].map((x) => Cont.fromJson(x)))
          : null,
      report: json["report"] != null
          ? List<Report>.from(json["report"].map((x) => Report.fromJson(x)))
          : null,
    );
  }
}
