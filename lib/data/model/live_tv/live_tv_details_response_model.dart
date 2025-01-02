import 'package:play_lab/data/model/global/common_api_response_model.dart';

class LiveTvDetailsResponseModel {
  LiveTvDetailsResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  LiveTvDetailsResponseModel.fromJson(dynamic json) {
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
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    Tv? tv,
    List<RelatedTv>? relatedTv,
    String? imagePath,
  }) {
    _tv = tv;
    _relatedTv = relatedTv;
    _imagePath = imagePath;
  }

  Data.fromJson(dynamic json) {
    _tv = json['tv'] != null ? Tv.fromJson(json['tv']) : null;
    if (json['related_tv'] != null) {
      _relatedTv = [];
      json['related_tv'].forEach((v) {
        _relatedTv?.add(RelatedTv.fromJson(v));
      });
    }
    _imagePath = json['image_path'];
  }
  Tv? _tv;
  List<RelatedTv>? _relatedTv;
  String? _imagePath;

  Tv? get tv => _tv;
  List<RelatedTv>? get relatedTv => _relatedTv;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_tv != null) {
      map['tv'] = _tv?.toJson();
    }
    if (_relatedTv != null) {
      map['related_tv'] = _relatedTv?.map((v) => v.toJson()).toList();
    }
    map['image_path'] = _imagePath;
    return map;
  }
}

class RelatedTv {
  RelatedTv({
    int? id,
    String? title,
    String? image,
    String? url,
    dynamic description,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _title = title;
    _image = image;
    _url = url;
    _description = description;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  RelatedTv.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _image = json['image'];
    _url = json['url'];
    _description = json['description'];
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _title;
  String? _image;
  String? _url;
  dynamic _description;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get title => _title;
  String? get image => _image;
  String? get url => _url;
  dynamic get description => _description;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    map['url'] = _url;
    map['description'] = _description;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Tv {
  Tv({
    int? id,
    String? title,
    String? image,
    String? url,
    dynamic description,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _title = title;
    _image = image;
    _url = url;
    _description = description;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Tv.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _image = json['image'];
    _url = json['url'];
    _description = json['description'];
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _title;
  String? _image;
  String? _url;
  dynamic _description;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get title => _title;
  String? get image => _image;
  String? get url => _url;
  String? get description => _description;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    map['url'] = _url;
    map['description'] = _description;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
