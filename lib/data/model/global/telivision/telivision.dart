import 'package:play_lab/data/model/global/telivision/channel.dart';

class Telivison {
  String? id; //
  String? name;
  String? price;
  String? status; //
  String? createdAt;
  String? updatedAt;
  List<Channel>? channels;

  Telivison({
    this.id,
    this.name,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.channels,
  });

  factory Telivison.fromJson(Map<String, dynamic> json) => Telivison(
        id: json["id"].toString(),
        name: json["name"].toString(),
        price: json["price"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        channels: json["channels"] == null ? [] : List<Channel>.from(json["channels"]!.map((x) => Channel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "channels": channels == null ? [] : List<dynamic>.from(channels!.map((x) => x.toJson())),
      };
}
