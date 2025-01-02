import 'package:play_lab/data/model/global/telivision/telivision.dart';

class TelevisionListModel {
  List<Telivison>? data;
  dynamic nextPageUrl;

  TelevisionListModel({
    this.data,
    this.nextPageUrl,
  });

  factory TelevisionListModel.fromJson(Map<String, dynamic> json) => TelevisionListModel(
        data: json["data"] == null ? [] : List<Telivison>.from(json["data"]!.map((x) => Telivison.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}
