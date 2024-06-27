// To parse this JSON data, do
//
//     final postDemoQuestion = postDemoQuestionFromJson(jsonString);

import 'dart:convert';

List<PostDemoQuestion> postDemoQuestionFromJson(String str) => List<PostDemoQuestion>.from(json.decode(str).map((x) => PostDemoQuestion.fromJson(x)));

String postDemoQuestionToJson(List<PostDemoQuestion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostDemoQuestion {
  int? demoId;
  int? userId;
  int? questionId;
  String? answerText;

  PostDemoQuestion({
    this.demoId,
    this.userId,
    this.questionId,
    this.answerText,
  });

  factory PostDemoQuestion.fromJson(Map<String, dynamic> json) => PostDemoQuestion(
    demoId: json["demo_id"],
    userId: json["user_id"],
    questionId: json["question_id"],
    answerText: json["answer_text"],
  );

  Map<String, dynamic> toJson() => {
    "demo_id": demoId,
    "user_id": userId,
    "question_id": questionId,
    "answer_text": answerText,
  };
}
