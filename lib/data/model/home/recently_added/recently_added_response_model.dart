import 'package:play_lab/data/model/global/common_api_response_model.dart';

class RecentlyAddedResponseModel {
  RecentlyAddedResponseModel({
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

  RecentlyAddedResponseModel.fromJson(dynamic json) {
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
    List<Recent>? recent,
    String? portraitPath,
  }) {
    _recent = recent;
    _portraitPath = portraitPath;
  }

  Data.fromJson(dynamic json) {
    if (json['recent'] != null) {
      _recent = [];
      json['recent'].forEach((v) {
        _recent?.add(Recent.fromJson(v));
      });
    }
    _portraitPath = json['portrait_path'];
  }
  List<Recent>? _recent;
  String? _portraitPath;

  List<Recent>? get recent => _recent;
  String? get portraitPath => _portraitPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_recent != null) {
      map['recent'] = _recent?.map((v) => v.toJson()).toList();
    }
    map['portrait_path'] = _portraitPath;
    return map;
  }
}

class Recent {
  Recent({
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

  Recent.fromJson(dynamic json) {
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
