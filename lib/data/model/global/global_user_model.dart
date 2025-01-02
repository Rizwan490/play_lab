class GlobalUser {
  GlobalUser({
    String? id,
    String? packageId,
    String? validity,
    dynamic telegramUsername,
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? countryCode,
    String? mobile,
    String? refBy,
    String? provider,
    String? balance,
    dynamic image,
    String? status,
    String? ev,
    String? exp,
    String? sv,
    dynamic verCode,
    dynamic verCodeSendAt,
    String? ts,
    String? tv,
    dynamic tsc,
    String? regStep,
    String? buyFreePackage,
    String? address,
    String? state,
    String? zip,
    String? country,
    String? city,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _packageId = packageId;
    _validity = validity;
    _telegramUsername = telegramUsername;
    _firstName = firstname;
    _lastName = lastname;
    _username = username;
    _email = email;
    _provider = provider;
    _countryCode = countryCode;
    _mobile = mobile;
    _refBy = refBy;
    _balance = balance;
    _image = image;
    _status = status;
    _ev = ev;
    _exp = exp;
    _sv = sv;
    _verCode = verCode;
    _verCodeSendAt = verCodeSendAt;
    _ts = ts;
    _tv = tv;
    _tsc = tsc;
    _profileComplete = regStep;
    _buyFreePackage = buyFreePackage;
    _address = address;
    _state = state;
    _zip = zip;
    _country = country;
    _city = city;

    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GlobalUser.fromJson(dynamic json) {
    _id = json['id'].toString();
    _packageId = json['package_id'].toString();
    _firstName = json['firstname'];
    _lastName = json['lastname'];
    _username = json['username'] ?? '';
    _email = json['email'];
    _provider = json['provider'];
    _countryCode = json['country_code'].toString();
    _mobile = json['mobile'].toString();
    _refBy = json['ref_by'].toString();
    _balance = json['balance'].toString();
    _image = json['image'];
    _status = json['status'].toString();
    _exp = json['exp'] != null ? json['exp'].toString() : '';
    _ev = json['ev'].toString();
    _sv = json['sv'].toString();
    _profileComplete = json['profile_complete'].toString();
    _verCode = json['ver_code'].toString();
    _ts = json['ts'].toString();
    _tv = json['tv'].toString();
    _tsc = json['tsc'].toString();
    _buyFreePackage = json['buy_free_package'].toString();

    _address = json['address'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
    _city = json['city'];

    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _packageId;
  String? _validity;
  dynamic _telegramUsername;
  String? _firstName;
  String? _lastName;
  String? _username;
  String? _email;
  String? _provider;
  String? _countryCode;
  String? _mobile;
  String? _refBy;
  String? _balance;
  dynamic _image;
  String? _status;
  String? _exp;
  String? _ev;
  String? _sv;
  String? _profileComplete;
  dynamic _verCode;
  dynamic _verCodeSendAt;
  String? _ts;
  String? _tv;
  dynamic _tsc;
  String? _buyFreePackage;

  String? _address;
  String? _state;
  String? _zip;
  String? _country;
  String? _city;

  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get packageId => _packageId;
  String? get validity => _validity;
  dynamic get telegramUsername => _telegramUsername;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get username => _username;
  String? get email => _email;
  String? get provider => _provider;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get refBy => _refBy;
  String? get balance => _balance;
  dynamic get image => _image;
  String? get status => _status;
  String? get exp => _exp;
  String? get ev => _ev;
  String? get sv => _sv;
  dynamic get verCode => _verCode;
  dynamic get verCodeSendAt => _verCodeSendAt;
  String? get ts => _ts;
  String? get tv => _tv;
  dynamic get tsc => _tsc;
  String? get profileComplete => _profileComplete;
  String? get buyFreePackage => _buyFreePackage;

  String? get address => _address;
  String? get state => _state;
  String? get zip => _zip;
  String? get country => _country;
  String? get city => _city;

  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['package_id'] = _packageId;
    map['validity'] = _validity;
    map['telegram_username'] = _telegramUsername;
    map['firstname'] = _firstName;
    map['lastname'] = _lastName;
    map['username'] = _username;
    map['email'] = _email;
    map['provider'] = _provider;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['ref_by'] = _refBy;
    map['balance'] = _balance;
    map['image'] = _image;
    map['profile_complete'] = _profileComplete; // profile_complete
    map['status'] = _status;
    map['ev'] = _ev;
    map['sv'] = _sv;
    map['ver_code'] = _verCode;
    map['ver_code_send_at'] = _verCodeSendAt;
    map['ts'] = _ts;
    map['tv'] = _tv;
    map['tsc'] = _tsc;
    map['buy_free_package'] = _buyFreePackage;

    map['address'] = _address;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    map['city'] = _city;

    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
