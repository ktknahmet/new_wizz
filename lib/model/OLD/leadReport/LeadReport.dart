  // To parse this JSON data, do
  //
  //     final leadReport = leadReportFromJson(jsonString?);

  import 'dart:convert';

import 'package:wizzsales/model/OLD/leadReport/Lead.dart';

  LeadReport leadReportFromJson(String str) => LeadReport.fromJson(json.decode(str));

  String? leadReportToJson(LeadReport data) => json.encode(data.toJson());

  class LeadReport {
    String? leadTypeName;
    int? notContacted;
    int? aptSetCount;
    int? soldCount;
    int? notInterested;
    int? aptCanceled;
    int? aptRescheduled;
    int? notHomeCount;
    int? dns;
    int? notContactedWeek;
    int? aptSetWeekly;
    int? soldWeekly;
    List<Lead>? leads;

    LeadReport({
      this.leadTypeName,
      this.notContacted,
      this.aptSetCount,
      this.soldCount,
      this.notInterested,
      this.aptCanceled,
      this.aptRescheduled,
      this.notHomeCount,
      this.dns,
      this.notContactedWeek,
      this.aptSetWeekly,
      this.soldWeekly,
      this.leads,
    });

    factory LeadReport.fromJson(Map<dynamic, dynamic> json) => LeadReport(
      leadTypeName: json["lead_type_name"],
      notContacted: json["not_contacted_lead_count"],
      aptSetCount: json["appointment_set_count"],
      soldCount: json["sold_count"],
      notInterested: json["not_interested_count"],
      aptCanceled: json["appointment_cancalled_count"],
      aptRescheduled: json["appintment_rescheduled_count"],
      notHomeCount: json["not_home_count"],
      dns: json["dns_count"],
      notContactedWeek: json["not_contacted_lead_as_weekly_count"],
      aptSetWeekly: json["appointment_set_as_weekly_count"],
      soldWeekly: json["sold_as_weekly_count"],
      leads: json["leads"] != null ? List<Lead>.from(json["leads"].map((x) => Lead.fromJson(x))) : [],

    );

    Map<dynamic, dynamic> toJson() => {
      "lead_type_name": leadTypeName,
      "not_contacted_lead_count": notContacted,
      "appointment_set_count": aptSetCount,
      "sold_count": soldCount,
      "not_interested_count": notInterested,
      "appointment_cancalled_count": aptCanceled,
      "appintment_rescheduled_count": aptRescheduled,
      "not_home_count": notHomeCount,
      "dns_count": dns,
      "not_contacted_lead_as_weekly_count": notContactedWeek,
      "appointment_set_as_weekly_count": aptSetWeekly,
      "sold_as_weekly_count": soldWeekly,
      "leads": List<Lead?>.from(leads!.map((x) => x.toJson())),

    };
  }



  class Answer {
    String? code;
    int? questionId;
    String? answer;
    dynamic createdAt;
    dynamic updatedAt;
    Question? question;

    Answer({
      this.code,
      this.questionId,
      this.answer,
      this.createdAt,
      this.updatedAt,
      this.question,
    });

    factory Answer.fromJson(Map<String?, dynamic> json) => Answer(
      code: json["code"],
      questionId: json["question_id"],
      answer: json["answer"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      question: Question.fromJson(json["question"]),
    );

    Map<String?, dynamic> toJson() => {
      "code": code,
      "question_id": questionId,
      "answer": answer,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "question": question!.toJson(),
    };
  }

  class Question {
    int? id;
    String? question;
    int? status;
    int? mobile;
    int? web;
    int? appointment;
    dynamic createdAt;
    dynamic updatedAt;
    int? type;
    int? order;
    int? leadId;

    Question({
      this.id,
      this.question,
      this.status,
      this.mobile,
      this.web,
      this.appointment,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.order,
      this.leadId,
    });

    factory Question.fromJson(Map<String?, dynamic> json) => Question(
      id: json["id"],
      question: json["question"],
      status: json["status"],
      mobile: json["mobile"],
      web: json["web"],
      appointment: json["appointment"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      type: json["type"],
      order: json["order"],
      leadId: json["lead_id"],
    );

    Map<String?, dynamic> toJson() => {
      "id": id,
      "question": question,
      "status": status,
      "mobile": mobile,
      "web": web,
      "appointment": appointment,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "type": type,
      "order": order,
      "lead_id": leadId,
    };
  }
