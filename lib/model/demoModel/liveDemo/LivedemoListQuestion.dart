import 'package:wizzsales/model/demoModel/liveDemo/QuestionQuestion.dart';

class LiveDemoListQuestion {
  int? responseId;
  int? demoId;
  int? userId;
  int? questionId;
  String? answerText;
  List<QuestionQuestion>? question;

  LiveDemoListQuestion({
    this.responseId,
    this.demoId,
    this.userId,
    this.questionId,
    this.answerText,
    this.question,
  });

  factory LiveDemoListQuestion.fromJson(Map<String, dynamic> json) => LiveDemoListQuestion(
    responseId: json["response_id"],
    demoId: json["demo_id"],
    userId: json["user_id"],
    questionId: json["question_id"],
    answerText: json["answer_text"],
    question: List<QuestionQuestion>.from(json["question"].map((x) => QuestionQuestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_id": responseId,
    "demo_id": demoId,
    "user_id": userId,
    "question_id": questionId,
    "answer_text": answerText,
    "question": List<dynamic>.from(question!.map((x) => x.toJson())),
  };
}