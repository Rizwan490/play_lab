import 'package:play_lab/data/model/global/tournament/game_model.dart';

class TournamentModel {
  String? id; //
  String? name;
  String? shortName;
  String? description;
  String? image;
  String? season;
  String? price;
  String? version; //
  String? status; //
  String? createdAt;
  String? updatedAt;
  List<GameModel>? games;

  TournamentModel({
    this.id,
    this.name,
    this.shortName,
    this.description,
    this.image,
    this.season,
    this.price,
    this.version,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.games,
  });

  factory TournamentModel.fromJson(Map<String, dynamic> json) => TournamentModel(
        id: json["id"].toString(),
        name: json["name"].toString(),
        shortName: json["short_name"].toString(),
        description: json["description"].toString(),
        image: json["image"].toString(),
        season: json["season"].toString(),
        price: json["price"].toString(),
        version: json["version"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        games: json["games"] == null ? [] : List<GameModel>.from(json["games"]!.map((x) => GameModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_name": shortName,
        "description": description,
        "image": image,
        "season": season,
        "price": price,
        "version": version,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "games": games == null ? [] : List<dynamic>.from(games!.map((x) => x.toJson())),
      };
}
