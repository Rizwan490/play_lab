class CommonApiResponseModel {
  CommonApiResponseModel({
    String? remark,
    String? status,
    Message? message,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
  }

  CommonApiResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
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
