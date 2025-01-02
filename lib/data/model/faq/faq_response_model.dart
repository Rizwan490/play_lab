import 'package:flutter/foundation.dart';
import 'package:play_lab/data/model/global/common_api_response_model.dart';

class FaqResponseModel {
  FaqResponseModel({
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

  FaqResponseModel.fromJson(dynamic json) {
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
    List<Faqs>? faqs,
  }) {
    _faqs = faqs;
  }

  Data.fromJson(dynamic json) {
    if (json['faq'] != null) {
      _faqs = [];
      try {
        json['faq'].forEach((v) {
          _faqs?.add(Faqs.fromJson(v));
        });
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }
  List<Faqs>? _faqs;

  List<Faqs>? get faqs => _faqs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_faqs != null) {
      map['faq'] = _faqs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Faqs {
  Faqs({
    int? id,
    String? dataKeys,
    DataValues? dataValues,
    String? templateName,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _dataKeys = dataKeys;
    _dataValues = dataValues;
    _templateName = templateName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Faqs.fromJson(dynamic json) {
    _id = json['id'];
    _dataKeys = json['data_keys'] != null ? json['data_keys'].toString() : '';
    _dataValues = json['data_values'] != null ? DataValues.fromJson(json['data_values']) : null;
    _templateName = json['tempname'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _dataKeys;
  DataValues? _dataValues;
  String? _templateName;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get dataKeys => _dataKeys;
  DataValues? get dataValues => _dataValues;
  String? get templateName => _templateName;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['data_keys'] = _dataKeys;
    if (_dataValues != null) {
      map['data_values'] = _dataValues?.toJson();
    }
    map['template_name'] = _templateName;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class DataValues {
  DataValues({
    String? question,
    String? answer,
    String? icon,
  }) {
    _question = question;
    _answer = answer;
    _icon = icon;
  }

  DataValues.fromJson(dynamic json) {
    _question = json['question'] != null ? json['question'].toString() : '';
    _answer = json['answer'] != null ? json['answer'].toString() : '';
    _icon = json['icon'] != null ? json['icon'].toString() : '';
  }

  String? _question;
  String? _answer;
  String? _icon;

  String? get question => _question;
  String? get answer => _answer;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = _question;
    map['answer'] = _answer;
    map['icon'] = _icon;
    return map;
  }
}
