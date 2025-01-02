// To parse this JSON data, do
//
//     final partyHistoryResponseModel = partyHistoryResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/common_api_response_model.dart';

PartyHistoryResponseModel partyHistoryResponseModelFromJson(String str) => PartyHistoryResponseModel.fromJson(json.decode(str));

String partyHistoryResponseModelToJson(PartyHistoryResponseModel data) => json.encode(data.toJson());

class PartyHistoryResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PartyHistoryResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory PartyHistoryResponseModel.fromJson(Map<String, dynamic> json) => PartyHistoryResponseModel(
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
  Parties? parties;
  Data({
    this.parties,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        parties: json["parties"] == null ? null : Parties.fromJson(json["parties"]),
      );

  Map<String, dynamic> toJson() => {
        "parties": parties?.toJson(),
      };
}

class Parties {
  List<Party>? data;
  dynamic nextPageUrl;

  Parties({
    this.data,
    this.nextPageUrl,
  });

  factory Parties.fromJson(Map<String, dynamic> json) => Parties(
        data: json["data"] == null ? [] : List<Party>.from(json["data"]!.map((x) => Party.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<Party>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Party {
  String? id; //
  String? userId; //
  String? itemId; //
  String? episodeId; //
  String? partyCode;
  dynamic closedAt;
  String? status; //
  String? createdAt;
  String? updatedAt;
  Episode? item;
  Episode? episode;
  List<PartyMember>? partyMember;

  Party({
    this.id,
    this.userId,
    this.itemId,
    this.episodeId,
    this.partyCode,
    this.closedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.item,
    this.episode,
    this.partyMember,
  });

  factory Party.fromJson(Map<String, dynamic> json) => Party(
        id: json["id"].toString(),
        userId: json["user_id"].toString(),
        itemId: json["item_id"].toString(),
        episodeId: json["episode_id"].toString(),
        partyCode: json["party_code"].toString(),
        closedAt: json["closed_at"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        item: json["item"] == null ? null : Episode.fromJson(json["item"]),
        episode: json["episode"] == null ? null : Episode.fromJson(json["episode"]),
        partyMember: json["party_member"] == null ? [] : List<PartyMember>.from(json["party_member"]!.map((x) => PartyMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "item_id": itemId,
        "episode_id": episodeId,
        "party_code": partyCode,
        "closed_at": closedAt,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "item": item?.toJson(),
        "episode": episode?.toJson(),
        "party_member": partyMember == null ? [] : List<dynamic>.from(partyMember!.map((x) => x.toJson())),
      };
}

class Episode {
  String? id;
  String? title;

  Episode({
    this.id,
    this.title,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"].toString(),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class PartyMember {
  String? userId;
  String? watchPartyId;

  PartyMember({
    this.userId,
    this.watchPartyId,
  });

  factory PartyMember.fromJson(Map<String, dynamic> json) => PartyMember(
        userId: json["user_id"].toString(),
        watchPartyId: json["watch_party_id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "watch_party_id": watchPartyId,
      };
}
