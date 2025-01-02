import 'package:play_lab/data/model/global/common_api_response_model.dart';

class BuySubscribePlanResponseModel {
  BuySubscribePlanResponseModel({
    String? remark,
    String? status,
    Message? message,
    MyData? data,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  BuySubscribePlanResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? MyData.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MyData? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MyData? get data => _data;

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

class MyData {
  MyData({
    String? subscriptionId,
    String? redirectUrl,
  }) {
    _subscriptionId = subscriptionId;
    _redirectUrl = redirectUrl;
  }

  MyData.fromJson(dynamic json) {
    _subscriptionId = json['subscription_id'].toString();
    _redirectUrl = json['redirect_url'];
  }
  String? _subscriptionId;
  String? _redirectUrl;

  String? get subscriptionId => _subscriptionId;
  String? get redirectUrl => _redirectUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subscription_id'] = _subscriptionId;
    map['redirect_url'] = _redirectUrl;
    return map;
  }
}
