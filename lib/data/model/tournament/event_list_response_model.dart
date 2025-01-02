// To parse this JSON data, do
//
//     final eventListResponseModel = eventListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/tournament/tournament_model.dart';
import 'package:play_lab/data/model/global/global_meassage.dart';

TournamentListResponseModel eventListResponseModelFromJson(String str) => TournamentListResponseModel.fromJson(json.decode(str));

String eventListResponseModelToJson(TournamentListResponseModel data) => json.encode(data.toJson());

class TournamentListResponseModel {
  String? remark;
  String? status;
  Message? message;
  MainData? data;

  TournamentListResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory TournamentListResponseModel.fromJson(Map<String, dynamic> json) => TournamentListResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : MainData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class MainData {
  TournamentDataList? events;
  String? imagePath;

  MainData({
    this.events,
    this.imagePath,
  });

  factory MainData.fromJson(Map<String, dynamic> json) => MainData(
        events: json["tournaments"] == null ? null : TournamentDataList.fromJson(json["tournaments"]),
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "events": events?.toJson(),
        "imagePath": imagePath,
      };
}

class TournamentDataList {
  List<TournamentModel>? data;

  dynamic nextPageUrl;

  TournamentDataList({
    this.data,
    this.nextPageUrl,
  });

  factory TournamentDataList.fromJson(Map<String, dynamic> json) => TournamentDataList(
        data: json["data"] == null ? [] : List<TournamentModel>.from(json["data"]!.map((x) => TournamentModel.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}
