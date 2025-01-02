import 'package:play_lab/data/model/global/common_api_response_model.dart';

class OnboardingResponseModel {
  OnboardingResponseModel({
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

  OnboardingResponseModel.fromJson(dynamic json) {
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
    Welcome? welcome,
    String? path,
  }) {
    _welcome = welcome;
    _path = path;
  }

  Data.fromJson(dynamic json) {
    _welcome = json['welcome'] != null ? Welcome.fromJson(json['welcome']) : null;
    _path = json['path'];
  }
  Welcome? _welcome;
  String? _path;

  Welcome? get welcome => _welcome;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_welcome != null) {
      map['welcome'] = _welcome?.toJson();
    }
    map['path'] = _path;
    return map;
  }
}

class Welcome {
  Welcome({
    String? hasImage,
    String? screen1Heading,
    String? screen1Subheading,
    String? screen2Heading,
    String? screen2Subheading,
    String? screen3Heading,
    String? screen3Subheading,
    String? backgroundImage,
  }) {
    _hasImage = hasImage;
    _screen1Heading = screen1Heading;
    _screen1Subheading = screen1Subheading;
    _screen2Heading = screen2Heading;
    _screen2Subheading = screen2Subheading;
    _screen3Heading = screen3Heading;
    _screen3Subheading = screen3Subheading;
    _backgroundImage = backgroundImage;
  }

  Welcome.fromJson(dynamic json) {
    _hasImage = json['has_image'];
    _screen1Heading = json['screen_1_heading'];
    _screen1Subheading = json['screen_1_subheading'];
    _screen2Heading = json['screen_2_heading'];
    _screen2Subheading = json['screen_2_subheading'];
    _screen3Heading = json['screen_3_heading'];
    _screen3Subheading = json['screen_3_subheading'];
    _backgroundImage = json['background_image'];
  }
  String? _hasImage;
  String? _screen1Heading;
  String? _screen1Subheading;
  String? _screen2Heading;
  String? _screen2Subheading;
  String? _screen3Heading;
  String? _screen3Subheading;
  String? _backgroundImage;

  String? get hasImage => _hasImage;
  String? get screen1Heading => _screen1Heading;
  String? get screen1Subheading => _screen1Subheading;
  String? get screen2Heading => _screen2Heading;
  String? get screen2Subheading => _screen2Subheading;
  String? get screen3Heading => _screen3Heading;
  String? get screen3Subheading => _screen3Subheading;
  String? get backgroundImage => _backgroundImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['has_image'] = _hasImage;
    map['screen_1_heading'] = _screen1Heading;
    map['screen_1_subheading'] = _screen1Subheading;
    map['screen_2_heading'] = _screen2Heading;
    map['screen_2_subheading'] = _screen2Subheading;
    map['screen_3_heading'] = _screen3Heading;
    map['screen_3_subheading'] = _screen3Subheading;
    map['background_image'] = _backgroundImage;
    return map;
  }
}
