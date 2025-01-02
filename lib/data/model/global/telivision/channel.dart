class Channel {
  String? id; //
  String? title;
  String? channelCatagoriId;
  String? description;
  String? image;
  String? url;
  String? status; //
  String? createdAt;
  String? updatedAt;

  Channel({
    this.id,
    this.title,
    this.channelCatagoriId,
    this.description,
    this.image,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        id: json["id"].toString(),
        title: json["title"],
        channelCatagoriId: json["channel_category_id"].toString(),
        description: json["description"],
        image: json["image"],
        url: json["url"],
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "channel_category_id": channelCatagoriId,
        "description": description,
        "image": image,
        "url": url,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
