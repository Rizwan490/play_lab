import 'package:play_lab/data/model/global/common_api_response_model.dart';

class LatestSeriesResponseModel {
  LatestSeriesResponseModel({
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

  LatestSeriesResponseModel.fromJson(dynamic json) {
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
    List<Latest>? latest,
    String? portraitPath,
    String? landScapePath,
  }) {
    _latest = latest;
    _portraitPath = portraitPath;
    _landscapePath = landScapePath;
  }

  Data.fromJson(dynamic json) {
    if (json['latest'] != null) {
      _latest = [];
      json['latest'].forEach((v) {
        _latest?.add(Latest.fromJson(v));
      });
    }
    _portraitPath = json['portrait_path'];
    _landscapePath = json['landscape_path'];
  }
  List<Latest>? _latest;
  String? _portraitPath;
  String? _landscapePath;

  List<Latest>? get latest => _latest;
  String? get portraitPath => _portraitPath;
  String? get landscapePath => _landscapePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_latest != null) {
      map['latest'] = _latest?.map((v) => v.toJson()).toList();
    }
    map['portrait_path'] = _portraitPath;
    map['landscape_path'] = _landscapePath;
    return map;
  }
}

class Latest {
  Latest({
    String? title,
    Image? image,
    int? id,
    String? version,
    String? itemType,
  }) {
    _title = title;
    _image = image;
    _id = id;
    _version = version;
    _itemType = itemType;
  }

  Latest.fromJson(dynamic json) {
    _title = json['title'];
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _id = json['id'];
    _version = json['version'].toString();
    _itemType = json['item_type'].toString();
  }
  String? _title;
  Image? _image;
  int? _id;
  String? _version;
  String? _itemType;

  String? get title => _title;
  Image? get image => _image;
  int? get id => _id;
  String? get version => _version;
  String? get itemType => _itemType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['id'] = _id;
    map['version'] = _version;
    map['item_type'] = _itemType;
    return map;
  }
}

class Image {
  Image({
    String? landscape,
    String? portrait,
  }) {
    _landscape = landscape;
    _portrait = portrait;
  }

  Image.fromJson(dynamic json) {
    _landscape = json['landscape'];
    _portrait = json['portrait'];
  }
  String? _landscape;
  String? _portrait;

  String? get landscape => _landscape;
  String? get portrait => _portrait;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['landscape'] = _landscape;
    map['portrait'] = _portrait;
    return map;
  }
}
