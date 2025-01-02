import 'package:play_lab/data/model/global/common_api_response_model.dart';

class SliderResponseModel {
  SliderResponseModel({
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

  SliderResponseModel.fromJson(dynamic json) {
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
    List<Sliders>? sliders,
    String? path,
  }) {
    _sliders = sliders;
    _path = path;
  }

  Data.fromJson(dynamic json) {
    if (json['sliders'] != null) {
      _sliders = [];
      json['sliders'].forEach((v) {
        _sliders?.add(Sliders.fromJson(v));
      });
    }
    _path = json['landscape_path'];
  }
  List<Sliders>? _sliders;
  String? _path;

  List<Sliders>? get sliders => _sliders;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_sliders != null) {
      map['sliders'] = _sliders?.map((v) => v.toJson()).toList();
    }
    map['landscape_path'] = _path;
    return map;
  }
}

class Sliders {
  Sliders({
    int? id,
    String? itemId,
    String? imageUrl,
    String? captionShow,
    String? createdAt,
    String? updatedAt,
    Item? item,
  }) {
    _id = id;
    _itemId = itemId;
    _imageUrl = imageUrl;
    _captionShow = captionShow;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _item = item;
  }

  Sliders.fromJson(dynamic json) {
    _id = json['id'];
    _itemId = json['item_id'].toString().toString();
    _imageUrl = json['image'];
    _captionShow = json['caption_show'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }
  int? _id;
  String? _itemId;
  String? _imageUrl;
  String? _captionShow;
  String? _createdAt;
  String? _updatedAt;
  Item? _item;

  int? get id => _id;
  String? get itemId => _itemId;
  String? get imageUrl => _imageUrl;
  String? get captionShow => _captionShow;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Item? get item => _item;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['item_id'] = _itemId;
    map['image'] = _imageUrl;
    map['caption_show'] = _captionShow;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_item != null) {
      map['item'] = _item?.toJson();
    }
    return map;
  }
}

class Item {
  Item({
    int? id,
    String? categoryId,
    String? subCategoryId,
    String? title,
    String? previewText,
    String? description,
    Team? team,
    Images? image,
    String? itemType,
    String? status,
    String? single,
    String? trending,
    String? featured,
    String? version,
    String? tags,
    String? ratings,
    String? view,
    Category? category,
    Subcategory? subCategory,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _category = category;
    _subcategory = subCategory;
    _categoryId = categoryId;
    _subCategoryId = subCategoryId;
    _title = title;
    _previewText = previewText;
    _description = description;
    _team = team;
    _image = image;
    _itemType = itemType;
    _status = status;
    _single = single;
    _trending = trending;
    _featured = featured;
    _version = version;
    _tags = tags;
    _ratings = ratings;
    _view = view;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Item.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'].toString();
    _subCategoryId = json['sub_category_id'].toString();
    _title = json['title'];
    _previewText = json['preview_text'];
    _description = json['description'];
    _team = json['team'] != null ? Team.fromJson(json['team']) : null;
    _image = json['image'] != null ? Images.fromJson(json['image']) : null;
    _itemType = json['item_type'].toString();
    _status = json['status'].toString();
    _single = json['single'].toString();
    _trending = json['trending'].toString();
    _featured = json['featured'].toString();
    _version = json['version'].toString();
    _tags = json['tags'];
    _ratings = json['ratings'].toString();
    _view = json['view'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _subcategory = json['sub_category'] != null ? Subcategory.fromJson(json['sub_category']) : null;
  }
  int? _id;
  String? _categoryId;
  String? _subCategoryId;
  String? _title;
  String? _previewText;
  String? _description;
  Team? _team;
  Images? _image;
  String? _itemType;
  String? _status;
  String? _single;
  String? _trending;
  String? _featured;
  String? _version;
  String? _tags;
  String? _ratings;
  String? _view;
  String? _createdAt;
  String? _updatedAt;
  Category? _category;
  Subcategory? _subcategory;

  int? get id => _id;
  String? get categoryId => _categoryId;
  String? get subCategoryId => _subCategoryId;
  String? get title => _title;
  String? get previewText => _previewText;
  String? get description => _description;
  Team? get team => _team;
  Images? get image => _image;
  String? get itemType => _itemType;
  String? get status => _status;
  String? get single => _single;
  String? get trending => _trending;
  String? get featured => _featured;
  String? get version => _version;
  String? get tags => _tags;
  String? get ratings => _ratings;
  String? get view => _view;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Category? get category => _category;
  Subcategory? get subCategory => _subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['sub_category_id'] = _subCategoryId;
    map['title'] = _title;
    map['preview_text'] = _previewText;
    map['description'] = _description;
    if (_team != null) {
      map['team'] = _team?.toJson();
    }
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['item_type'] = _itemType;
    map['status'] = _status;
    map['single'] = _single;
    map['trending'] = _trending;
    map['featured'] = _featured;
    map['version'] = _version;
    map['tags'] = _tags;
    map['ratings'] = _ratings;
    map['view'] = _view;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Category {
  Category({
    int? id,
    String? name,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Subcategory {
  Subcategory({
    int? id,
    String? name,
    String? status,
    String? categoryId,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Subcategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'].toString();
    _categoryId = json['category_id'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _categoryId;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get category => _categoryId;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Images {
  Images({
    String? landscape,
    String? portrait,
  }) {
    _landscape = landscape;
    _portrait = portrait;
  }

  Images.fromJson(dynamic json) {
    _landscape = json['landscape'];
    _portrait = json['portrait'];
  }
  String? _landscape;
  String? _portrait;

  String? get landscape => _landscape;
  String? get portrait => _portrait;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['landscape'] = _landscape;
    map['portrait'] = _portrait;
    return map;
  }
}

class Team {
  Team({
    String? director,
    String? producer,
    String? casts,
  }) {
    _director = director;
    _producer = producer;
    _casts = casts;
  }

  Team.fromJson(dynamic json) {
    _director = json['director'];
    _producer = json['producer'];
    _casts = json['casts'];
  }
  String? _director;
  String? _producer;
  String? _casts;

  String? get director => _director;
  String? get producer => _producer;
  String? get casts => _casts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['director'] = _director;
    map['producer'] = _producer;
    map['casts'] = _casts;
    return map;
  }
}
