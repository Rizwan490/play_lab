
class MainDepositMethodResponseModel {
  MainDepositMethodResponseModel({
      int? code, 
      String? status, 
      Message? message, 
      Data? data,}){
    _code = code;
    _status = status;
    _message = message;
    _data = data;
}

  MainDepositMethodResponseModel.fromJson(dynamic json) {
    _code = json['code'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _code;
  String? _status;
  Message? _message;
  Data? _data;

  int? get code => _code;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

  void setCode(int i) {
    _code=i;
  }

}

class Data {
  Data({
      List<Methods>? methods, 
      String? imagePath,}){
    _methods = methods;
    _imagePath = imagePath;
}

  Data.fromJson(dynamic json) {
    if (json['methods'] != null) {
      _methods = [];
      json['methods'].forEach((v) {
        _methods?.add(Methods.fromJson(v));
      });
    }
    _imagePath = json['image_path'];
  }
  List<Methods>? _methods;
  String? _imagePath;

  List<Methods>? get methods => _methods;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_methods != null) {
      map['methods'] = _methods?.map((v) => v.toJson()).toList();
    }
    map['image_path'] = _imagePath;
    return map;
  }

}

class Methods {
  Methods({
      int? id, 
      String? name, 
      String? currency, 
      String? symbol, 
      String? methodCode,
      String? gatewayAlias, 
      String? minAmount, 
      String? maxAmount, 
      String? percentCharge, 
      String? fixedCharge, 
      String? rate, 
      dynamic image, 
      String? createdAt, 
      String? updatedAt, 
      Method? method,}){
    _id = id;
    _name = name;
    _currency = currency;
    _symbol = symbol;
    _methodCode = methodCode;
    _gatewayAlias = gatewayAlias;
    _minAmount = minAmount;
    _maxAmount = maxAmount;
    _percentCharge = percentCharge;
    _fixedCharge = fixedCharge;
    _rate = rate;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _method = method;
}

  Methods.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _currency = json['currency'];
    _symbol = json['symbol'];
    _methodCode = json['method_code'].toString();
    _gatewayAlias = json['gateway_alias'].toString();
    _minAmount = json['min_amount'] !=null? json['min_amount'].toString() : '';
    _maxAmount = json['max_amount'] !=null? json['max_amount'].toString() : '';
    _percentCharge = json['percent_charge'] !=null? json['percent_charge'].toString() : '';
    _fixedCharge = json['fixed_charge'] !=null? json['fixed_charge'].toString() : '';
    _rate = json['rate'] !=null? json['rate'].toString() : '';
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _method = json['method'] != null ? Method.fromJson(json['method']) : null;
  }
  int? _id;
  String? _name;
  String? _currency;
  String? _symbol;
  String? _methodCode;
  String? _gatewayAlias;
  String? _minAmount;
  String? _maxAmount;
  String? _percentCharge;
  String? _fixedCharge;
  String? _rate;
  dynamic _image;
  String? _createdAt;
  String? _updatedAt;
  Method? _method;

  int? get id => _id;
  String? get name => _name;
  String? get currency => _currency;
  String? get symbol => _symbol;
  String? get methodCode => _methodCode;
  String? get gatewayAlias => _gatewayAlias;
  String? get minAmount => _minAmount;
  String? get maxAmount => _maxAmount;
  String? get percentCharge => _percentCharge;
  String? get fixedCharge => _fixedCharge;
  String? get rate => _rate;
  dynamic get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Method? get method => _method;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['currency'] = _currency;
    map['symbol'] = _symbol;
    map['method_code'] = _methodCode;
    map['gateway_alias'] = _gatewayAlias;
    map['min_amount'] = _minAmount;
    map['max_amount'] = _maxAmount;
    map['percent_charge'] = _percentCharge;
    map['fixed_charge'] = _fixedCharge;
    map['rate'] = _rate;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_method != null) {
      map['method'] = _method?.toJson();
    }
    return map;
  }

}

class Method {
  Method({
      int? id, 
      String? code, 
      String? name, 
      String? alias, 
      String? image,
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _code = code;
    _name = name;
    _alias = alias;
    _image = image;
    _status = status;
    _description = description;
    _inputForm = inputForm;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Method.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'].toString();
    _name = json['name'];
    _alias = json['alias'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _code;
  String? _name;
  String? _alias;
  String? _image;
  bool? _status;
  dynamic _description;
  dynamic _inputForm;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get code => _code;
  String? get name => _name;
  String? get alias => _alias;
  String? get image => _image;
  bool? get status => _status;
  dynamic get description => _description;
  dynamic get inputForm => _inputForm;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['name'] = _name;
    map['alias'] = _alias;
    map['image'] = _image;
    map['status'] = _status;
    map['description'] = _description;
    map['input_form'] = _inputForm;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Message {
  Message({
      List<String>? success,List<String>? error,}){
    _success = success;
    _error = error;
}

  Message.fromJson(dynamic json) {
    _success = json['success'] != null ?json['success']==[]? null:  json['success'].cast<String>() : null;
    _error=json['error']!=null?json['error']==[]?null:json['error']:null;
  }
  List<String>? _success;
  List<String>? _error;

  List<String>? get success => _success;
  List<String>? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['error'] = _error;
    return map;
  }

}