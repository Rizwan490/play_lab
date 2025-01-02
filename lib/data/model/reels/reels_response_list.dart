// To parse this JSON data, do
//
//     final userReelsListResponseModel = userReelsListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/global_meassage.dart';

UserReelsListResponseModel userReelsListResponseModelFromJson(String str) => UserReelsListResponseModel.fromJson(json.decode(str));

String userReelsListResponseModelToJson(UserReelsListResponseModel data) => json.encode(data.toJson());

class UserReelsListResponseModel {
  String? remark;
  String? status;
  MainData? data;
  Message? message;

  UserReelsListResponseModel({
    this.remark,
    this.status,
    this.data,
    this.message,
  });

  factory UserReelsListResponseModel.fromJson(Map<String, dynamic> json) => UserReelsListResponseModel(
        remark: json["remark"],
        status: json["status"],
        data: json["data"] == null ? null : MainData.fromJson(json["data"]),
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "data": data?.toJson(),
        "message": message?.toJson(),
      };
}

class MainData {
  List<Reel>? reels;
  String? lastId;
  List<String>? userLikesId;
  List<String>? userUnLikesId;
  List<String>? userListId;
  String? videoPath;

  MainData({
    this.reels,
    this.lastId,
    this.userLikesId,
    this.userUnLikesId,
    this.userListId,
    this.videoPath,
  });

  factory MainData.fromJson(Map<String, dynamic> json) => MainData(
        reels: json["reels"] == null ? [] : List<Reel>.from(json["reels"]!.map((x) => Reel.fromJson(x))),
        lastId: json["lastId"].toString(),
        userLikesId: json["userLikesId"] == null ? [] : List<String>.from(json["userLikesId"]!.map((x) => x.toString())),
        userUnLikesId: json["userUnLikesId"] == null ? [] : List<String>.from(json["userUnLikesId"]!.map((x) => x.toString())),
        userListId: json["userListId"] == null ? [] : List<String>.from(json["userListId"]!.map((x) => x.toString())),
        videoPath: json["videoPath"],
      );

  Map<String, dynamic> toJson() => {
        "reels": reels == null ? [] : List<dynamic>.from(reels!.map((x) => x.toJson())),
        "lastId": lastId,
        "userLikesId": userLikesId == null ? [] : List<dynamic>.from(userLikesId!.map((x) => x)),
        "userUnLikesId": userUnLikesId == null ? [] : List<dynamic>.from(userUnLikesId!.map((x) => x)),
        "userListId": userListId == null ? [] : List<dynamic>.from(userListId!.map((x) => x)),
        "videoPath": videoPath,
      };
}

class Reel {
  String? id; //
  String? title; //
  String? description; //
  String? video;
  String? likes; //
  String? unlikes; //
  String? status; //
  String? createdAt;
  String? updatedAt;

  Reel({
    this.id,
    this.title,
    this.description,
    this.video,
    this.likes,
    this.unlikes,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
        id: json["id"].toString(),
        title: json["title"].toString(),
        description: json["description"].toString(),
        video: json["video"].toString(),
        likes: json["likes"].toString(),
        unlikes: json["unlikes"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "likes": likes,
        "unlikes": unlikes,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
