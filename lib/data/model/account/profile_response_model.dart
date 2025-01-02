import 'package:play_lab/data/model/global/global_user_model.dart';

class ProfileResponseModel {
  ProfileResponseModel({
    String? remark,
    String? status,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _data = data;
  }

  ProfileResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    GlobalUser? user,
  }) {
    _user = user;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? GlobalUser.fromJson(json['user']) : null;
  }
  GlobalUser? _user;

  GlobalUser? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
