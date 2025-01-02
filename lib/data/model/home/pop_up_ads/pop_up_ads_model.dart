

class PopUpAdsModel {
  PopUpAdsModel({
      this.remark, 
      this.status, 
      this.data,});

  PopUpAdsModel.fromJson(dynamic json) {
    remark = json['remark'];
    status = json['status'];
    data = json['data'] != null ? PopUpData.fromJson(json['data']) : null;
  }
  String? remark;
  String? status;
  PopUpData? data;

}

class PopUpData {
  PopUpData({
    this.advertise,
    this.imagePath,});

  PopUpData.fromJson(dynamic json) {
    advertise = json['advertise'] != null ? Advertise.fromJson(json['advertise']) : null;
    imagePath = json['imagePath'];
  }
  Advertise? advertise;
  String? imagePath;


}

class Content {
  Content({
    this.image,
    this.link,
    this.script,});

  Content.fromJson(dynamic json) {
    image = json['image'].toString();
    link = json['link'].toString();
    script = json['script'].toString();
  }
  String? image;
  String? link;
  dynamic script;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    map['link'] = link;
    map['script'] = script;
    return map;
  }

}

class Advertise {
  Advertise({
    this.id,
    this.device,
    this.adsShow,
    this.adsType,
    this.type,
    this.content,
    this.click,
    this.impression,
    this.createdAt,
    this.updatedAt,});

  Advertise.fromJson(dynamic json) {
    id = json['id'];
    device = json['device'].toString();
    adsShow = json['ads_show'].toString();
    adsType = json['ads_type'].toString();
    type = json['type'].toString();
    content = json['content'] != null ? Content.fromJson(json['content']) : null;
    click = json['click'].toString();
    impression = json['impression'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? device;
  String? adsType;
  String? adsShow;
  String? type;
  Content? content;
  String? click;
  String? impression;
  String? createdAt;
  String? updatedAt;

}