import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:play_lab/data/model/global/common_api_response_model.dart';

class SubscribePlanResponseModel {
  SubscribePlanResponseModel({
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

  SubscribePlanResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
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
    String? imagePath,
    List<PlanModel>? data,
    List<String>? appCode,
  }) {
    _imagePath = imagePath;
    _appCode = appCode;
  }

  MainData.fromJson(dynamic json) {
    if (json['plans'] != null) {
      _data = [];
      json['plans'].forEach((v) {
        _data?.add(PlanModel.fromJson(v));
      });
    }
    _imagePath = json['image_path'];
    _appCode = json['appCode'] == null ? [] : List<String>.from(json['appCode']!.map((e) => e.toString()));
  }

  List<PlanModel>? _data;
  List<PlanModel>? get data => _data;

  List<String>? _appCode;
  List<String>? get appCode => _appCode;

  String? _imagePath;
  String? get image => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['plans'] = _data?.map((v) => v.toJson()).toList();
    }
    map['image_path'] = _imagePath;
    return map;
  }
}

class PlanModel {
  PlanModel({
    int? id,
    String? name,
    String? appCode,
    String? pricing,
    String? duration,
    String? description,
    String? status,
    String? image,
    String? createdAt,
    String? updatedAt,
    ProductDetails? inAppProduct,
  }) {
    _id = id;
    _name = name;
    _appCode = appCode;
    _pricing = pricing;
    _duration = duration;
    _status = status;
    _image = image;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _inAppProduct = inAppProduct;
  }

  PlanModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'] ?? '';
    _appCode = json['app_code'] ?? '';
    _pricing = json['pricing'] != null ? json['pricing'].toString() : '';
    _duration = json['duration'] != null ? json['duration'].toString() : '';
    _description = json['description'] != null ? json['description'].toString() : '';
    _status = json['status'].toString();
    _image = json['image'] != null ? json['image'].toString() : '';
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _name;
  String? _appCode;
  String? _pricing;
  String? _duration;
  String? _status;
  String? _image;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  ProductDetails? _inAppProduct;

  void setInAppProduct(ProductDetails purchaseDetails) {
    _inAppProduct = purchaseDetails;
  }

  int? get id => _id;
  String? get name => _name;
  String? get appCode => _appCode;
  String? get pricing => _pricing;
  String? get duration => _duration;
  String? get status => _status;
  String? get image => _image;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  ProductDetails? get inAppProduct => _inAppProduct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['app_code'] = _appCode;
    map['pricing'] = _pricing;
    map['duration'] = _duration;
    map['description'] = _description;
    map['status'] = _status;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['in_app_product'] = _inAppProduct;
    return map;
  }
}
