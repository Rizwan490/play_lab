// To parse this JSON data, do
//
//     final eventDetailsResponseModel = eventDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/tournament/tournament_model.dart';
import 'package:play_lab/data/model/global/tournament/game_model.dart';

import '../global/global_meassage.dart';

EventDetailsResponseModel eventDetailsResponseModelFromJson(String str) => EventDetailsResponseModel.fromJson(json.decode(str));

String eventDetailsResponseModelToJson(EventDetailsResponseModel data) => json.encode(data.toJson());

class EventDetailsResponseModel {
  String? remark;
  String? status;
  Message? message;
  TournamentMainData? data;

  EventDetailsResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory EventDetailsResponseModel.fromJson(Map<String, dynamic> json) => EventDetailsResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : TournamentMainData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class TournamentMainData {
  TournamentModel? event;
  String? imagePath;
  Map<String, List<GameModel>>? games;
  String? watchEligable;
  List<String>? subscribedEventId;
  List<String>? subscribedMatchId;
  TournamentMainData({
    this.event,
    this.imagePath,
    this.games,
    this.watchEligable,
    this.subscribedEventId,
    this.subscribedMatchId,
  });

  factory TournamentMainData.fromJson(Map<String, dynamic> json) => TournamentMainData(
        event: json["tournament"] == null ? null : TournamentModel.fromJson(json["tournament"]),
        imagePath: json["imagePath"],
        games: Map.from(json["games"]!).map((k, v) => MapEntry<String, List<GameModel>>(k, List<GameModel>.from(v.map((x) => GameModel.fromJson(x))))),
        watchEligable: json["watchEligable"].toString(),
        subscribedEventId: json["subscribedEventId"] == null ? [] : List<String>.from(json["subscribedEventId"]!.map((x) => x.toString())),
        subscribedMatchId: json["subscribedMatchId"] == null ? [] : List<String>.from(json["subscribedMatchId"]!.map((x) => x.toString())),
      );

  Map<String, dynamic> toJson() => {
        "event": event?.toJson(),
        "imagePath": imagePath,
        "games": Map.from(games!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "watchEligable": watchEligable,
      };
}
