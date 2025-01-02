import 'package:play_lab/data/model/global/common_api_response_model.dart';

class SingleBannerResponseModel {
  SingleBannerResponseModel({
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

  SingleBannerResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
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
    List<Single>? single,
    String? portraitPath,
    String? landscapePath,
  }) {
    _single = single;
    _portraitPath = portraitPath;
    _landscapePath = landscapePath;
  }

  Data.fromJson(dynamic json) {
    if (json['single'] != null) {
      _single = [];
      json['single'].forEach((v) {
        _single?.add(Single.fromJson(v));
      });
    }
    _portraitPath = json['portrait_path'];
    _landscapePath = json['landscape_path'];
  }
  List<Single>? _single;
  String? _portraitPath;
  String? _landscapePath;

  List<Single>? get single => _single;
  String? get portraitPath => _portraitPath;
  String? get landscapePath => _landscapePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_single != null) {
      map['single'] = _single?.map((v) => v.toJson()).toList();
    }
    map['portrait_path'] = _portraitPath;
    map['landscape_path'] = _landscapePath;
    return map;
  }
}

class Single {
  Single({
    Image? image,
    String? title,
    String? ratings,
    String? previewText,
    String? view,
    int? id,
    String? version,
    String? itemType,
    dynamic category,
  }) {
    _image = image;
    _title = title;
    _ratings = ratings;
    _previewText = previewText;
    _view = view;
    _id = id;
    _version = version;
    _itemType = itemType;
    _category = category;
  }

  Single.fromJson(dynamic json) {
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _title = json['title'];
    _ratings = json['ratings'] != null ? json['ratings'].toString() : '';
    _previewText = json['preview_text'];
    _view = json['view'].toString();
    _id = json['id'];
    _version = json['version'].toString();
    _itemType = json['item_type'].toString();
    _category = json['category'];
  }
  Image? _image;
  String? _title;
  String? _ratings;
  String? _previewText;
  String? _view;
  int? _id;
  String? _version;
  String? _itemType;
  dynamic _category;

  Image? get image => _image;
  String? get title => _title;
  String? get ratings => _ratings;
  String? get previewText => _previewText;
  String? get view => _view;
  int? get id => _id;
  String? get version => _version;
  String? get itemType => _itemType;
  dynamic get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['title'] = _title;
    map['ratings'] = _ratings;
    map['preview_text'] = _previewText;
    map['view'] = _view;
    map['id'] = _id;
    map['version'] = _version;
    map['item_type'] = _itemType;
    map['category'] = _category;
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
