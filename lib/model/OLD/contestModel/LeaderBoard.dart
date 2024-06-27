class LeaderBoard {
  int? id;
  String? name;
  String? image;
  String? salesrole;
  int? limit;
  int? approved;

  LeaderBoard({this.id, this.name,this.salesrole, this.limit, this.approved, this.image});

  factory LeaderBoard.fromJson(Map<String, dynamic> json) {
    return LeaderBoard(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        salesrole: json['salesrole'],
        limit: json['limit'],
        approved: json['approved']);
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'limit': limit,
      'salesrole':salesrole,
      'approved': approved,
      'image': image
    };
  }
}