// To parse this JSON data, do
//
//     final projectPlanResponseModel = projectPlanResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/common_api_response_model.dart';
import 'package:play_lab/data/model/global/tournament/tournament_model.dart';
import 'package:play_lab/data/model/global/telivision/channel.dart';

DashBoardResponseModel projectPlanResponseModelFromJson(String str) => DashBoardResponseModel.fromJson(json.decode(str));

String projectPlanResponseModelToJson(DashBoardResponseModel data) => json.encode(data.toJson());

class DashBoardResponseModel {
  String? remark;
  String? status;
  Message? message;
  DashBoardResponseModelData? data;

  DashBoardResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory DashBoardResponseModel.fromJson(Map<String, dynamic> json) => DashBoardResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : DashBoardResponseModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class DashBoardResponseModelData {
  MainData? data;
  Path? path;

  DashBoardResponseModelData({
    this.data,
    this.path,
  });

  factory DashBoardResponseModelData.fromJson(Map<String, dynamic> json) => DashBoardResponseModelData(
        data: json["data"] == null ? null : MainData.fromJson(json["data"]),
        path: json["path"] == null ? null : Path.fromJson(json["path"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "path": path?.toJson(),
      };
}

class MainData {
  List<Slider>? sliders;
  TelevisionData? televisions;
  List<Featured>? featured;
  List<TournamentModel>? tournaments;
  List<Featured>? recentlyAdded;
  List<Featured>? latestSeries;
  List<Featured>? single;
  List<Featured>? trailer;
  List<Featured>? rent;
  List<Featured>? freeZone;
  dynamic advertise;
  MainData({
    this.sliders,
    this.televisions,
    this.featured,
    this.tournaments,
    this.recentlyAdded,
    this.latestSeries,
    this.single,
    this.trailer,
    this.rent,
    this.freeZone,
    this.advertise,
  });

  factory MainData.fromJson(Map<String, dynamic> json) => MainData(
        sliders: json["sliders"] == null ? [] : List<Slider>.from(json["sliders"]!.map((x) => Slider.fromJson(x))),
        televisions: json["televisions"] == null ? null : TelevisionData.fromJson(json['televisions']),
        featured: json["featured"] == null ? [] : List<Featured>.from(json["featured"]!.map((x) => Featured.fromJson(x))),
        tournaments: json["tournaments"] == null ? [] : List<TournamentModel>.from(json["tournaments"]!.map((x) => TournamentModel.fromJson(x))),
        recentlyAdded: json["recently_added"] == null ? [] : List<Featured>.from(json["recently_added"]!.map((x) => Featured.fromJson(x))),
        latestSeries: json["latest_series"] == null ? [] : List<Featured>.from(json["latest_series"]!.map((x) => Featured.fromJson(x))),
        single: json["single"] == null ? [] : List<Featured>.from(json["single"]!.map((x) => Featured.fromJson(x))),
        trailer: json["trailer"] == null ? [] : List<Featured>.from(json["trailer"]!.map((x) => Featured.fromJson(x))),
        rent: json["rent"] == null ? [] : List<Featured>.from(json["rent"]!.map((x) => Featured.fromJson(x))),
        freeZone: json["free_zone"] == null ? [] : List<Featured>.from(json["free_zone"]!.map((x) => Featured.fromJson(x))),
        advertise: json["advertise"],
      );

  Map<String, dynamic> toJson() => {
        "sliders": sliders == null ? [] : List<dynamic>.from(sliders!.map((x) => x.toJson())),
        "featured": featured == null ? [] : List<dynamic>.from(featured!.map((x) => x.toJson())),
        "recently_added": recentlyAdded == null ? [] : List<dynamic>.from(recentlyAdded!.map((x) => x.toJson())),
        "latest_series": latestSeries == null ? [] : List<dynamic>.from(latestSeries!.map((x) => x.toJson())),
        "single": single == null ? [] : List<dynamic>.from(single!.map((x) => x.toJson())),
        "trailer": trailer == null ? [] : List<dynamic>.from(trailer!.map((x) => x.toJson())),
        "rent": rent == null ? [] : List<dynamic>.from(rent!.map((x) => x.toJson())),
        "free_zone": freeZone == null ? [] : List<dynamic>.from(freeZone!.map((x) => x.toJson())),
        "advertise": advertise,
      };
}

class Featured {
  int? id; //
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
  String? rentPrice;
  String? rentalPeriod; //
  String? excludePlan; //
  String? createdAt;
  String? updatedAt;
  Category? category;
  Category? subCategory;

  Featured({
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
    this.rentPrice,
    this.rentalPeriod,
    this.excludePlan,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.subCategory,
  });

  factory Featured.fromJson(Map<String, dynamic> json) => Featured(
        id: json["id"] ?? -1,
        categoryId: json["category_id"].toString(),
        subCategoryId: json["sub_category_id"].toString(),
        slug: json["slug"],
        title: json["title"],
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
        tags: json["tags"],
        ratings: json["ratings"],
        view: json["view"].toString(),
        isTrailer: json["is_trailer"].toString(),
        rentPrice: json["rent_price"].toString(),
        rentalPeriod: json["rental_period"].toString(),
        excludePlan: json["exclude_plan"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        subCategory: json["sub_category"] == null ? null : Category.fromJson(json["sub_category"]),
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
        "rent_price": rentPrice,
        "rental_period": rentalPeriod,
        "exclude_plan": excludePlan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category": category?.toJson(),
        "sub_category": subCategory?.toJson(),
      };
}

class Category {
  int? id; //
  String? name;
  String? status; //
  String? createdAt;
  String? updatedAt;
  String? categoryId; //

  Category({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] ?? -1,
        name: json["name"],
        status: json["status"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        categoryId: json["category_id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category_id": categoryId,
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

class Slider {
  int? id; //
  String? itemId; //
  String? image;
  String? captionShow; //
  String? status; //
  String? createdAt;
  String? updatedAt;
  Featured? item;

  Slider({
    this.id,
    this.itemId,
    this.image,
    this.captionShow,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.item,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"] ?? -1,
        itemId: json["item_id"].toString(),
        image: json["image"],
        captionShow: json["caption_show"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        item: json["item"] == null ? null : Featured.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "image": image,
        "caption_show": captionShow,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "item": item?.toJson(),
      };
}

class Path {
  String? portrait;
  String? landscape;
  String? television;
  String? ads;
  String? tournament;

  Path({
    this.portrait,
    this.landscape,
    this.television,
    this.ads,
    this.tournament,
  });

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        portrait: json["portrait"],
        landscape: json["landscape"],
        television: json["television"],
        ads: json["ads"],
        tournament: json["tournament"],
      );

  Map<String, dynamic> toJson() => {
        "portrait": portrait,
        "landscape": landscape,
        "television": television,
        "ads": ads,
      };
}

class TelevisionData {
  List<Channel>? data;
  dynamic nextPageUrl;

  TelevisionData({
    this.data,
    this.nextPageUrl,
  });

  factory TelevisionData.fromJson(Map<String, dynamic> json) => TelevisionData(
        data: json["data"] == null ? [] : List<Channel>.from(json["data"]!.map((x) => Channel.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}
