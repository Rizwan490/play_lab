// To parse this JSON data, do
//
//     final roomDetailsResponseModel = roomDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/common_api_response_model.dart';
import 'package:play_lab/data/model/global/global_user_model.dart';

RoomDetailsResponseModel roomDetailsResponseModelFromJson(String str) => RoomDetailsResponseModel.fromJson(json.decode(str));

String roomDetailsResponseModelToJson(RoomDetailsResponseModel data) => json.encode(data.toJson());

class RoomDetailsResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  RoomDetailsResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory RoomDetailsResponseModel.fromJson(Map<String, dynamic> json) => RoomDetailsResponseModel(
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
  PartyRoom? partyRoom;
  List<VideoElement>? videos;
  List<RoomVideoSubtitle>? subtitles;
  Item? item;
  List<Conversation>? conversations;
  List<Conversation>? partyMembers;

  Data({
    this.partyRoom,
    this.videos,
    this.subtitles,
    this.item,
    this.conversations,
    this.partyMembers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        partyRoom: json["partyRoom"] == null ? null : PartyRoom.fromJson(json["partyRoom"]),
        videos: json["videos"] == null ? [] : List<VideoElement>.from(json["videos"]!.map((x) => VideoElement.fromJson(x))),
        subtitles: json["subtitles"] == null ? [] : List<RoomVideoSubtitle>.from(json["subtitles"]!.map((x) => RoomVideoSubtitle.fromJson(x))),
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        conversations: json["conversations"] == null ? [] : List<Conversation>.from(json["conversations"]!.map((x) => Conversation.fromJson(x))),
        partyMembers: json["partyMembers"] == null ? [] : List<Conversation>.from(json["partyMembers"]!.map((x) => Conversation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partyRoom": partyRoom?.toJson(),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
        "subtitles": subtitles == null ? [] : List<dynamic>.from(subtitles!.map((x) => x.toJson())),
        "item": item?.toJson(),
        "conversations": conversations == null ? [] : List<dynamic>.from(conversations!.map((x) => x.toJson())),
        "partyMembers": partyMembers == null ? [] : List<dynamic>.from(partyMembers!.map((x) => x.toJson())),
      };
}

class Conversation {
  String? id; //
  String? watchPartyId; //
  String? userId; //
  String? message;
  String? createdAt;
  String? updatedAt;
  GlobalUser? user;
  String? status; //

  Conversation({
    this.id,
    this.watchPartyId,
    this.userId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.status,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["id"].toString(),
        watchPartyId: json["watch_party_id"].toString(),
        userId: json["user_id"].toString(),
        message: json["message"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        user: json["user"] == null ? null : GlobalUser.fromJson(json["user"]),
        status: json["status"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "watch_party_id": watchPartyId,
        "user_id": userId,
        "message": message,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user?.toJson(),
        "status": status,
      };
}

class Item {
  String? id; //
  String? categoryId; //
  String? subCategoryId; //
  String? slug;
  String? title;
  String? previewText;
  String? description;
  Team? team;
  Image? image;
  String? itemType; //
  String? status; //
  String? single; //
  String? trending; //
  String? featured; //
  String? version; //
  String? tags;
  String? ratings;
  String? view; //
  String? isTrailer; //
  String? createdAt;
  String? updatedAt;
  ItemVideo? video;

  Item({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.slug,
    this.title,
    this.previewText,
    this.description,
    this.team,
    this.image,
    this.itemType,
    this.status,
    this.single,
    this.trending,
    this.featured,
    this.version,
    this.tags,
    this.ratings,
    this.view,
    this.isTrailer,
    this.createdAt,
    this.updatedAt,
    this.video,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"].toString(),
        categoryId: json["category_id"].toString(),
        subCategoryId: json["sub_category_id"].toString(),
        slug: json["slug"].toString(),
        title: json["title"].toString(),
        previewText: json["preview_text"],
        description: json["description"],
        team: json["team"] == null ? null : Team.fromJson(json["team"]),
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        itemType: json["item_type"].toString(),
        status: json["status"].toString(),
        single: json["single"].toString(),
        trending: json["trending"].toString(),
        featured: json["featured"].toString(),
        version: json["version"].toString(),
        tags: json["tags"].toString(),
        ratings: json["ratings"].toString(),
        view: json["view"].toString(),
        isTrailer: json["is_trailer"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        video: json["video"] == null ? null : ItemVideo.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "slug": slug,
        "title": title,
        "preview_text": previewText,
        "description": description,
        "team": team?.toJson(),
        "image": image?.toJson(),
        "item_type": itemType,
        "status": status,
        "single": single,
        "trending": trending,
        "featured": featured,
        "version": version,
        "tags": tags,
        "ratings": ratings,
        "view": view,
        "is_trailer": isTrailer,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "video": video?.toJson(),
      };
}

class Image {
  String? landscape;
  String? portrait;

  Image({
    this.landscape,
    this.portrait,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        landscape: json["landscape"],
        portrait: json["portrait"],
      );

  Map<String, dynamic> toJson() => {
        "landscape": landscape,
        "portrait": portrait,
      };
}

class Team {
  String? director;
  String? producer;
  String? casts;
  String? genres;
  String? language;

  Team({
    this.director,
    this.producer,
    this.casts,
    this.genres,
    this.language,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        director: json["director"],
        producer: json["producer"],
        casts: json["casts"],
        genres: json["genres"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "director": director,
        "producer": producer,
        "casts": casts,
        "genres": genres,
        "language": language,
      };
}

class ItemVideo {
  String? id; //
  String? episodeId; //
  String? itemId; //
  String? videoTypeSevenTwenty; //
  String? videoTypeThreeSixty; //
  String? videoTypeFourEighty; //
  String? videoTypeThousandEighty; //
  String? sevenTwentyVideo;
  String? threeSixtyVideo;
  String? fourEightyVideo;
  String? thousandEightyVideo;
  String? serverSevenTwenty;
  String? serverThreeSixty;
  String? serverFourEighty;
  String? serverThousandEighty;
  List<String>? adsTime;
  List<String>? seconds;
  String? createdAt;
  String? updatedAt;
  List<RoomVideoSubtitle>? subtitles;

  ItemVideo({
    this.id,
    this.episodeId,
    this.itemId,
    this.videoTypeSevenTwenty,
    this.videoTypeThreeSixty,
    this.videoTypeFourEighty,
    this.videoTypeThousandEighty,
    this.sevenTwentyVideo,
    this.threeSixtyVideo,
    this.fourEightyVideo,
    this.thousandEightyVideo,
    this.serverSevenTwenty,
    this.serverThreeSixty,
    this.serverFourEighty,
    this.serverThousandEighty,
    this.adsTime,
    this.seconds,
    this.createdAt,
    this.updatedAt,
    this.subtitles,
  });

  factory ItemVideo.fromJson(Map<String, dynamic> json) => ItemVideo(
        id: json["id"].toString(),
        episodeId: json["episode_id"].toString(),
        itemId: json["item_id"].toString(),
        videoTypeSevenTwenty: json["video_type_seven_twenty"].toString(),
        videoTypeThreeSixty: json["video_type_three_sixty"].toString(),
        videoTypeFourEighty: json["video_type_four_eighty"].toString(),
        videoTypeThousandEighty: json["video_type_thousand_eighty"].toString(),
        sevenTwentyVideo: json["seven_twenty_video"].toString(),
        threeSixtyVideo: json["three_sixty_video"].toString(),
        fourEightyVideo: json["four_eighty_video"].toString(),
        thousandEightyVideo: json["thousand_eighty_video"].toString(),
        serverSevenTwenty: json["server_seven_twenty"].toString(),
        serverThreeSixty: json["server_three_sixty"].toString(),
        serverFourEighty: json["server_four_eighty"].toString(),
        serverThousandEighty: json["server_thousand_eighty"].toString(),
        adsTime: json["ads_time"] == null ? [] : List<String>.from(json["ads_time"]!.map((x) => x)),
        seconds: json["seconds"] == null ? [] : List<String>.from(json["seconds"]!.map((x) => x.toString())),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        subtitles: json["subtitles"] == null ? [] : List<RoomVideoSubtitle>.from(json["subtitles"]!.map((x) => RoomVideoSubtitle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "episode_id": episodeId,
        "item_id": itemId,
        "video_type_seven_twenty": videoTypeSevenTwenty,
        "video_type_three_sixty": videoTypeThreeSixty,
        "video_type_four_eighty": videoTypeFourEighty,
        "video_type_thousand_eighty": videoTypeThousandEighty,
        "seven_twenty_video": sevenTwentyVideo,
        "three_sixty_video": threeSixtyVideo,
        "four_eighty_video": fourEightyVideo,
        "thousand_eighty_video": thousandEightyVideo,
        "server_seven_twenty": serverSevenTwenty,
        "server_three_sixty": serverThreeSixty,
        "server_four_eighty": serverFourEighty,
        "server_thousand_eighty": serverThousandEighty,
        "ads_time": adsTime == null ? [] : List<dynamic>.from(adsTime!.map((x) => x)),
        "seconds": seconds == null ? [] : List<dynamic>.from(seconds!.map((x) => x)),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "subtitles": subtitles == null ? [] : List<dynamic>.from(subtitles!.map((x) => x.toJson())),
      };
}

class RoomVideoSubtitle {
  String? id; //
  String? itemId; //
  String? episodeId; //
  String? videoId; //
  String? language;
  String? code;
  String? file;
  String? createdAt;
  String? updatedAt;

  RoomVideoSubtitle({
    this.id,
    this.itemId,
    this.episodeId,
    this.videoId,
    this.language,
    this.code,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  factory RoomVideoSubtitle.fromJson(Map<String, dynamic> json) => RoomVideoSubtitle(
        id: json["id"].toString(),
        itemId: json["item_id"].toString(),
        episodeId: json["episode_id"].toString(),
        videoId: json["video_id"].toString(),
        language: json["language"],
        code: json["code"],
        file: json["file"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "episode_id": episodeId,
        "video_id": videoId,
        "language": language,
        "code": code,
        "file": file,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class PartyRoom {
  String? id; //
  String? userId; //
  String? itemId; //
  String? episodeId; //
  String? partyCode;
  String? closedAt;
  String? status; //
  String? createdAt;
  String? updatedAt;
  Item? item;
  dynamic episode;
  GlobalUser? user;

  PartyRoom({
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
    this.user,
  });

  factory PartyRoom.fromJson(Map<String, dynamic> json) => PartyRoom(
        id: json["id"].toString(),
        userId: json["user_id"].toString(),
        itemId: json["item_id"].toString(),
        episodeId: json["episode_id"].toString(),
        partyCode: json["party_code"].toString(),
        closedAt: json["closed_at"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        episode: json["episode"],
        user: json["user"] == null ? null : GlobalUser.fromJson(json["user"]),
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
        "episode": episode,
        "user": user?.toJson(),
      };
}

class VideoElement {
  String? content;
  String? size;

  VideoElement({
    this.content,
    this.size,
  });

  factory VideoElement.fromJson(Map<String, dynamic> json) => VideoElement(
        content: json["content"].toString(),
        size: json["size"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "size": size,
      };
}
