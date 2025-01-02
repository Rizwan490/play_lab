// To parse this JSON data, do
//
//     final gameWatchResponseModel = gameWatchResponseModelFromJson(jsonString);

import 'dart:convert';
import 'package:play_lab/data/model/global/tournament/tournament_model.dart';
import 'package:play_lab/data/model/global/global_meassage.dart';

GameWatchResponseModel gameWatchResponseModelFromJson(String str) => GameWatchResponseModel.fromJson(json.decode(str));

String gameWatchResponseModelToJson(GameWatchResponseModel data) => json.encode(data.toJson());

class GameWatchResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GameWatchResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GameWatchResponseModel.fromJson(Map<String, dynamic> json) => GameWatchResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  GameWatchModel? game;
  bool? watchEligable;
  String? imagePath;

  Data({
    this.game,
    this.watchEligable,
    this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        game: json["game"] == null ? null : GameWatchModel.fromJson(json["game"]),
        watchEligable: json["watchEligable"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "game": game?.toJson(),
        "watchEligable": watchEligable,
        "imagePath": imagePath,
      };
}

class GameWatchModel {
  String? id; //
  String? eventId; //
  String? teamOneId; //
  String? teamTwoId; //
  String? slug;
  String? image;
  String? startTime;
  String? details;
  String? price;
  String? version; //
  String? link;
  dynamic result;
  String? status; //
  String? createdAt;
  String? updatedAt;
  TournamentModel? event;
  Team? teamOne;
  Team? teamTwo;

  GameWatchModel({
    this.id,
    this.eventId,
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
    this.event,
    this.teamOne,
    this.teamTwo,
  });

  factory GameWatchModel.fromJson(Map<String, dynamic> json) => GameWatchModel(
        id: json["id"].toString(),
        eventId: json["event_id"].toString(),
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
        event: json["event"] == null ? null : TournamentModel.fromJson(json["event"]),
        teamOne: json["team_one"] == null ? null : Team.fromJson(json["team_one"]),
        teamTwo: json["team_two"] == null ? null : Team.fromJson(json["team_two"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
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
        "event": event?.toJson(),
        "team_one": teamOne?.toJson(),
        "team_two": teamTwo?.toJson(),
      };
}

class Team {
  String? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  Team({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"].toString(),
        name: json["name"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
