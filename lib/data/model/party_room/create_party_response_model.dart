// To parse this JSON data, do
//
//     final createPartyResponseModel = createPartyResponseModelFromJson(jsonString);

import 'dart:convert';

import '../global/common_api_response_model.dart';

CreatePartyResponseModel createPartyResponseModelFromJson(String str) => CreatePartyResponseModel.fromJson(json.decode(str));

String createPartyResponseModelToJson(CreatePartyResponseModel data) => json.encode(data.toJson());

class CreatePartyResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  CreatePartyResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory CreatePartyResponseModel.fromJson(Map<String, dynamic> json) => CreatePartyResponseModel(
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
  WatchParty? watchParty;

  Data({
    this.watchParty,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        watchParty: json["watchParty"] == null ? null : WatchParty.fromJson(json["watchParty"]),
      );

  Map<String, dynamic> toJson() => {
        "watchParty": watchParty?.toJson(),
      };
}

class WatchParty {
  String? userId; //
  String? itemId;
  String? episodeId; //
  String? partyCode;
  String? updatedAt;
  String? createdAt;
  String? id; //

  WatchParty({
    this.userId,
    this.itemId,
    this.episodeId,
    this.partyCode,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory WatchParty.fromJson(Map<String, dynamic> json) => WatchParty(
        userId: json["user_id"].toString(),
        itemId: json["item_id"].toString(),
        episodeId: json["episode_id"].toString(),
        partyCode: json["party_code"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "item_id": itemId,
        "episode_id": episodeId,
        "party_code": partyCode,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
