import 'package:wizzsales/model/OLD/register/DistributorSubType.dart';

class Distributor {
  int? id;
  String? name;
  List<DistributorSubType>? dealer = [];
  List<DistributorSubType>? da = [];
  List<DistributorSubType>? leader = [];
  List<DistributorSubType>? sm = [];
  List<DistributorSubType>? dps = [];
  List<DistributorSubType>? finance = [];
  List<DistributorSubType>? leadtype = [];
  List<DistributorSubType>? downtype = [];

  Distributor(
      {this.id,
        this.name,
        this.dealer,
        this.da,
        this.leader,
        this.sm,
        this.dps,
        this.finance,
        this.leadtype,
        this.downtype});

  factory Distributor.fromJson(Map<dynamic, dynamic> json) {
    dynamic dealerList = json["list"]['dealer'];
    dynamic daList = json["list"]['da'];
    dynamic leaderList = json["list"]['leader'];
    dynamic smList = json["list"]['sm'];
    dynamic dpsList = json["list"]['dps'];
    dynamic financeList = json["list"]['finance'];
    dynamic leadtypeList = json["list"]['leadtype'];
    dynamic downtypeList = json["list"]['downtype'];
    Distributor dist = Distributor();
    try {
      return Distributor(
        id: json['id'],
        name: json['name'],
        dealer: dealerList != null && dealerList.isNotEmpty
            ? List<DistributorSubType>.from(dealerList.map((x) => DistributorSubType.fromJson(x)))
            : null,
        da: daList != null && daList.isNotEmpty
            ? List<DistributorSubType>.from(daList.map((x) => DistributorSubType.fromJson(x)))
            : null,
        leader: leaderList != null && leaderList.isNotEmpty
            ? List<DistributorSubType>.from(leaderList.map((x) => DistributorSubType.fromJson(x)))
            : null,
        sm: smList != null && smList.isNotEmpty
            ? List<DistributorSubType>.from(smList.map((x) => DistributorSubType.fromJson(x)))
            : null,
        dps: dpsList != null && dpsList.isNotEmpty
            ? List<DistributorSubType>.from(dpsList.map((x) => DistributorSubType.fromJson(x)))
            : null,
        finance: financeList != null && financeList.isNotEmpty
            ? List<DistributorSubType>.from(financeList.map((x) => DistributorSubType.fromJson(x)))
            : null,
        leadtype: leadtypeList != null && leadtypeList.isNotEmpty
            ? List<DistributorSubType>.from(leadtypeList.map((x) => DistributorSubType.fromJson(x)))
            : null,
        downtype: downtypeList != null && downtypeList.isNotEmpty
            ? List<DistributorSubType>.from(downtypeList.map((x) => DistributorSubType.fromJson(x)))
            : null,
      );
    } catch(e) {
      return dist;
    }
  }
}