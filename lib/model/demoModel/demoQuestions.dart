// To parse this JSON data, do
//
//     final demoQuestions = demoQuestionsFromJson(jsonString);

import 'dart:convert';

DemoQuestions demoQuestionsFromJson(String str) => DemoQuestions.fromJson(json.decode(str));

String demoQuestionsToJson(DemoQuestions data) => json.encode(data.toJson());

class DemoQuestions {
  List<Question>? questions;
  List<Reason>? reasons;

  DemoQuestions({
    this.questions,
    this.reasons,
  });

  factory DemoQuestions.fromJson(Map<String, dynamic> json) => DemoQuestions(
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    reasons: List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
    "reasons": List<dynamic>.from(reasons!.map((x) => x.toJson())),
  };
}

class Question {
  int? questionId;
  String? questionText;
  int? questionOrder;
  List<Answer>? answers;

  Question({
    this.questionId,
    this.questionText,
    this.questionOrder,
    this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["question_id"],
    questionText: json["question_text"],
    questionOrder: json["question_order"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "question_text": questionText,
    "question_order": questionOrder,
    "answers": List<dynamic>.from(answers!.map((x) => x.toJson())),
  };
}

class Answer {
  int? answerId;
  int? questionId;
  String? answerText;

  Answer({
    this.answerId,
    this.questionId,
    this.answerText,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    answerId: json["answer_id"],
    questionId: json["question_id"],
    answerText: json["answer_text"],
  );

  Map<String, dynamic> toJson() => {
    "answer_id": answerId,
    "question_id": questionId,
    "answer_text": answerText,
  };
}

class Reason {
  int? reasonTypeId;
  String? reasonType;
  String? notes;
  bool? isChecked;

  Reason({
    this.reasonTypeId,
    this.reasonType,
    this.notes,
    this.isChecked = false
  });

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
    reasonTypeId: json["reason_type_id"],
    reasonType: json["reason_type"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "reason_type_id": reasonTypeId,
    "reason_type": reasonType,
    "notes": notes,
  };
}
