// To parse this JSON data, do
//
//     final pusherPlayerSettingsResponseModel = pusherPlayerSettingsResponseModelFromJson(jsonString);

import 'dart:convert';

PusherPlayerSettingsResponseModel pusherPlayerSettingsResponseModelFromJson(String str) => PusherPlayerSettingsResponseModel.fromJson(json.decode(str));

String pusherPlayerSettingsResponseModelToJson(PusherPlayerSettingsResponseModel data) => json.encode(data.toJson());

class PusherPlayerSettingsResponseModel {
  List<String>? allMemberId;
  String? status;
  String? partyCode;
  String? remark;

  PusherPlayerSettingsResponseModel({
    this.allMemberId,
    this.status,
    this.partyCode,
    this.remark,
  });

  factory PusherPlayerSettingsResponseModel.fromJson(Map<String, dynamic> json) => PusherPlayerSettingsResponseModel(
        allMemberId: json["allMemberId"] == null ? [] : List<String>.from(json["allMemberId"]!.map((x) => x.toString())),
        status: json["status"],
        partyCode: json["partyCode"] ?? '',
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "allMemberId": allMemberId == null ? [] : List<dynamic>.from(allMemberId!.map((x) => x)),
        "status": status,
        "remark": remark,
      };
}
