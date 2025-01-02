import 'package:play_lab/data/model/global/global_user_model.dart';

class LoginResponseModel {
  LoginResponseModel({
    String? status,
    Message? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  LoginResponseModel.fromJson(dynamic json) {
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  Message? _message;
  Data? _data;

  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    GlobalUser? user,
    String? accessToken,
    String? tokenType,
  }) {
    _user = user;
    _accessToken = accessToken;
    _tokenType = tokenType;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? GlobalUser.fromJson(json['user']) : null;
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
  }
  GlobalUser? _user;
  String? _accessToken;
  String? _tokenType;

  GlobalUser? get user => _user;
  String? get accessToken => _accessToken;
  String? get tokenType => _tokenType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['access_token'] = _accessToken;
    map['token_type'] = _tokenType;
    return map;
  }
}

class Message {
  Message({List<String>? success, List<String>? error}) {
    _success = success;
    _error = error;
  }

  Message.fromJson(dynamic json) {
    _success = json['success'] != null ? [json['success'].toString()] : [];
    _error = json['error'] != null ? [json['error'].toString()] : [];
  }
  List<String>? _success;
  List<String>? _error;

  List<String>? get success => _success;
  List<String>? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    return map;
  }
}
