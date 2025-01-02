import 'package:play_lab/data/model/global/common_api_response_model.dart';

class FeaturedMovieResponseModel {
  FeaturedMovieResponseModel({
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

  FeaturedMovieResponseModel.fromJson(dynamic json) {
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
    List<Featured>? featured,
    String? landscapePath,
    String? portraitPath,
  }) {
    _featured = featured;
    _landscapePath = landscapePath;
    _portraitPath = portraitPath;
  }

  Data.fromJson(dynamic json) {
    if (json['featured'] != null) {
      _featured = [];
      json['featured'].forEach((v) {
        _featured?.add(Featured.fromJson(v));
      });
    }
    _landscapePath = json['landscape_path'];
    _portraitPath = json['portrait_path'];
  }
  List<Featured>? _featured;
  String? _landscapePath;
  String? _portraitPath;

  List<Featured>? get featured => _featured;
  String? get landscapePath => _landscapePath;
  String? get portraitPath => _portraitPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_featured != null) {
      map['featured'] = _featured?.map((v) => v.toJson()).toList();
    }
    map['landscape_path'] = _landscapePath;
    map['portrait_path'] = _portraitPath;
    return map;
  }
}

class Featured {
  Featured({
    String? title,
    Image? image,
    int? id,
    String? version,
    String? itemType,
    String? categoryId,
    String? subCategoryId,
    String? view,
  }) {
    _title = title;
    _image = image;
    _id = id;
    _version = version;
    _itemType = itemType;
    _categoryId = categoryId;
    _subCategoryId = subCategoryId;
    _view = view;
  }

  Featured.fromJson(dynamic json) {
    _title = json['title'];
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _id = json['id'];
    _version = json['version'].toString();
    _itemType = json['item_type'].toString();
    _categoryId = json['category_id'].toString();
    _subCategoryId = json['sub_category_id'].toString();
    _view = json['view'].toString();
  }

  String? _title;
  Image? _image;
  int? _id;
  String? _version;
  String? _itemType;
  String? _categoryId;
  String? _subCategoryId;
  String? _view;

  String? get title => _title;
  Image? get image => _image;
  int? get id => _id;
  String? get version => _version;
  String? get itemType => _itemType;
  String? get categoryId => _categoryId;
  String? get subCategoryId => _subCategoryId;
  String? get view => _view;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['id'] = _id;
    map['version'] = _version;
    map['item_type'] = _itemType;
    map['category_id'] = _categoryId;
    map['sub_category_id'] = _subCategoryId;
    map['view'] = _view;
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
