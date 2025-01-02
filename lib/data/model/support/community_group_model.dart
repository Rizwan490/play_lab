// To parse this JSON data, do
//
//     final communityGroup = communityGroupFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/common_api_response_model.dart';

CommunityGroup communityGroupFromJson(String str) => CommunityGroup.fromJson(json.decode(str));

String communityGroupToJson(CommunityGroup data) => json.encode(data.toJson());

class CommunityGroup {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  CommunityGroup({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory CommunityGroup.fromJson(Map<String, dynamic> json) => CommunityGroup(
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
  List<CommunityGroupElement>? communityGroups;
  String? communityGroupImagePath;

  Data({
    this.communityGroups,
    this.communityGroupImagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        communityGroups: json["community_groups"] == null ? [] : List<CommunityGroupElement>.from(json["community_groups"]!.map((x) => CommunityGroupElement.fromJson(x))),
        communityGroupImagePath: json["community_group_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "community_groups": communityGroups == null ? [] : List<dynamic>.from(communityGroups!.map((x) => x.toJson())),
        "community_group_image_path": communityGroupImagePath,
      };
}

class CommunityGroupElement {
  String? id;
  String? dataKeys;
  DataValues? dataValues;
  String? tempname;
  String? createdAt;
  String? updatedAt;

  CommunityGroupElement({
    this.id,
    this.dataKeys,
    this.dataValues,
    this.tempname,
    this.createdAt,
    this.updatedAt,
  });

  factory CommunityGroupElement.fromJson(Map<String, dynamic> json) => CommunityGroupElement(
        id: json["id"].toString(),
        dataKeys: json["data_keys"].toString(),
        dataValues: json["data_values"] == null ? null : DataValues.fromJson(json["data_values"]),
        tempname: json["tempname"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data_keys": dataKeys,
        "data_values": dataValues?.toJson(),
        "tempname": tempname,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class DataValues {
  String? hasImage;
  String? name;
  String? url;
  String? image;

  DataValues({
    this.hasImage,
    this.name,
    this.url,
    this.image,
  });

  factory DataValues.fromJson(Map<String, dynamic> json) => DataValues(
        hasImage: json["has_image"].toString(),
        name: json["name"].toString(),
        url: json["url"].toString(),
        image: json["image"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "has_image": hasImage,
        "name": name,
        "url": url,
        "image": image,
      };
}
