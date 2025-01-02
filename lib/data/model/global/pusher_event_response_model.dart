// To parse this JSON data, do
//
//     final pusherResponseModel = pusherResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/party_room/room_details_response_model.dart';

PusherResponseModel pusherResponseModelFromJson(String str) => PusherResponseModel.fromJson(json.decode(str));

String pusherResponseModelToJson(PusherResponseModel data) => json.encode(data.toJson());

class PusherResponseModel {
  String? redirectUrl;
  String? userId;
  String? hostId;
  String? html;
  String? partyCode;
  String? status; // only for video play
  List<String>? allMemberId; //
  Conversation? conversation;
  String? username; // only for join & remove request
  String? requestMemberId; // only for join & remove request
  //
  String? remark;
  String? eventName;
  String? channelName;

  PusherResponseModel({
    this.redirectUrl,
    this.userId,
    this.hostId,
    this.html,
    this.partyCode,
    this.status,
    this.allMemberId,
    this.conversation, //
    this.username, //
    this.requestMemberId, //
    this.remark,
    this.eventName,
    this.channelName,
  });

  PusherResponseModel copyWith({
    String? redirectUrl,
    String? userId,
    String? hostId,
    String? html,
    String? partyCode,
    List<String>? allMemberId,
    Conversation? conversation,
    String? username,
    String? requestMemberId,
    String? status,
    String? remark,
    String? eventName,
    String? channelName,
  }) =>
      PusherResponseModel(
        redirectUrl: redirectUrl,
        userId: userId.toString(),
        hostId: hostId.toString(),
        html: html.toString(),
        partyCode: partyCode.toString(),
        status: status.toString(),
        remark: remark.toString(),
        username: username.toString(),
        requestMemberId: requestMemberId.toString(),
        allMemberId: allMemberId ?? [],
        conversation: conversation,
        eventName: eventName.toString(),
        channelName: channelName.toString(),
      );

  factory PusherResponseModel.fromJson(Map<String, dynamic> json) => PusherResponseModel(
        redirectUrl: json["redirectUrl"],
        userId: json["userId"].toString(),
        hostId: json["hostId"].toString(),
        html: json["html"].toString(),
        partyCode: json["partyCode"].toString(),
        status: json["status"].toString(),
        username: json["user"].toString(),
        requestMemberId: json["memberId"].toString(),
        allMemberId: json["allMemberId"] == null ? [] : List<String>.from(json['allMemberId']).map((e) => e.toString()).toList(),
        conversation: json["conversation"] == null ? null : Conversation.fromJson(json["conversation"]),
        remark: json["remark"].toString(),
        eventName: json["eventName"].toString(),
        channelName: json["channelName"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "redirectUrl": redirectUrl,
        "userId": userId,
        "hostId": hostId,
        "html": html,
        "partyCode": partyCode,
        "status": status,
        "user": username,
        "allMemberId": allMemberId,
        "conversation": conversation,
        "remark": remark,
        "eventName": eventName,
        "channelName": channelName,
      };
}
