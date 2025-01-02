import 'package:play_lab/data/model/global/common_api_response_model.dart';

class SubCategoryResponseModel {
  SubCategoryResponseModel({
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

  SubCategoryResponseModel.fromJson(dynamic json) {
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
    Subcategories? subcategories,
  }) {
    _subcategories = subcategories;
  }

  MainData.fromJson(dynamic json) {
    _subcategories = json['subcategories'] != null ? Subcategories.fromJson(json['subcategories']) : null;
  }
  Subcategories? _subcategories;

  Subcategories? get subcategories => _subcategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_subcategories != null) {
      map['subcategories'] = _subcategories?.toJson();
    }
    return map;
  }
}

class Subcategories {
  Subcategories({List<Data>? data, dynamic nextPageUrl}) {
    _data = data;
    _nextPageUrl = nextPageUrl;
  }

  Subcategories.fromJson(dynamic json) {
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
    int? id,
    String? name,
    String? categoryId,
    String? status,
    dynamic createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _categoryId = json['category_id'].toString();
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _name;
  String? _categoryId;
  String? _status;
  dynamic _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get categoryId => _categoryId;
  String? get status => _status;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['category_id'] = _categoryId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
