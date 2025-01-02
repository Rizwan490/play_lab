import 'package:play_lab/data/model/global/common_api_response_model.dart';

class AllMovieResponseModel {
  AllMovieResponseModel({
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

  AllMovieResponseModel.fromJson(dynamic json) {
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
  MainData? get mainData => _mainData;

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
    Movies? movies,
    String? portraitPath,
    String? landscapePath,
  }) {
    _movies = movies;
    _portraitPath = portraitPath;
    _landscapePath = landscapePath;
  }

  MainData.fromJson(dynamic json) {
    _movies = json['movies'] != null ? Movies.fromJson(json['movies']) : null;
    _portraitPath = json['portrait_path'];
    _landscapePath = json['landscape_path'];
  }
  Movies? _movies;
  String? _portraitPath;
  String? _landscapePath;

  Movies? get movies => _movies;
  String? get portraitPath => _portraitPath;
  String? get landscapePath => _landscapePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_movies != null) {
      map['movies'] = _movies?.toJson();
    }
    map['portrait_path'] = _portraitPath;
    map['landscape_path'] = _landscapePath;
    return map;
  }
}

class Movies {
  Movies({List<Data>? data, dynamic nextPageUrl}) {
    _data = data;
    _nextPageUrl = nextPageUrl;
  }

  Movies.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
  }

  List<Data>? _data;
  dynamic _nextPageUrl;

  List<Data>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;

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

  Data.fromJson(dynamic json) {
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
