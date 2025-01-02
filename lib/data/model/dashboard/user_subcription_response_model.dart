// To parse this JSON data, do
//
//     final userSubcriptionResponseModel = userSubcriptionResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/global_meassage.dart';

UserSubcriptionResponseModel userSubcriptionResponseModelFromJson(String str) => UserSubcriptionResponseModel.fromJson(json.decode(str));

String userSubcriptionResponseModelToJson(UserSubcriptionResponseModel data) => json.encode(data.toJson());

class UserSubcriptionResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  UserSubcriptionResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory UserSubcriptionResponseModel.fromJson(Map<String, dynamic> json) => UserSubcriptionResponseModel(
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
  List<String>? subscribedChannelId;
  List<String>? subscribedTournamentId;
  List<String>? subscribedMatchId;

  Data({
    this.subscribedChannelId,
    this.subscribedTournamentId,
    this.subscribedMatchId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subscribedChannelId: json["subscribedChannelId"] == null ? [] : List<String>.from(json["subscribedChannelId"]!.map((x) => x.toString())),
        subscribedTournamentId: json["subscribedTournamentId"] == null ? [] : List<String>.from(json["subscribedTournamentId"]!.map((x) => x.toString())),
        subscribedMatchId: json["subscribedMatchId"] == null ? [] : List<String>.from(json["subscribedMatchId"]!.map((x) => x.toString())),
      );

  Map<String, dynamic> toJson() => {
        "subscribedChannelId": subscribedChannelId == null ? [] : List<dynamic>.from(subscribedChannelId!.map((x) => x)),
        "subscribedEventId": subscribedTournamentId == null ? [] : List<dynamic>.from(subscribedTournamentId!.map((x) => x)),
        "subscribedMatchId": subscribedMatchId == null ? [] : List<dynamic>.from(subscribedMatchId!.map((x) => x)),
      };
}
