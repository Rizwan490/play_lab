// To parse this JSON data, do
//
//     final playerSettingsEventModel = playerSettingsEventModelFromJson(jsonString);

import 'dart:convert';

PlayerSettingsEventModel playerSettingsEventModelFromJson(String str) => PlayerSettingsEventModel.fromJson(json.decode(str));

String playerSettingsEventModelToJson(PlayerSettingsEventModel data) => json.encode(data.toJson());

class PlayerSettingsEventModel {
  List<String>? allMemberId;
  String? status;

  PlayerSettingsEventModel({
    this.allMemberId,
    this.status,
  });

  factory PlayerSettingsEventModel.fromJson(Map<String, dynamic> json) => PlayerSettingsEventModel(
        allMemberId: json["allMemberId"] == null ? [] : List<String>.from(json["allMemberId"]!.map((x) => x.toString())),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "allMemberId": allMemberId == null ? [] : List<dynamic>.from(allMemberId!.map((x) => x)),
        "status": status,
      };
}
