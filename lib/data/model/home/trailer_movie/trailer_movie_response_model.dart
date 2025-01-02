import 'package:play_lab/data/model/global/common_api_response_model.dart';

class TrailerMovieResponseModel {
  TrailerMovieResponseModel({
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

  TrailerMovieResponseModel.fromJson(dynamic json) {
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
    List<Trailer>? trailer,
    String? portraitPath,
    String? landscapePath,
  }) {
    _trailer = trailer;
    _portraitPath = portraitPath;
    _landscapePath = landscapePath;
  }

  Data.fromJson(dynamic json) {
    if (json['trailer'] != null) {
      _trailer = [];
      json['trailer'].forEach((v) {
        _trailer?.add(Trailer.fromJson(v));
      });
    }
    _portraitPath = json['portrait_path'];
    _landscapePath = json['landscape_path'];
  }
  List<Trailer>? _trailer;
  String? _portraitPath;
  String? _landscapePath;

  List<Trailer>? get trailer => _trailer;
  String? get portraitPath => _portraitPath;
  String? get landscapePath => _landscapePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_trailer != null) {
      map['trailer'] = _trailer?.map((v) => v.toJson()).toList();
    }
    map['portrait_path'] = _portraitPath;
    map['landscape_path'] = _landscapePath;
    return map;
  }
}

class Trailer {
  Trailer({
    Image? image,
    String? title,
    String? ratings,
    int? id,
  }) {
    _image = image;
    _title = title;
    _ratings = ratings;
    _id = id;
  }

  Trailer.fromJson(dynamic json) {
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _title = json['title'];
    _ratings = json['ratings'].toString();
    _id = json['id'];
  }

  Image? _image;
  String? _title;
  String? _ratings;
  int? _id;

  Image? get image => _image;
  String? get title => _title;
  String? get ratings => _ratings;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['title'] = _title;
    map['ratings'] = _ratings;
    map['id'] = _id;
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
