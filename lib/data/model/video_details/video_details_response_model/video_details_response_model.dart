import 'package:play_lab/data/model/global/common_api_response_model.dart';
import 'package:play_lab/data/model/home/slider/slider_model.dart';

class VideoDetailsResponseModel {
  VideoDetailsResponseModel({
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

  VideoDetailsResponseModel.fromJson(dynamic json) {
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
    Item? item,
    List<Episodes>? episodes,
    List<RelatedItems>? relatedItems,
    String? portraitPath,
    String? landscapePath,
    String? episodePath,
  }) {
    _item = item;
    _episodes = episodes;
    _relatedItems = relatedItems;
    _portraitPath = portraitPath;
    _landscapePath = landscapePath;
    _episodePath = episodePath;
  }

  Data.fromJson(dynamic json) {
    _item = json['item'] != null ? Item.fromJson(json['item']) : null;
    if (json['episodes'] != null) {
      _episodes = [];
      json['episodes'].forEach((v) {
        _episodes?.add(Episodes.fromJson(v));
      });
    }
    if (json['related_items'] != null) {
      _relatedItems = [];
      json['related_items'].forEach((v) {
        _relatedItems?.add(RelatedItems.fromJson(v));
      });
    }
    _portraitPath = json['portrait_path'];
    _landscapePath = json['landscape_path'];
    _episodePath = json['episode_path'];
  }
  Item? _item;
  List<Episodes>? _episodes;
  List<RelatedItems>? _relatedItems;
  String? _portraitPath;
  String? _landscapePath;
  String? _episodePath;

  Item? get item => _item;
  List<Episodes>? get episodes => _episodes;
  List<RelatedItems>? get relatedItems => _relatedItems;
  String? get portraitPath => _portraitPath;
  String? get landscapePath => _landscapePath;
  String? get episodePath => _episodePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_item != null) {
      map['item'] = _item?.toJson();
    }
    if (_episodes != null) {
      map['episodes'] = _episodes?.map((v) => v.toJson()).toList();
    }
    if (_relatedItems != null) {
      map['related_items'] = _relatedItems?.map((v) => v.toJson()).toList();
    }
    map['portrait_path'] = _portraitPath;
    map['landscape_path'] = _landscapePath;
    map['episode_path'] = _episodePath;
    return map;
  }
}

class RelatedItems {
  RelatedItems({
    Image? image,
    int? id,
    String? version,
    String? itemType,
  }) {
    _image = image;
    _id = id;
    _version = version;
    _itemType = itemType;
  }

  RelatedItems.fromJson(dynamic json) {
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _id = json['id'];
    _version = json['version'].toString();
    _itemType = json['item_type'].toString();
  }
  Image? _image;
  int? _id;
  String? _version;
  String? _itemType;

  Image? get image => _image;
  int? get id => _id;
  String? get version => _version;
  String? get itemType => _itemType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['id'] = _id;
    map['version'] = _version;
    map['item_type'] = _itemType;
    return map;
  }
}

class Image {
  Image({
    String? landscape,
    String? portrait,
  }) {
    _landscape = landscape;
    _portrait = portrait;
  }

  Image.fromJson(dynamic json) {
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

class Episodes {
  Episodes({
    int? id,
    String? itemId,
    String? title,
    String? image,
    String? status,
    String? version,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _itemId = itemId;
    _title = title;
    _image = image;
    _status = status;
    _version = version;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Episodes.fromJson(dynamic json) {
    _id = json['id'];
    _itemId = json['item_id'].toString().toString();
    _title = json['title'];
    _image = json['image'];
    _status = json['status'].toString();
    _version = json['version'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _itemId;
  String? _title;
  String? _image;
  String? _status;
  String? _version;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get itemId => _itemId;
  String? get title => _title;
  String? get image => _image;
  String? get status => _status;
  String? get version => _version;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['item_id'] = _itemId;
    map['title'] = _title;
    map['image'] = _image;
    map['status'] = _status;
    map['version'] = _version;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Item {
  Item({
    int? id,
    String? categoryId,
    dynamic subCategoryId,
    String? title,
    Category? category,
    Subcategory? subCategory,
    String? previewText,
    String? description,
    Team? team,
    Image? image,
    String? itemType,
    String? status,
    String? single,
    String? trending,
    String? featured,
    String? version,
    String? tags,
    String? ratings,
    String? view,
    String? createdAt,
    String? updatedAt,
    String? rentPrice,
    String? rentPeriod,
  }) {
    _id = id;
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
    _rentPeriod = rentPeriod;
    _rentPrice = rentPrice;

    _category = category;
    _subCategory = subCategory;
  }

  Item.fromJson(dynamic json) {
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _subCategory = json['sub_category'] != null ? Subcategory.fromJson(json['sub_category']) : null;
    _id = json['id'];
    _categoryId = json['category_id'].toString();
    _subCategoryId = json['sub_category_id'].toString();
    _title = json['title'];
    _previewText = json['preview_text'];
    _description = json['description'];
    _team = json['team'] != null ? Team.fromJson(json['team']) : null;
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _itemType = json['item_type'].toString();
    _status = json['status'].toString();
    _single = json['single'].toString();
    _trending = json['trending'].toString();
    _featured = json['featured'].toString();
    _version = json['version'].toString();
    _tags = json['tags'];
    _ratings = json['ratings'].toString();
    _view = json['view'] != null ? json['view'].toString() : '0';
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _rentPrice = json['rent_price'].toString();
    _rentPeriod = json['rental_period'].toString();
  }
  int? _id;
  String? _categoryId;
  dynamic _subCategoryId;
  String? _title;
  String? _previewText;
  String? _description;
  Team? _team;
  Image? _image;
  String? _itemType;
  String? _status;
  String? _single;
  String? _trending;
  String? _featured;
  Subcategory? _subCategory;
  Category? _category;
  String? _version;
  String? _tags;
  String? _ratings;
  String? _view;
  String? _createdAt;
  String? _updatedAt;

  String? _rentPrice;
  String? _rentPeriod;

  int? get id => _id;
  String? get categoryId => _categoryId;
  dynamic get subCategoryId => _subCategoryId;
  String? get title => _title;
  String? get previewText => _previewText;
  String? get description => _description;
  Team? get team => _team;
  Image? get image => _image;
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
  String? get rentPrice => _rentPrice;
  String? get rentPeriod => _rentPeriod;

  Category? get category => _category;
  Subcategory? get subCategory => _subCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['category'] = _category;
    map['sub_category_id'] = _subCategoryId;
    map['sub_category'] = _subCategory;
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
