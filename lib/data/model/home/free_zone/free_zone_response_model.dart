import 'package:play_lab/data/model/global/common_api_response_model.dart';

class FreeZoneResponseModel {
  FreeZoneResponseModel({
    String? remark,
    String? status,
    Message? message,
    MainData? mainData,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
  }

  FreeZoneResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _mainData = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MainData? _mainData;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MainData? get data => _mainData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_mainData != null) {
      map['data'] = _mainData?.toJson();
    }
    return map;
  }
}

class MainData {
  MainData({
    FreeZone? freeZone,
    String? portraitPath,
    String? landscapePath,
  }) {
    _freeZone = freeZone;
    _portraitPath = portraitPath;
    _landscapePath = landscapePath;
  }

  MainData.fromJson(dynamic json) {
    _freeZone = json['free_zone'] != null ? FreeZone.fromJson(json['free_zone']) : null;
    _portraitPath = json['portrait_path'];
    _landscapePath = json['landscape_path'];
  }
  FreeZone? _freeZone;
  String? _portraitPath;
  String? _landscapePath;

  FreeZone? get freeZone => _freeZone;
  String? get portraitPath => _portraitPath;
  String? get landscapePath => _landscapePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_freeZone != null) {
      map['free_zone'] = _freeZone?.toJson();
    }
    map['portrait_path'] = _portraitPath;
    map['landscape_path'] = _landscapePath;
    return map;
  }
}

class FreeZone {
  FreeZone({List<Data>? data, String? nextPageUrl}) {
    _data = data;
    _nextPageUrl = nextPageUrl;
  }

  FreeZone.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
  }
  List<Data>? _data;
  String? _nextPageUrl;

  List<Data>? get data => _data;
  String? get nextPageUrl => _nextPageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    return map;
  }
}

class Data {
  Data({
    Image? image,
    String? title,
    int? id,
    String? view,
    String? ratings,
  }) {
    _image = image;
    _title = title;
    _id = id;
    _view = view;
    _ratings = ratings;
  }

  Data.fromJson(dynamic json) {
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _title = json['title'];
    _id = json['id'];
    _view = json['view'].toString();
    _ratings = json['ratings'].toString();
  }
  Image? _image;
  String? _title;
  int? _id;
  String? _view;
  String? _ratings;

  Image? get image => _image;
  String? get title => _title;
  int? get id => _id;
  String? get view => _view;
  String? get ratings => _ratings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['title'] = _title;
    map['id'] = _id;
    map['view'] = _view;
    map['ratings'] = _ratings;
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
