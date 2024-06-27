class Notifications {

  int? id;
  String? title;
  String? message;
  String? date;

  Notifications({
    this.id,
    this.title,
    this.message,
    this.date
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      date: json['date'],
    );
  }
}