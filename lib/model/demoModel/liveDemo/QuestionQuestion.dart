
class QuestionQuestion {
  int? questionId;
  String? questionText;
  int? questionOrder;

  QuestionQuestion({
    this.questionId,
    this.questionText,
    this.questionOrder,
  });

  factory QuestionQuestion.fromJson(Map<String, dynamic> json) => QuestionQuestion(
    questionId: json["question_id"],
    questionText: json["question_text"],
    questionOrder: json["question_order"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "question_text": questionText,
    "question_order": questionOrder,
  };
}