class Question {
  int? id;
  String? name;
  int? status;
  int? type;

  Question({this.id, this.name, this.status, this.type});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      name: json['question'],
      status: json['status'],
      type: json['type'],
    );
  }
}
