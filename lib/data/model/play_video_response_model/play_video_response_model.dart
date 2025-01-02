import 'package:play_lab/data/model/global/common_api_response_model.dart';

class PlayVideoResponseModel {
  PlayVideoResponseModel({String? remark, String? status, Message? message, Data? data}) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  PlayVideoResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    List<VideoQuality>? video,
    List<SubtitleModel>? subtitles,
    Map<String, String>? adsTime,
    String? subtitlePath,
  }) {
    _video = video;
    _subtitles = subtitles;
    _adsTime = adsTime;
    _subtitlePath = subtitlePath;
  }

  Data.fromJson(dynamic json) {
    _video = json["video"] == null ? [] : List<VideoQuality>.from(json["video"]!.map((x) => VideoQuality.fromJson(x)));
    if (json['subtitles'] != null) {
      _subtitles = [];
      json['subtitles'].forEach((v) {
        _subtitles?.add(SubtitleModel.fromJson(v));
      });
    }

    _adsTime = json["adsTime"] == null ? {} : Map.from(json["adsTime"]).map((k, v) => MapEntry<String, String>(k, v));

    _subtitlePath = json['subtitlePath'];
  }

  List<VideoQuality>? _video;
  List<SubtitleModel>? _subtitles;
  Map<String, String>? _adsTime;
  String? _subtitlePath;

  List<VideoQuality>? get video => _video;
  List<SubtitleModel>? get subtitles => _subtitles;
  Map<String, String>? get adsTime {
    return _adsTime;
  }

  String? get subtitlePath => _subtitlePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['video'] = _video;
    if (_subtitles != null) {
      map['subtitles'] = _subtitles?.map((v) => v.toJson()).toList();
    }
    map['subtitlePath'] = _subtitlePath;
    return map;
  }
}

class SubtitleModel {
  SubtitleModel({int? id, String? itemId, String? episodeId, String? videoId, String? language, String? code, String? file, String? createdAt, String? updatedAt}) {
    _id = id;
    _itemId = itemId;
    _episodeId = episodeId;
    _videoId = videoId;
    _language = language;
    _code = code;
    _file = file;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  SubtitleModel.fromJson(dynamic json) {
    _id = json['id'];
    _itemId = json['item_id'].toString();
    _episodeId = json['episode_id'].toString();
    _videoId = json['video_id'].toString();
    _language = json['language'];
    _code = json['code'].toString();
    _file = json['file'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _itemId;
  String? _episodeId;
  String? _videoId;
  String? _language;
  String? _code;
  String? _file;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get itemId => _itemId;
  String? get episodeId => _episodeId;
  String? get videoId => _videoId;
  String? get language => _language;
  String? get code => _code;
  String? get file => _file;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['item_id'] = _itemId;
    map['episode_id'] = _episodeId;
    map['video_id'] = _videoId;
    map['language'] = _language;
    map['code'] = _code;
    map['file'] = _file;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class AdInfo {
  final bool hasAds;
  final String adsUrl;
  final int? index;

  AdInfo({required this.hasAds, required this.adsUrl, this.index});
}

class VideoQuality {
  String? content;
  int? size;

  VideoQuality({
    this.content,
    this.size,
  });

  factory VideoQuality.fromJson(Map<String, dynamic> json) => VideoQuality(
        content: json["content"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "size": size,
      };
}
