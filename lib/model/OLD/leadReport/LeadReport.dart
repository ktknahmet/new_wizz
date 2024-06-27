  // To parse this JSON data, do
  //
  //     final leadReport = leadReportFromJson(jsonString?);

  import 'dart:convert';

import 'package:wizzsales/model/OLD/leadReport/Lead.dart';

  LeadReport leadReportFromJson(String str) => LeadReport.fromJson(json.decode(str));

  String? leadReportToJson(LeadReport data) => json.encode(data.toJson());

  class LeadReport {
    String? lead_type_name;
    int? not_contacted_lead_count;
    int? appointment_set_count;
    int? sold_count;
    int? not_contacted_lead_as_weekly_count;
    int? appointment_set_as_weekly_count;
    int? sold_as_weekly_count;
    List<Lead>? leads;

    LeadReport({
      this.lead_type_name,
      this.not_contacted_lead_count,
      this.appointment_set_count,
      this.sold_count,
      this.not_contacted_lead_as_weekly_count,
      this.appointment_set_as_weekly_count,
      this.sold_as_weekly_count,
      this.leads,
    });

    factory LeadReport.fromJson(Map<dynamic, dynamic> json) => LeadReport(
      lead_type_name: json["lead_type_name"],
      not_contacted_lead_count: json["not_contacted_lead_count"],
      appointment_set_count: json["appointment_set_count"],
      sold_count: json["sold_count"],
      not_contacted_lead_as_weekly_count: json["not_contacted_lead_as_weekly_count"],
      appointment_set_as_weekly_count: json["appointment_set_as_weekly_count"],
      sold_as_weekly_count: json["sold_as_weekly_count"],
      leads: json["leads"] != null ? List<Lead>.from(json["leads"].map((x) => Lead.fromJson(x))) : [],

    );

    Map<dynamic, dynamic> toJson() => {
      "lead_type_name": lead_type_name,
      "not_contacted_lead_count": not_contacted_lead_count,
      "appointment_set_count": appointment_set_count,
      "sold_count": sold_count,
      "not_contacted_lead_as_weekly_count": not_contacted_lead_as_weekly_count,
      "appointment_set_as_weekly_count": appointment_set_as_weekly_count,
      "sold_as_weekly_count": sold_as_weekly_count,
      "leads": List<Lead?>.from(leads!.map((x) => x!.toJson())),

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
