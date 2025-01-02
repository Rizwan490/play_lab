class GameModel {
  String? id; //
  String? tournamentId; //
  String? teamOneId; //
  String? teamTwoId; //
  String? slug;
  String? image;
  String? startTime;
  String? details;
  String? price;
  String? version; //
  String? link;
  String? result;
  String? status; //
  String? createdAt;
  String? updatedAt;

  GameModel({
    this.id,
    this.tournamentId,
    this.teamOneId,
    this.teamTwoId,
    this.slug,
    this.image,
    this.startTime,
    this.details,
    this.price,
    this.version,
    this.link,
    this.result,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        id: json["id"].toString(),
        tournamentId: json["tournament_id"].toString(),
        teamOneId: json["team_one_id"].toString(),
        teamTwoId: json["team_two_id"].toString(),
        slug: json["slug"].toString(),
        image: json["image"].toString(),
        startTime: json["start_time"].toString(),
        details: json["details"].toString(),
        price: json["price"].toString(),
        version: json["version"].toString(),
        link: json["link"].toString(),
        result: json["result"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": tournamentId,
        "team_one_id": teamOneId,
        "team_two_id": teamTwoId,
        "slug": slug,
        "image": image,
        "start_time": startTime,
        "details": details,
        "price": price,
        "version": version,
        "link": link,
        "result": result,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
