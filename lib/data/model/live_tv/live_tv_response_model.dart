import 'package:play_lab/data/model/global/common_api_response_model.dart';
import 'package:play_lab/data/model/global/telivision/telivions_list.dart';

class LiveTvResponseModel {
  LiveTvResponseModel({
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

  LiveTvResponseModel.fromJson(dynamic json) {
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
    TelevisionListModel? televisions,
    String? imagePath,
  }) {
    _televisions = televisions;
    _imagePath = imagePath;
  }

  Data.fromJson(dynamic json) {
    _televisions = json['televisions'] != null ? TelevisionListModel.fromJson(json['televisions']) : null;
    _imagePath = json['image_path'];
  }
  TelevisionListModel? _televisions;
  String? _imagePath;

  TelevisionListModel? get televisions => _televisions;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_televisions != null) {
      map['televisions'] = _televisions?.toJson();
    }
    map['image_path'] = _imagePath;
    return map;
  }
}
