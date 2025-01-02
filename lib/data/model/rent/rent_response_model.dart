// To parse this JSON data, do
//
//     final rentedItemsResponseModel = rentedItemsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/common_api_response_model.dart';
import 'package:play_lab/data/model/video_details/video_details_response_model/video_details.dart';

RentedItemsResponseModel rentedItemsResponseModelFromJson(String str) => RentedItemsResponseModel.fromJson(json.decode(str));

String rentedItemsResponseModelToJson(RentedItemsResponseModel data) => json.encode(data.toJson());

class RentedItemsResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  RentedItemsResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory RentedItemsResponseModel.fromJson(Map<String, dynamic> json) => RentedItemsResponseModel(
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
  RentedItems? rentedItems;
  String? landScapePath;
  String? portRaitPath;

  Data({
    this.rentedItems,
    this.landScapePath,
    this.portRaitPath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rentedItems: json["rentedItems"] == null ? null : RentedItems.fromJson(json["rentedItems"]),
        landScapePath: json["landscape_path"],
        portRaitPath: json["portrait_path"],
      );

  Map<String, dynamic> toJson() => {
        "rentedItems": rentedItems?.toJson(),
      };
}

class RentedItems {
  List<RentVideo>? data;

  String? nextPageUrl;
  String? path;

  RentedItems({
    this.data,
    this.nextPageUrl,
    this.path,
  });

  factory RentedItems.fromJson(Map<String, dynamic> json) => RentedItems(
        data: json["data"] == null ? [] : List<RentVideo>.from(json["data"]!.map((x) => RentVideo.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<RentVideo>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class RentVideo {
  String? id; //
  String? userId; //
  String? planId; //
  String? itemId; //
  String? expiredDate;
  String? status; //
  String? createdAt;
  String? updatedAt;
  Item? item;

  RentVideo({
    this.id,
    this.userId,
    this.planId,
    this.itemId,
    this.expiredDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.item,
  });

  factory RentVideo.fromJson(Map<String, dynamic> json) => RentVideo(
        id: json["id"].toString(),
        userId: json["user_id"].toString(),
        planId: json["plan_id"].toString(),
        itemId: json["item_id"].toString(),
        expiredDate: json["expired_date"],
        status: json["status"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "plan_id": planId,
        "item_id": itemId,
        "expired_date": expiredDate,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "item": item?.toJson(),
      };
}
