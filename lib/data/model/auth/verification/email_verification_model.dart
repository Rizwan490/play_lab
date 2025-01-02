class EmailVerificationModel {
  EmailVerificationModel({required int code, required String status, required String redirectUrl, Message? message, Data? data}) {
    _code = code;
    _status = status;
    _message = message;
    _redirectUrl = redirectUrl;
    _data = data;
  }

  EmailVerificationModel.fromJson(dynamic json) {
    _code = json['code'] ?? 0;
    _redirectUrl = json['redirect_url'] ?? '';
    _status = json['status'] ?? 'null status';
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  late int _code;
  late String _status;
  late String _redirectUrl;
  Message? _message;
  Data? _data;

  int get code => _code;
  String get status => _status;
  String get redirectUrl => _redirectUrl;
  Message? get message => _message;
  Data? get data => _data;

  void setCode(int code) {
    _code = code;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message!.toJson();
    }
    if (_redirectUrl.isNotEmpty) {
      map['redirect_url'] = _redirectUrl;
    }
    return map;
  }
}

class Data {
  String? email;
  String? token;

  Data({this.email, this.token});
  Data.fromJson(dynamic json) {
    if (json['email'] != null) {
      email = json['email'];
    } else {
      email = null;
    }
    if (json['code'] != null) {
      token = json['code'].toString();
    } else {
      token = null;
    }
  }
}

class Message {
  Message({List<String>? success, List<String>? error}) {
    _success = success;
    _error = error;
  }

  Message.fromJson(dynamic json) {
    try {
      if (json['success'] != null && json['success'] != []) {
        _success = json['success'].cast<String>();
      } else {
        _success = null;
      }
    } catch (e) {
      _success = null;
    }

    if (json['error'] != null) {
      _error = json['error'].cast<String>();
    } else {
      _error = null;
    }
  }
  List<String>? _success;
  List<String>? _error;

  List<String>? get error => _error;
  List<String>? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['error'] = _error;
    return map;
  }
}
