// To parse this JSON data, do
//
//     final supportTicketListResponseModel = supportTicketListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:play_lab/data/model/global/common_api_response_model.dart';

SupportTicketListResponseModel supportTicketListResponseModelFromJson(String str) => SupportTicketListResponseModel.fromJson(json.decode(str));

String supportTicketListResponseModelToJson(SupportTicketListResponseModel data) => json.encode(data.toJson());

class SupportTicketListResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  SupportTicketListResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory SupportTicketListResponseModel.fromJson(Map<String, dynamic> json) => SupportTicketListResponseModel(
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
  Tickets? tickets;

  Data({
    this.tickets,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tickets: json["tickets"] == null ? null : Tickets.fromJson(json["tickets"]),
      );

  Map<String, dynamic> toJson() => {
        "tickets": tickets?.toJson(),
      };
}

class Tickets {
  int? currentPage;
  List<TicketData>? data;

  String? nextPageUrl;
  String? path;

  Tickets({
    this.currentPage,
    this.data,
    this.nextPageUrl,
    this.path,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<TicketData>.from(json["data"]!.map((x) => TicketData.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
      };
}

class TicketData {
  int? id;
  String? userId;
  String? name;
  String? email;
  String? ticket;
  String? subject;
  String? status;
  String? priority;
  String? lastReply;
  String? createdAt;
  String? updatedAt;

  TicketData({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.ticket,
    this.subject,
    this.status,
    this.priority,
    this.lastReply,
    this.createdAt,
    this.updatedAt,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
        id: json["id"],
        userId: json["user_id"].toString(),
        name: json["name"].toString(),
        email: json["email"].toString(),
        ticket: json["ticket"].toString(),
        subject: json["subject"].toString(),
        status: json["status"].toString(),
        priority: json["priority"].toString(),
        lastReply: json["last_reply"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "ticket": ticket,
        "subject": subject,
        "status": status,
        "priority": priority,
        "last_reply": lastReply,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
