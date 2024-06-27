

import 'package:wizzsales/adminPage/adminModel/commissionModel/comDetails.dart';
import 'package:wizzsales/model/goals/UserGoals.dart';

class DetailReportModel {
  DetailReportModel({
     this.salesReport,
     this.leadsReport,
     this.salesAvgReport,
     this.goalsReport,
     this.demoReport,
     this.demoReportV2,
     this.userGoals,
     this.commission

  });
   SalesReport? salesReport;
   LeadsReport? leadsReport;
   SalesAvgReport? salesAvgReport;
   GoalsReport? goalsReport;
   DemoReport? demoReport;
   DemoReportV2? demoReportV2;
   List<UserGoals>? userGoals;
   ComDetails? commission;


  DetailReportModel.fromJson(Map<String, dynamic> json){
    salesReport = SalesReport.fromJson(json['sales_report']);
    leadsReport = LeadsReport.fromJson(json['leads_report']);
    salesAvgReport = SalesAvgReport.fromJson(json['sales_avg_report']);
    goalsReport = GoalsReport.fromJson(json['goals_report']);
    demoReport = DemoReport.fromJson(json['demo_report']);
    demoReportV2 = DemoReportV2.fromJson(json['demo_report_v2']);
    userGoals = List.from(json['user_goals']).map((e)=>UserGoals.fromJson(e)).toList();
    commission = ComDetails.fromJson(json['commission']);

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sales_report'] = salesReport!.toJson();
    data['leads_report'] = leadsReport!.toJson();
    data['sales_avg_report'] = salesAvgReport!.toJson();
    data['goals_report'] = goalsReport!.toJson();
    data['demo_report'] = demoReport!.toJson();
    data['demo_report_v2'] = demoReportV2!.toJson();
    data['user_goals'] = userGoals!.map((e)=>e.toJson()).toList();
    data['commission'] = commission!.toJson();
    return data;
  }
}

class SalesReport {
  SalesReport({
     this.totalPrice,
     this.totalNetPrice,
     this.averagePrice,
     this.averageNetPrice,
     this.totalApprovedSales,
     this.yesterdayCount,
     this.yesterdayHourlyCount,
     this.todayCount,
     this.todayHourlyCount,
     this.weeklyCount,
     this.weeklyDayCount,
     this.monthlyCount,
     this.monthlyDayCount,
     this.annualCount,
     this.annualMonthCount,
     this.lastMonthCount,
     this.lastMonthlyDayCount
  });
   dynamic totalPrice;
   dynamic totalNetPrice;
   dynamic averagePrice;
   dynamic averageNetPrice;
   dynamic totalApprovedSales;
   dynamic yesterdayCount;
   List<YesterdayHourlyCount>? yesterdayHourlyCount;
   dynamic todayCount;
   List<YesterdayHourlyCount>? todayHourlyCount;
   dynamic weeklyCount;
   List<WeeklyDayCount>? weeklyDayCount;
   dynamic monthlyCount;
   List<MonthlyDayCount>? monthlyDayCount;
   dynamic annualCount;
   List<AnnualMonthCount>? annualMonthCount;
   dynamic lastMonthCount;
   List<MonthlyDayCount>? lastMonthlyDayCount;
  SalesReport.fromJson(Map<String, dynamic> json){
    totalPrice = json['totalPrice'];
    totalNetPrice = json['totalNetPrice'];
    averagePrice = json['averagePrice'];
    averageNetPrice = json['averageNetPrice'];
    totalApprovedSales = json['totalApprovedSales'];
    yesterdayCount = json['yesterday_count'];
    yesterdayHourlyCount = List.from(json['yesterday_hourly_count']).map((e)=>YesterdayHourlyCount.fromJson(e)).toList();
    todayCount = json['today_count'];
    todayHourlyCount = List.from(json['today_hourly_count']).map((e)=>YesterdayHourlyCount.fromJson(e)).toList();
    weeklyCount = json['weekly_count'];
    weeklyDayCount = List.from(json['weekly_day_count']).map((e)=>WeeklyDayCount.fromJson(e)).toList();
    monthlyCount = json['monthly_count'];
    monthlyDayCount = List.from(json['monthly_day_count']).map((e)=>MonthlyDayCount.fromJson(e)).toList();
    annualCount = json['annual_count'];
    annualMonthCount = List.from(json['annual_month_count']).map((e)=>AnnualMonthCount.fromJson(e)).toList();
    lastMonthCount = json['lastmonthly_count'];
    lastMonthlyDayCount = List.from(json['lastmonthly_day_count']).map((e)=>MonthlyDayCount.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalPrice'] = totalPrice;
    data['totalNetPrice'] = totalNetPrice;
    data['averagePrice'] = averagePrice;
    data['averageNetPrice'] = averageNetPrice;
    data['totalApprovedSales'] = totalApprovedSales;
    data['yesterday_count'] = yesterdayCount;
    data['yesterday_hourly_count'] = yesterdayHourlyCount!.map((e)=>e.toJson()).toList();
    data['today_count'] = todayCount;
    data['today_hourly_count'] =todayHourlyCount!.map((e)=>e.toJson()).toList();
    data['weekly_count'] = weeklyCount;
    data['weekly_day_count'] = weeklyDayCount!.map((e)=>e.toJson()).toList();
    data['monthly_count'] = monthlyCount;
    data['monthly_day_count'] = monthlyDayCount!.map((e)=>e.toJson()).toList();
    data['annual_count'] = annualCount;
    data['annual_month_count'] = annualMonthCount!.map((e)=>e.toJson()).toList();
    data['lastmonthly_count'] = lastMonthCount;
    data['lastmonthly_day_count'] = lastMonthlyDayCount!.map((e)=>e.toJson()).toList();
    return data;
  }
}

class YesterdayHourlyCount {
  YesterdayHourlyCount({
    this.hour,
    this.count,
    this.totalPrice,
    this.totalNetPrice,
    this.averagePrice,
    this.averageNetPrice,
  });
   String? hour;
   int? count;
   dynamic totalPrice;
   dynamic totalNetPrice;
   dynamic averagePrice;
   dynamic averageNetPrice;

  YesterdayHourlyCount.fromJson(Map<String, dynamic> json){
    hour = json['hour'];
    count = json['count'];
    totalPrice = json['total_price'];
    totalNetPrice = json['total_netprice'];
    averagePrice = json['avg_price'];
    averageNetPrice = json['avg_netprice'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hour'] = hour;
    data['count'] = count;
    data['total_price'] = totalPrice;
    data['total_netprice'] = totalNetPrice;
    data['avg_price'] = averagePrice;
    data['avg_netprice'] = averageNetPrice;
    return data;
  }
}

class WeeklyDayCount {
  WeeklyDayCount({
     this.day,
     this.count,
     this.totalPrice,
     this.totalNetPrice,
     this.averagePrice,
     this.averageNetPrice,
  });
   String? day;
   dynamic count;
   dynamic totalPrice;
   dynamic totalNetPrice;
   dynamic averagePrice;
   dynamic averageNetPrice;

  WeeklyDayCount.fromJson(Map<String, dynamic> json){
    day = json['day'];
    count = json['count'];
    totalPrice = json['total_price'];
    totalNetPrice = json['total_netprice'];
    averagePrice = json['avg_price'];
    averageNetPrice = json['avg_netprice'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['count'] = count;
    data['total_price'] = totalPrice;
    data['total_netprice'] = totalNetPrice;
    data['avg_price'] = averagePrice;
    data['avg_netprice'] = averageNetPrice;
    return data;
  }
}

class MonthlyDayCount {
  MonthlyDayCount({
     this.day,
     this.count,
     this.totalPrice,
     this.totalNetPrice,
     this.averagePrice,
     this.averageNetPrice,
  });
   String? day;
   dynamic count;
   dynamic totalPrice;
   dynamic totalNetPrice;
   dynamic averagePrice;
   dynamic averageNetPrice;

  MonthlyDayCount.fromJson(Map<String, dynamic> json){
    day = json['day'];
    count = json['count'];
    totalPrice = json['total_price'];
    totalNetPrice = json['total_netprice'];
    averagePrice = json['avg_price'];
    averageNetPrice = json['avg_netprice'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['count'] = count;
    data['total_price'] = totalPrice;
    data['total_netprice'] = totalNetPrice;
    data['avg_price'] = averagePrice;
    data['avg_netprice'] = averageNetPrice;
    return data;
  }
}

class AnnualMonthCount {
  AnnualMonthCount({
     this.month,
     this.startDate,
     this.endDate,
     this.count,
     this.totalPrice,
     this.totalNetPrice,
     this.averagePrice,
     this.averageNetPrice,
  });
   String? month;
   String? startDate;
   String? endDate;
   dynamic count;
   dynamic totalPrice;
   dynamic totalNetPrice;
   dynamic averagePrice;
   dynamic averageNetPrice;

  AnnualMonthCount.fromJson(Map<String, dynamic> json){
    month = json['month'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    count = json['count'];
    totalPrice = json['total_price'];
    totalNetPrice = json['total_netprice'];
    averagePrice = json['avg_price'];
    averageNetPrice = json['avg_netprice'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['month'] = month;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['count'] = count;
    data['total_price'] = totalPrice;
    data['total_netprice'] = totalNetPrice;
    data['avg_price'] = averagePrice;
    data['avg_netprice'] = averageNetPrice;
    return data;
  }
}

class LeadsReport {
  LeadsReport({
     this.leadReports,
     this.allTime,
  });
   List<LeadReports>? leadReports;
   AllTime? allTime;

  LeadsReport.fromJson(Map<String, dynamic> json){
    leadReports = List.from(json['lead_reports']).map((e)=>LeadReports.fromJson(e)).toList();
    allTime = AllTime.fromJson(json['all_time']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lead_reports'] = leadReports!.map((e)=>e.toJson()).toList();
    data['all_time'] = allTime!.toJson();
    return data;
  }
}

class LeadReports {
  LeadReports({
    this.leadTypeName,
    this.totalNotContactedLead,
    this.totalAppointmentSet,
    this.totalSold,
    this.lastMonthNotContacted,
    this.lastMonthlyNotContactedDayCount,
    this.lastMonthAppointmentSet,
    this.lastMonthlyAppointmentSetDayCount,
    this.lastMonthSaleSold,
    this.lastMonthlySaleSoldDayCount,
    this.annualyNotContacted,
    this.annualyNotContactedMonthly,
    this.annualyAppointmentSet,
    this.annualyAppointmentSetMonthly,
    this.annualySold,
    this.annualySoldMonthly,
    this.monthlyNotContacted,
    this.monthlyNotContactedDayCount,
    this.monthlyAppointmentSet,
    this.monthlyAppointmentSetDayCount,
    this.monthlySaleSold,
    this.monthlySaleSoldDayCount,
    this.weeklyNotContacted,
    this.weeklyNotContactedDayCount,
    this.weeklyAppointmentSet,
    this.weeklyAppointmentSetDayCount,
    this.weeklySold,
    this.weeklySoldDayCount,
    this.daliyNotContacted,
    this.daliyAppointmentSet,
    this.daliyAppointmentSetHourly,
    this.daliySold,
    this.yesterdayNotContacted,
    this.yesterdayAppointmentSet,
    this.yesterdayAppointmentSetHourly,
  });
  String? leadTypeName;
  int? totalNotContactedLead;
  int? totalAppointmentSet;
  int? totalSold;
  int? lastMonthNotContacted;
  List<MonthlyNotContactedDayCount>? lastMonthlyNotContactedDayCount;
  int? lastMonthAppointmentSet;
  List<MonthlyAppointmentSetDayCount>? lastMonthlyAppointmentSetDayCount;
  int? lastMonthSaleSold;
  List<MonthlySaleSoldDayCount>? lastMonthlySaleSoldDayCount;
  int? annualyNotContacted;
  List<AnnualyNotContactedMonthly>? annualyNotContactedMonthly;
  int? annualyAppointmentSet;
  List<AnnualyAppointmentSetMonthly>? annualyAppointmentSetMonthly;
  int?  annualySold;
  List<AnnualySoldMonthly>? annualySoldMonthly;
  int? monthlyNotContacted;
  List<MonthlyNotContactedDayCount>? monthlyNotContactedDayCount;
  int? monthlyAppointmentSet;
  List<MonthlyAppointmentSetDayCount>? monthlyAppointmentSetDayCount;
  int? monthlySaleSold;
  List<MonthlySaleSoldDayCount>? monthlySaleSoldDayCount;
  int? weeklyNotContacted;
  List<WeeklyNotContactedDayCount>? weeklyNotContactedDayCount;
  int? weeklyAppointmentSet;
  List<WeeklyAppointmentSetDayCount>? weeklyAppointmentSetDayCount;
  int? weeklySold;
  List<WeeklySoldDayCount>? weeklySoldDayCount;
  int? daliyNotContacted;
  int? daliyAppointmentSet;
  List<YesterdayHourlyCount>? daliyAppointmentSetHourly;
  int? daliySold;
  int? yesterdayNotContacted;
  int? yesterdayAppointmentSet;
  List<YesterdayHourlyCount>? yesterdayAppointmentSetHourly;

  LeadReports.fromJson(Map<String, dynamic> json){
    leadTypeName = json['lead_type_name'];
    totalNotContactedLead = json['total_not_contacted_lead'];
    totalAppointmentSet = json['total_appointment_set'];
    totalSold = json['total_sold'];
    lastMonthNotContacted = json['lastmonthly_not_contacted'];
    lastMonthlyNotContactedDayCount = List.from(json['lastmonthly_not_contacted_day_count']).map((e)=>MonthlyNotContactedDayCount.fromJson(e)).toList();
    lastMonthAppointmentSet = json['lastmonthly_appointment_set'];
    lastMonthlyAppointmentSetDayCount = List.from(json['lastmonthly_appointment_set_day_count']).map((e)=>MonthlyAppointmentSetDayCount.fromJson(e)).toList();
    lastMonthSaleSold = json['lastmonthly_sale_sold'];
    lastMonthlySaleSoldDayCount = List.from(json['lastmonthly_sale_sold_day_count']).map((e)=>MonthlySaleSoldDayCount.fromJson(e)).toList();
    annualyNotContacted = json['annualy_not_contacted'];
    annualyNotContactedMonthly = List.from(json['annualy_not_contacted_monthly']).map((e)=>AnnualyNotContactedMonthly.fromJson(e)).toList();
    annualyAppointmentSet = json['annualy_appointment_set'];
    annualyAppointmentSetMonthly = List.from(json['annualy_appointment_set_monthly']).map((e)=>AnnualyAppointmentSetMonthly.fromJson(e)).toList();
    annualySold = json['annualy_sold'];
    annualySoldMonthly = List.from(json['annualy_sold_monthly']).map((e)=>AnnualySoldMonthly.fromJson(e)).toList();
    monthlyNotContacted = json['monthly_not_contacted'];
    monthlyNotContactedDayCount = List.from(json['monthly_not_contacted_day_count']).map((e)=>MonthlyNotContactedDayCount.fromJson(e)).toList();
    monthlyAppointmentSet = json['monthly_appointment_set'];
    monthlyAppointmentSetDayCount = List.from(json['monthly_appointment_set_day_count']).map((e)=>MonthlyAppointmentSetDayCount.fromJson(e)).toList();
    monthlySaleSold = json['monthly_sale_sold'];
    monthlySaleSoldDayCount = List.from(json['monthly_sale_sold_day_count']).map((e)=>MonthlySaleSoldDayCount.fromJson(e)).toList();
    weeklyNotContacted = json['weekly_not_contacted'];
    weeklyNotContactedDayCount = List.from(json['weekly_not_contacted_day_count']).map((e)=>WeeklyNotContactedDayCount.fromJson(e)).toList();
    weeklyAppointmentSet = json['weekly_appointment_set'];
    weeklyAppointmentSetDayCount = List.from(json['weekly_appointment_set_day_count']).map((e)=>WeeklyAppointmentSetDayCount.fromJson(e)).toList();
    weeklySold = json['weekly_sold'];
    weeklySoldDayCount = List.from(json['weekly_sold_day_count']).map((e)=>WeeklySoldDayCount.fromJson(e)).toList();
    daliyNotContacted = json['daliy_not_contacted'];
    daliyAppointmentSet = json['daliy_appointment_set'];
    daliyAppointmentSetHourly = List.from(json['daliy_appointment_set_hourly']).map((e)=>YesterdayHourlyCount.fromJson(e)).toList();
    daliySold = json['daliy_sold'];
    yesterdayNotContacted = json['yesterday_not_contacted'];
    yesterdayAppointmentSet = json['yesterday_appointment_set'];
    yesterdayAppointmentSetHourly =  List.from(json['yesterday_appointment_set_hourly']).map((e)=>YesterdayHourlyCount.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lead_type_name'] = leadTypeName;
    data['total_not_contacted_lead'] = totalNotContactedLead;
    data['total_appointment_set'] = totalAppointmentSet;
    data['total_sold'] = totalSold;
    data['annualy_not_contacted'] = annualyNotContacted;
    data['annualy_not_contacted_monthly'] = annualyNotContactedMonthly!.map((e)=>e.toJson()).toList();
    data['annualy_appointment_set'] = annualyAppointmentSet;
    data['annualy_appointment_set_monthly'] = annualyAppointmentSetMonthly!.map((e)=>e.toJson()).toList();
    data['annualy_sold'] = annualySold;
    data['annualy_sold_monthly'] = annualySoldMonthly!.map((e)=>e.toJson()).toList();
    data['monthly_not_contacted'] = monthlyNotContacted;
    data['monthly_not_contacted_day_count'] = monthlyNotContactedDayCount!.map((e)=>e.toJson()).toList();
    data['monthly_appointment_set'] = monthlyAppointmentSet;
    data['monthly_appointment_set_day_count'] = monthlyAppointmentSetDayCount!.map((e)=>e.toJson()).toList();
    data['monthly_sale_sold'] = monthlySaleSold;
    data['monthly_sale_sold_day_count'] = monthlySaleSoldDayCount!.map((e)=>e.toJson()).toList();
    data['weekly_not_contacted'] = weeklyNotContacted;
    data['weekly_not_contacted_day_count'] = weeklyNotContactedDayCount!.map((e)=>e.toJson()).toList();
    data['weekly_appointment_set'] = weeklyAppointmentSet;
    data['weekly_appointment_set_day_count'] = weeklyAppointmentSetDayCount!.map((e)=>e.toJson()).toList();
    data['weekly_sold'] = weeklySold;
    data['weekly_sold_day_count'] = weeklySoldDayCount!.map((e)=>e.toJson()).toList();
    data['daliy_not_contacted'] = daliyNotContacted;
    data['daliy_appointment_set'] = daliyAppointmentSet;
    data['daliy_appointment_set_hourly'] = daliyAppointmentSetHourly;
    data['daliy_sold'] = daliySold;
    data['yesterday_not_contacted'] = yesterdayNotContacted;
    data['yesterday_appointment_set'] = yesterdayAppointmentSet;
    data['yesterday_appointment_set_hourly'] = yesterdayAppointmentSetHourly;
    return data;
  }
}

class AnnualyNotContactedMonthly {
  AnnualyNotContactedMonthly({
     this.month,
     this.startDate,
     this.endDate,
     this.count,
  });
   String? month;
   String? startDate;
   String? endDate;
   dynamic count;

  AnnualyNotContactedMonthly.fromJson(Map<String, dynamic> json){
    month = json['month'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['month'] = month;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['count'] = count;
    return data;
  }
}

class AnnualyAppointmentSetMonthly {
  AnnualyAppointmentSetMonthly({
     this.month,
     this.startDate,
     this.endDate,
     this.count,
  });
   String? month;
   String? startDate;
   String? endDate;
   dynamic count;

  AnnualyAppointmentSetMonthly.fromJson(Map<String, dynamic> json){
    month = json['month'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['month'] = month;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['count'] = count;
    return data;
  }
}

class AnnualySoldMonthly {
  AnnualySoldMonthly({
     this.month,
     this.startDate,
     this.endDate,
     this.count,
  });
   String? month;
   String? startDate;
   String? endDate;
   dynamic count;

  AnnualySoldMonthly.fromJson(Map<String, dynamic> json){
    month = json['month'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['month'] = month;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['count'] = count;
    return data;
  }
}

class MonthlyNotContactedDayCount {
  MonthlyNotContactedDayCount({
     this.day,
     this.count,
  });
   String? day;
  dynamic count;

  MonthlyNotContactedDayCount.fromJson(Map<String, dynamic> json){
    day = json['day'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['count'] = count;
    return data;
  }
}

class MonthlyAppointmentSetDayCount {
  MonthlyAppointmentSetDayCount({
     this.day,
     this.count,
  });
   String? day;
  dynamic count;

  MonthlyAppointmentSetDayCount.fromJson(Map<String, dynamic> json){
    day = json['day'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['count'] = count;
    return data;
  }
}

class MonthlySaleSoldDayCount {
  MonthlySaleSoldDayCount({
     this.day,
     this.count,
  });
   String? day;
  dynamic count;

  MonthlySaleSoldDayCount.fromJson(Map<String, dynamic> json){
    day = json['day'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['count'] = count;
    return data;
  }
}

class WeeklyNotContactedDayCount {
  WeeklyNotContactedDayCount({
     this.day,
     this.count,
  });
   String? day;
  dynamic count;

  WeeklyNotContactedDayCount.fromJson(Map<String, dynamic> json){
    day = json['day'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['count'] = count;
    return data;
  }
}

class WeeklyAppointmentSetDayCount {
  WeeklyAppointmentSetDayCount({
     this.day,
     this.count,
  });
   String? day;
  dynamic count;

  WeeklyAppointmentSetDayCount.fromJson(Map<String, dynamic> json){
    day = json['day'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['count'] = count;
    return data;
  }
}

class WeeklySoldDayCount {
  WeeklySoldDayCount({
     this.day,
     this.count,
  });
   String? day;
  dynamic count;

  WeeklySoldDayCount.fromJson(Map<String, dynamic> json){
    day = json['day'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['count'] = count;
    return data;
  }
}

class AllTime {
  AllTime({
     this.allTimeNotContactedLeads,
     this.allTimeAppointments,
     this.allTimeSalesFromLeads,
     this.allTimeLeads,
  });
  dynamic allTimeNotContactedLeads;
  dynamic allTimeAppointments;
  dynamic allTimeSalesFromLeads;
  dynamic allTimeLeads;

  AllTime.fromJson(Map<String, dynamic> json){
    allTimeNotContactedLeads = json['all_time_not_contacted_leads'];
    allTimeAppointments = json['all_time_appointments'];
    allTimeSalesFromLeads = json['all_time_sales_from_Leads'];
    allTimeLeads = json['all_time_leads'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['all_time_not_contacted_leads'] = allTimeNotContactedLeads;
    data['all_time_appointments'] = allTimeAppointments;
    data['all_time_sales_from_Leads'] = allTimeSalesFromLeads;
    data['all_time_leads'] = allTimeLeads;
    return data;
  }
}

class SalesAvgReport {
  SalesAvgReport({
     this.annualPriceAverage,
     this.annualNetPriceAverage,
     this.annualTaxAverage,
    this.weeklyPriceAverage,
    this.weeklyNetPriceAverage,
    this.weeklyTaxAverage,
    this.monthlyPriceAverage,
    this.monthlyNetPriceAverage,
    this.monthlyTaxAverage,
    this.dailyPriceAverage,
    this.dailyNetPriceAverage,
    this.dailyTaxAverage,
    this.yesterdayPriceAverage,
    this.yesterdayNetPriceAverage,
    this.yesterdayTaxAverage,
  });
  dynamic annualPriceAverage;
  dynamic annualNetPriceAverage;
  dynamic annualTaxAverage;
   dynamic weeklyPriceAverage;
  dynamic weeklyNetPriceAverage;
  dynamic weeklyTaxAverage;
  dynamic monthlyPriceAverage;
  dynamic monthlyNetPriceAverage;
  dynamic monthlyTaxAverage;
  dynamic dailyPriceAverage;
  dynamic dailyNetPriceAverage;
  dynamic dailyTaxAverage;
  dynamic yesterdayPriceAverage;
  dynamic yesterdayNetPriceAverage;
  dynamic yesterdayTaxAverage;

  SalesAvgReport.fromJson(Map<String, dynamic> json){
    annualPriceAverage = json['annual_price_average'];
    annualNetPriceAverage = json['annual_net_price_average'];
    annualTaxAverage = json['annual_tax_average'];
    weeklyPriceAverage = null;
    weeklyNetPriceAverage = null;
    weeklyTaxAverage = null;
    monthlyPriceAverage = null;
    monthlyNetPriceAverage = null;
    monthlyTaxAverage = null;
    dailyPriceAverage = null;
    dailyNetPriceAverage = null;
    dailyTaxAverage = null;
    yesterdayPriceAverage = null;
    yesterdayNetPriceAverage = null;
    yesterdayTaxAverage = null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['annual_price_average'] = annualPriceAverage;
    data['annual_net_price_average'] = annualNetPriceAverage;
    data['annual_tax_average'] = annualTaxAverage;
    data['weekly_price_average'] = weeklyPriceAverage;
    data['weekly_net_price_average'] = weeklyNetPriceAverage;
    data['weekly_tax_average'] = weeklyTaxAverage;
    data['monthly_price_average'] = monthlyPriceAverage;
    data['monthly_net_price_average'] = monthlyNetPriceAverage;
    data['monthly_tax_average'] = monthlyTaxAverage;
    data['daily_price_average'] = dailyPriceAverage;
    data['daily_net_price_average'] = dailyNetPriceAverage;
    data['daily_tax_average'] = dailyTaxAverage;
    data['yesterday_price_average'] = yesterdayPriceAverage;
    data['yesterday_net_price_average'] = yesterdayNetPriceAverage;
    data['yesterday_tax_average'] = yesterdayTaxAverage;
    return data;
  }
}

class GoalsReport {
  GoalsReport({
     this.title,
     this.minimum,
     this.personal,
     this.actual,
  });
   List<String>? title;
   Minimum? minimum;
   Personal? personal;
   Actual? actual;

  GoalsReport.fromJson(Map<String, dynamic> json){
    title = List.castFrom<dynamic, String>(json['title']);
    minimum = Minimum.fromJson(json['minimum']);
    personal = Personal.fromJson(json['personal']);
    actual = Actual.fromJson(json['actual']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['minimum'] = minimum!.toJson();
    data['personal'] = personal!.toJson();
    data['actual'] = actual!.toJson();
    return data;
  }
}

class Minimum {
  Minimum({
     this.day,
     this.week,
     this.month,
  });
   Day? day;
   Week? week;
   Month? month;

  Minimum.fromJson(Map<String, dynamic> json){
    day = Day.fromJson(json['day']);
    week = Week.fromJson(json['week']);
    month = Month.fromJson(json['month']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day!.toJson();
    data['week'] = week!.toJson();
    data['month'] = month!.toJson();
    return data;
  }
}

class Day {
  Day({
     this.leads,
     this.appointments,
     this.demos,
     this.estimated,
  });
  dynamic leads;
  dynamic appointments;
  dynamic demos;
  dynamic estimated;

  Day.fromJson(Map<String, dynamic> json){
    leads = json['leads'];
    appointments = json['appointments'];
    demos = json['demos'];
    estimated = json['estimated'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['leads'] = leads;
    data['appointments'] = appointments;
    data['demos'] = demos;
    data['estimated'] = estimated;
    return data;
  }
}

class Week {
  Week({
     this.leads,
     this.appointments,
     this.demos,
     this.estimated,
  });
  dynamic leads;
  dynamic appointments;
  dynamic demos;
  dynamic estimated;

  Week.fromJson(Map<String, dynamic> json){
    leads = json['leads'];
    appointments = json['appointments'];
    demos = json['demos'];
    estimated = json['estimated'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['leads'] = leads;
    data['appointments'] = appointments;
    data['demos'] = demos;
    data['estimated'] = estimated;
    return data;
  }
}

class Month {
  Month({
     this.leads,
     this.appointments,
     this.demos,
     this.estimated,
  });
  dynamic leads;
  dynamic appointments;
  dynamic demos;
  dynamic estimated;

  Month.fromJson(Map<String, dynamic> json){
    leads = json['leads'];
    appointments = json['appointments'];
    demos = json['demos'];
    estimated = json['estimated'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['leads'] = leads;
    data['appointments'] = appointments;
    data['demos'] = demos;
    data['estimated'] = estimated;
    return data;
  }
}

class Personal {
  Personal({
     this.day,
     this.week,
     this.month,
  });
   Day? day;
   Week? week;
   Month? month;

  Personal.fromJson(Map<String, dynamic> json){
    day = Day.fromJson(json['day']);
    week = Week.fromJson(json['week']);
    month = Month.fromJson(json['month']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day!.toJson();
    data['week'] = week!.toJson();
    data['month'] = month!.toJson();
    return data;
  }
}

class Actual {
  Actual({
     this.day,
     this.week,
     this.month,
  });
   Day? day;
   Week? week;
   Month? month;

  Actual.fromJson(Map<String, dynamic> json){
    day = Day.fromJson(json['day']);
    week = Week.fromJson(json['week']);
    month = Month.fromJson(json['month']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day!.toJson();
    data['week'] = week!.toJson();
    data['month'] = month!.toJson();
    return data;
  }
}

class DemoReport {
  DemoReport({
     this.annualy,
     this.monthly,
     this.weekly,
     this.today,
     this.yesterday,
  });
   dynamic annualy;
  dynamic monthly;
  dynamic weekly;
  dynamic today;
  dynamic yesterday;

  DemoReport.fromJson(Map<String, dynamic> json){
    annualy = json['annualy'];
    monthly = json['monthly'];
    weekly = json['weekly'];
    today = json['today'];
    yesterday = json['yesterday'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['annualy'] = annualy;
    data['monthly'] = monthly;
    data['weekly'] = weekly;
    data['today'] = today;
    data['yesterday'] = yesterday;
    return data;
  }
}

class DemoReportV2 {
  DemoReportV2({
    this.totalDemos,
    this.totalTime,
    this.averageTime,
    this.successSold,
    this.totalDemoAsLastMonth,
    this.totalTimeAsLastMonth,
    this.averageTimeAsLastMonth,
    this.successSoldLastMonth,
    this.totalDemoAsAnnual,
    this.totalTimeAsAnnual,
    this.averageTimeAsAnnual,
    this.successSoldAnnual,
    this.totalDemosAsMonthly,
    this.totalTimeAsMonthly,
    this.averageTimeAsMonthly,
    this.successSoldMonthly,
    this.totalDemosAsWeekly,
    this.totalTimeAsWeekly,
    this.averageTimeAsWeekly,
    this.successSoldWeekly,
  });
  dynamic totalDemos;
  dynamic totalTime;
  dynamic averageTime;
  dynamic successSold;
  dynamic totalDemoAsLastMonth;
  dynamic totalTimeAsLastMonth;
  dynamic averageTimeAsLastMonth;
  dynamic successSoldLastMonth;
  dynamic totalDemoAsAnnual;
  dynamic totalTimeAsAnnual;
  dynamic averageTimeAsAnnual;
  dynamic successSoldAnnual;
  dynamic totalDemosAsMonthly;
  dynamic totalTimeAsMonthly;
  dynamic averageTimeAsMonthly;
  dynamic successSoldMonthly;
  dynamic totalDemosAsWeekly;
  dynamic totalTimeAsWeekly;
  dynamic averageTimeAsWeekly;
  dynamic successSoldWeekly;

  DemoReportV2.fromJson(Map<String, dynamic> json){
    totalDemos = json['total_demos'];
    totalTime = json['total_time'];
    averageTime = json['average_time'];
    successSold = json['success_sold'];
    totalDemoAsLastMonth = json['total_demos_as_lastmonth'];
    totalTimeAsLastMonth = json['total_time_as_lastmonth'];
    averageTimeAsLastMonth = json['average_time_as_lastmonth'];
    successSoldLastMonth = json['success_sold_lastmonth'];
    totalDemoAsAnnual = json['total_demos_as_annual'];
    totalTimeAsAnnual = json['total_time_as_annual'];
    averageTimeAsAnnual = json['average_time_as_annual'];
    successSoldAnnual = json['success_sold_annual'];
    totalDemosAsMonthly = json['total_demos_as_monthly'];
    totalTimeAsMonthly = json['total_time_as_monthly'];
    averageTimeAsMonthly = json['average_time_as_monthly'];
    successSoldMonthly = json['success_sold_monthly'];
    totalDemosAsWeekly = json['total_demos_as_weekly'];
    totalTimeAsWeekly = json['total_time_as_weekly'];
    averageTimeAsWeekly = json['average_time_as_weekly'];
    successSoldWeekly = json['success_sold_weekly'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_demos'] = totalDemos;
    data['total_time'] = totalTime;
    data['average_time'] = averageTime;
    data['success_sold'] = successSold;
    data['total_demos_as_lastmonth'] = totalDemoAsLastMonth;
    data['total_time_as_lastmonth'] = totalTimeAsLastMonth;
    data['average_time_as_lastmonth'] = averageTimeAsLastMonth;
    data['success_sold_lastmonth'] = successSoldLastMonth;
    data['total_demos_as_annual'] = totalDemoAsAnnual;
    data['total_time_as_annual'] = totalTimeAsAnnual;
    data['average_time_as_annual'] = averageTimeAsAnnual;
    data['success_sold_annual'] = successSoldAnnual;
    data['total_demos_as_monthly'] = totalDemosAsMonthly;
    data['total_time_as_monthly'] = totalTimeAsMonthly;
    data['average_time_as_monthly'] = averageTimeAsMonthly;
    data['success_sold_monthly'] = successSoldMonthly;
    data['total_demos_as_weekly'] = totalDemosAsWeekly;
    data['total_time_as_weekly'] = totalTimeAsWeekly;
    data['average_time_as_weekly'] = averageTimeAsWeekly;
    data['success_sold_weekly'] = successSoldWeekly;
    return data;
  }
}