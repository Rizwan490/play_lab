class GeneralSettingsResponseModel {
  GeneralSettingsResponseModel({
    String? remark,
    String? status,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _data = data;
  }

  GeneralSettingsResponseModel.fromJson(dynamic json) {
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
    GeneralSetting? generalSetting,
    String? timeZone,
    String? socialLoginRedirect,
  }) {
    _generalSetting = generalSetting;
    _timeZone = timeZone;
    _socialLoginRedirect = socialLoginRedirect;
  }

  Data.fromJson(dynamic json) {
    _timeZone = json['timezone'] ?? 'UTC';
    _socialLoginRedirect = json['social_login_redirect'] ?? '';
    _generalSetting = json['general_setting'] != null ? GeneralSetting.fromJson(json['general_setting']) : null;
  }
  GeneralSetting? _generalSetting;
  String? _timeZone;
  String? _socialLoginRedirect;

  GeneralSetting? get generalSetting => _generalSetting;
  String? get timeZone => _timeZone;
  String? get socialLoginRedirect => _socialLoginRedirect;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_generalSetting != null) {
      map['general_setting'] = _generalSetting?.toJson();
    }
    return map;
  }
}

class GeneralSetting {
  GeneralSetting({
    int? id,
    String? siteName,
    String? curText,
    String? curSym,
    String? emailFrom,
    String? smsBody,
    String? smsFrom,
    String? baseColor,
    String? secondaryColor,
    String? server,
    GlobalShortcodes? globalShortcodes,
    String? kv,
    String? ev,
    String? en,
    String? sv,
    String? sn,
    String? forceSsl,
    String? maintenanceMode,
    String? securePassword,
    String? agree,
    String? registration,
    String? activeTemplate,
    dynamic lastCron,
    SocialiteCredentials? socialiteCredentials,
    PusherConfig? pusherConfig,
    String? pn,
    String? skipTime,
    String? tmdbApi,
    String? multiLanguage,
    String? videoAdSubscriptionUser,
    String? adShowMobile,
    String? deviceLimit,
    dynamic createdAt,
    String? updatedAt,
    String? watchParty,
    String? appPurchase,
  }) {
    _id = id;
    _siteName = siteName;
    _curText = curText;
    _curSym = curSym;
    _emailFrom = emailFrom;
    _smsBody = smsBody;
    _smsFrom = smsFrom;
    _baseColor = baseColor;
    _secondaryColor = secondaryColor;
    _server = server;
    _globalShortcodes = globalShortcodes;
    _kv = kv;
    _ev = ev;
    _en = en;
    _sv = sv;
    _sn = sn;
    _forceSsl = forceSsl;
    _maintenanceMode = maintenanceMode;
    _securePassword = securePassword;
    _agree = agree;
    _registration = registration;
    _activeTemplate = activeTemplate;
    _lastCron = lastCron;
    _socialiteCredentials = socialiteCredentials;
    _pusherConfig = pusherConfig;
    _pn = pn;
    _skipTime = skipTime;
    _tmdbApi = tmdbApi;
    _multiLanguage = multiLanguage;
    _videoAdSubscriptionUser = videoAdSubscriptionUser;
    _adShowMobile = adShowMobile;
    _deviceLimit = deviceLimit;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _watchParty = watchParty;
    _appPurchase = appPurchase;
  }

  GeneralSetting.fromJson(dynamic json) {
    _id = json['id'];
    _siteName = json['site_name'] != null ? json['site_name'].toString() : '';
    _curText = json['cur_text'] != null ? json['cur_text'].toString() : '';
    _curSym = json['cur_sym'] != null ? json['cur_sym'].toString() : '';
    _emailFrom = json['email_from'] != null ? json['email_from'].toString() : '';
    _smsBody = json['sms_body'] != null ? json['sms_body'].toString() : '';
    _smsFrom = json['sms_from'] != null ? json['sms_from'].toString() : '';
    _baseColor = json['base_color'] != null ? json['base_color'].toString() : '';
    _secondaryColor = json['secondary_color'] != null ? json['secondary_color'].toString() : '';
    _server = json['server'] != null ? json['server'].toString() : '';
    _globalShortcodes = json['global_shortcodes'] != null ? GlobalShortcodes.fromJson(json['global_shortcodes']) : null;
    _kv = json['kv'].toString();
    _ev = json['ev'].toString();
    _en = json['en'].toString();
    _sv = json['sv'].toString();
    _sn = json['sn'].toString();
    _forceSsl = json['force_ssl'].toString();
    _maintenanceMode = json['maintenance_mode'].toString();
    _securePassword = json['secure_password'].toString();
    _agree = json['agree'].toString();
    _registration = json['registration'].toString();
    _activeTemplate = json['active_template'].toString();
    _socialiteCredentials = json['socialite_credentials'] != null ? SocialiteCredentials.fromJson(json['socialite_credentials']) : null;
    _pusherConfig = json['pusher_config'] != null ? PusherConfig.fromJson(json['pusher_config']) : null;
    _pn = json['pn'] != null ? json['pn'].toString() : '';
    _skipTime = json['skip_time'] != null ? json['skip_time'].toString() : '';
    _tmdbApi = json['tmdb_api'] != null ? json['tmdb_api'].toString() : '';
    _multiLanguage = json['multi_language'] != null ? json['multi_language'].toString() : '';
    _videoAdSubscriptionUser = json['video_ad_subscription_user'] != null ? json['video_ad_subscription_user'].toString() : '';
    _adShowMobile = json['ad_show_mobile'] != null ? json['ad_show_mobile'].toString() : '';
    _deviceLimit = json['device_limit'] != null ? json['device_limit'].toString() : '';
    _createdAt = json['created_at'] != null ? json['created_at'].toString() : '';
    _updatedAt = json['updated_at'] != null ? json['updated_at'].toString() : '';
    _watchParty = json['watch_party'] != null ? json['watch_party'].toString() : '';
    _appPurchase = json['in_app_payment'] != null ? json['in_app_payment'].toString() : '';
  }
  int? _id;
  String? _siteName;
  String? _curText;
  String? _curSym;
  String? _emailFrom;
  String? _smsBody;
  String? _smsFrom;
  String? _baseColor;
  String? _secondaryColor;
  String? _server;
  GlobalShortcodes? _globalShortcodes;
  String? _kv;
  String? _ev;
  String? _en;
  String? _sv;
  String? _sn;
  String? _forceSsl;
  String? _maintenanceMode;
  String? _securePassword;
  String? _agree;
  String? _registration;
  String? _activeTemplate;
  dynamic _lastCron;
  SocialiteCredentials? _socialiteCredentials;
  PusherConfig? _pusherConfig;
  String? _pn;
  String? _skipTime;
  String? _tmdbApi;
  String? _multiLanguage;
  String? _videoAdSubscriptionUser;
  String? _adShowMobile;
  String? _deviceLimit;
  dynamic _createdAt;
  String? _updatedAt;
  String? _watchParty;
  String? _appPurchase;

  int? get id => _id;
  String? get siteName => _siteName;
  String? get curText => _curText;
  String? get curSym => _curSym;
  String? get emailFrom => _emailFrom;
  String? get smsBody => _smsBody;
  String? get smsFrom => _smsFrom;
  String? get baseColor => _baseColor;
  String? get secondaryColor => _secondaryColor;
  String? get server => _server;
  GlobalShortcodes? get globalShortcodes => _globalShortcodes;
  String? get kv => _kv;
  String? get ev => _ev;
  String? get en => _en;
  String? get sv => _sv;
  String? get sn => _sn;
  String? get forceSsl => _forceSsl;
  String? get maintenanceMode => _maintenanceMode;
  String? get securePassword => _securePassword;
  String? get agree => _agree;
  String? get registration => _registration;
  String? get activeTemplate => _activeTemplate;
  dynamic get lastCron => _lastCron;
  SocialiteCredentials? get socialiteCredentials => _socialiteCredentials;
  PusherConfig? get pusherConfig => _pusherConfig;
  String? get pn => _pn;
  String? get skipTime => _skipTime;
  String? get tmdbApi => _tmdbApi;
  String? get multiLanguage => _multiLanguage;
  String? get videoAdSubscriptionUser => _videoAdSubscriptionUser;
  String? get adShowMobile => _adShowMobile;
  String? get deviceLimit => _deviceLimit;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get watchParty => _watchParty;
  String? get appPurchase => _appPurchase;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['site_name'] = _siteName;
    map['cur_text'] = _curText;
    map['cur_sym'] = _curSym;
    map['email_from'] = _emailFrom;
    map['sms_body'] = _smsBody;
    map['sms_from'] = _smsFrom;
    map['base_color'] = _baseColor;
    map['secondary_color'] = _secondaryColor;
    map['server'] = _server;
    if (_globalShortcodes != null) {
      map['global_shortcodes'] = _globalShortcodes?.toJson();
    }
    map['kv'] = _kv;
    map['ev'] = _ev;
    map['en'] = _en;
    map['sv'] = _sv;
    map['sn'] = _sn;
    map['force_ssl'] = _forceSsl;
    map['maintenance_mode'] = _maintenanceMode;
    map['secure_password'] = _securePassword;
    map['agree'] = _agree;
    map['registration'] = _registration;
    map['active_template'] = _activeTemplate;
    map['last_cron'] = _lastCron;
    map['skip_time'] = _skipTime;
    if (_socialiteCredentials != null) {
      map['socialite_credentials'] = _socialiteCredentials?.toJson();
    }
    if (_pusherConfig != null) {
      map['pusher_config'] = _pusherConfig?.toJson();
    }
    map['multi_language'] = _multiLanguage;
    map['video_ad_subscription_user'] = _videoAdSubscriptionUser;
    map['ad_show_mobile'] = _adShowMobile;
    map['device_limit'] = _deviceLimit;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['watch_party'] = _watchParty;
    map['in_app_payment'] = _appPurchase;

    return map;
  }
}

class SocialiteCredentials {
  SocialiteCredentials({
    Google? google,
    Facebook? facebook,
    Linkedin? linkedin,
  }) {
    _google = google;
    _facebook = facebook;
    _linkedin = linkedin;
  }

  SocialiteCredentials.fromJson(dynamic json) {
    _google = json['google'] != null ? Google.fromJson(json['google']) : null;
    _facebook = json['facebook'] != null ? Facebook.fromJson(json['facebook']) : null;
    _linkedin = json['linkedin'] != null ? Linkedin.fromJson(json['linkedin']) : null;
  }
  Google? _google;
  Facebook? _facebook;
  Linkedin? _linkedin;

  Google? get google => _google;
  Facebook? get facebook => _facebook;
  Linkedin? get linkedin => _linkedin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_google != null) {
      map['google'] = _google?.toJson();
    }
    if (_facebook != null) {
      map['facebook'] = _facebook?.toJson();
    }
    if (_linkedin != null) {
      map['linkedin'] = _linkedin?.toJson();
    }
    return map;
  }
}

class Linkedin {
  Linkedin({
    String? clientId,
    String? clientSecret,
    String? status,
  }) {
    _clientId = clientId;
    _clientSecret = clientSecret;
    _status = status;
  }

  Linkedin.fromJson(dynamic json) {
    _clientId = json['client_id'].toString();
    _clientSecret = json['client_secret'];
    _status = json['status'].toString();
  }
  String? _clientId;
  String? _clientSecret;
  String? _status;

  String? get clientId => _clientId;
  String? get clientSecret => _clientSecret;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['client_secret'] = _clientSecret;
    map['status'] = _status;
    return map;
  }
}

class Facebook {
  Facebook({
    String? clientId,
    String? clientSecret,
    String? status,
  }) {
    _clientId = clientId;
    _clientSecret = clientSecret;
    _status = status;
  }

  Facebook.fromJson(dynamic json) {
    _clientId = json['client_id'];
    _clientSecret = json['client_secret'];
    _status = json['status'].toString();
  }
  String? _clientId;
  String? _clientSecret;
  String? _status;

  String? get clientId => _clientId;
  String? get clientSecret => _clientSecret;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['client_secret'] = _clientSecret;
    map['status'] = _status;
    return map;
  }
}

class Google {
  Google({
    String? clientId,
    String? clientSecret,
    String? status,
  }) {
    _clientId = clientId;
    _clientSecret = clientSecret;
    _status = status;
  }

  Google.fromJson(dynamic json) {
    _clientId = json['client_id'].toString();
    _clientSecret = json['client_secret'].toString();
    _status = json['status'].toString();
  }
  String? _clientId;
  String? _clientSecret;
  String? _status;

  String? get clientId => _clientId;
  String? get clientSecret => _clientSecret;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['client_secret'] = _clientSecret;
    map['status'] = _status;
    return map;
  }
}

class GlobalShortcodes {
  GlobalShortcodes({
    String? siteName,
    String? siteCurrency,
    String? currencySymbol,
  }) {
    _siteName = siteName;
    _siteCurrency = siteCurrency;
    _currencySymbol = currencySymbol;
  }

  GlobalShortcodes.fromJson(dynamic json) {
    _siteName = json['site_name'];
    _siteCurrency = json['site_currency'];
    _currencySymbol = json['currency_symbol'];
  }
  String? _siteName;
  String? _siteCurrency;
  String? _currencySymbol;

  String? get siteName => _siteName;
  String? get siteCurrency => _siteCurrency;
  String? get currencySymbol => _currencySymbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['site_name'] = _siteName;
    map['site_currency'] = _siteCurrency;
    map['currency_symbol'] = _currencySymbol;
    return map;
  }
}

class PusherConfig {
  String? appId;
  String? appKey;
  String? appSecretKey;
  String? cluster;

  PusherConfig({
    this.appId,
    this.appKey,
    this.appSecretKey,
    this.cluster,
  });

  factory PusherConfig.fromJson(Map<String, dynamic> json) => PusherConfig(
        appId: json["app_id"],
        appKey: json["app_key"],
        appSecretKey: json["app_secret_key"],
        cluster: json["cluster"],
      );

  Map<String, dynamic> toJson() => {
        "app_id": appId,
        "app_key": appKey,
        "app_secret_key": appSecretKey,
        "cluster": cluster,
      };
}
