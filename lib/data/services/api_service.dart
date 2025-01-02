import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/date_converter.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/method.dart';
import '../../core/helper/shared_pref_helper.dart';
import '../../core/route/route.dart';
import '../model/authorization/authorization_response_model.dart';
import '../model/general_setting/general_settings_response_model.dart';
import '../model/global/response_model/response_model.dart';

class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          if (isOnlyAcceptType) {
            response = await http.post(url, body: params, headers: {
              "Accept": "application/json",
            });
          } else {
            response = await http.post(url, body: params, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
          }
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          response = await http.post(url, body: params, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();
          response = await http.get(url, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
        } else {
          response = await http.get(
            url,
          );
        }
      }

      printx('url: ${url.toString()}');
      printx('response: ${response.body}');
      printx('params: ${params.toString()}');
      printx('token: ${token.toString()}');
      if (response.body.isEmpty) {
        cleanPreferencesData();
        Get.offAllNamed(RouteHelper.loginScreen);
      }
      if (response.statusCode == 200) {
        try {
          AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.body));

          if (model.remark == 'unverified' || model.remark == 'profile_incomplete') {
            checkAndGotoNextStep(model);
          } else if (model.remark == 'unauthenticated') {
            Get.offAndToNamed(RouteHelper.loginScreen);
          }
        } catch (e) {
          e.printInfo();
        }
        return ResponseModel(true, 'Success', 200, response.body);
      } else if (response.statusCode == 401) {
        return ResponseModel(false, 'Unauthorized', 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(false, 'Server Error', 500, response.body);
      } else {
        return ResponseModel(false, 'Something Wrong', 499, response.body);
      }
    } on SocketException {
      return ResponseModel(false, 'No Internet Connection', 503, '');
    } on FormatException {
      return ResponseModel(false, 'Bad Response Format!', 400, '');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return ResponseModel(false, MyStrings.somethingWentWrong, 499, '');
    }
  }

  void checkAndGotoNextStep(AuthorizationResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1" ? false : true;

    bool needSmsVerification = responseModel.data?.user?.sv == '1' ? false : true;

    bool isProfileCompleteEnable = responseModel.data?.user?.profileComplete == '0' ? true : false;

    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileComplete);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else {
      Get.offAndToNamed(RouteHelper.loginScreen);
    }
  }

  String token = '';
  String tokenType = '';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t = sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType = sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  SocialiteCredentials getSocialCredentialsConfigData() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    SocialiteCredentials social = model.data?.generalSetting?.socialiteCredentials ?? SocialiteCredentials();
    return social;
  }

  bool getSocialCredentialsEnabledAll() {
    return getSocialCredentialsConfigData().google?.status == '1' && getSocialCredentialsConfigData().linkedin?.status == '1' && getSocialCredentialsConfigData().facebook?.status == '1';
  }

  bool isSocialAnyOfSocialLoginOptionEnable() {
    return getSocialCredentialsConfigData().google?.status == '1' || getSocialCredentialsConfigData().linkedin?.status == '1' || getSocialCredentialsConfigData().facebook?.status == '1';
  }

  String getSocialCredentialsRedirectUrl() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    String redirect = model.data?.socialLoginRedirect ?? "";
    return redirect;
  }

  String getCurrencyOrUsername({bool isCurrency = true, bool isSymbol = false}) {
    if (isCurrency) {
      String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
      GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
      String currency = isSymbol ? model.data?.generalSetting?.curSym ?? '' : model.data?.generalSetting?.curText ?? '';
      return currency;
    } else {
      String username = sharedPreferences.getString(SharedPreferenceHelper.userNameKey) ?? '';
      return username;
    }
  }

  bool isPaidUser() {
    String expDate = sharedPreferences.getString(SharedPreferenceHelper.expiredDate) ?? '';
    if (expDate.isEmpty) {
      return false;
    } else {
      bool isSubscriptionEnd = DateConverter.isDateOver(expDate);
      return isSubscriptionEnd ? false : true;
    }
  }

  storeUserExpireDate(String exp) async {
    await sharedPreferences.setString(SharedPreferenceHelper.expiredDate, exp);
  }

  bool isWatchPartyEnable() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    if (model.data?.generalSetting?.watchParty == '0') {
      return false;
    } else {
      return true;
    }
  }

  void storeExpiredDate(String expDate) async {
    await sharedPreferences.setString(SharedPreferenceHelper.expiredDate, expDate);
  }

  bool getPasswordStrengthStatus() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool checkPasswordStrength = model.data?.generalSetting?.securePassword.toString() == '0' ? false : true;
    return checkPasswordStrength;
  }

  bool isLinkdinAuthEnable() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool isFacebookAuthEnable = model.data?.generalSetting?.socialiteCredentials?.linkedin?.status.toString() == '0' ? false : true;
    return isFacebookAuthEnable;
  }

  bool isFacebookAuthEnable() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool isFacebookAuthEnable = model.data?.generalSetting?.socialiteCredentials?.facebook?.status.toString() == '0' ? false : true;
    return isFacebookAuthEnable;
  }

  bool isGmailAuthEnable() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool isGmailAuthEnable = model.data?.generalSetting?.socialiteCredentials?.google?.status.toString() == '0' ? false : true;
    return isGmailAuthEnable;
  }

  bool isShowAdMobAds() {
    initToken();
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool showAds = model.data?.generalSetting?.adShowMobile.toString() == '0' ? false : true;
    printx('is show Ads $showAds');

    if (!showAds) {
      return false;
    }
    String token = sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey) ?? '';
    if (token.isEmpty) {
      return true;
    } else {
      bool isShowAds = isPaidUser();
      printx('is paid user $isShowAds');
      printx('(isShowAds == showAds) ${(isShowAds == showAds)}');
      return isShowAds ? false : true;
    }
  }

  String getTemplateName() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    String templateName = model.data?.generalSetting?.activeTemplate ?? '';
    return templateName;
  }

  storeGeneralSetting(GeneralSettingsResponseModel model) {
    String json = jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  storePushSetting(PusherConfig pusherConfig) {
    String json = jsonEncode(pusherConfig.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.pusherConfigSettingKey, json);
    getGSData();
  }

  bool getAppOpeningStatus() => sharedPreferences.getBool(SharedPreferenceHelper.isFirstTimeKey) ?? false;
  storeAppOpeningStatus() => sharedPreferences.setBool(SharedPreferenceHelper.isFirstTimeKey, true);

  String getTimeZone() => sharedPreferences.getString(SharedPreferenceHelper.timeZoneKey) ?? 'UTC';
  storeTimeZone(String timeZone) async => await sharedPreferences.setString(SharedPreferenceHelper.timeZoneKey, timeZone);

  GeneralSettingsResponseModel getGSData() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    return model;
  }

  PusherConfig getPushConfig() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.pusherConfigSettingKey) ?? '';
    PusherConfig model = PusherConfig.fromJson(jsonDecode(pre));
    return model;
  }

  //logout
  cleanPreferencesData() async {
    sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    return;
  }

  bool isAuthorizeUser() {
    bool pref = sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey) ?? false;
    return pref;
  }

  storeUserProvider(String provider) async {
    await sharedPreferences.setString(SharedPreferenceHelper.userProviderKey, provider);
  }

  bool isSocialUser() {
    String pref = sharedPreferences.getString(SharedPreferenceHelper.userProviderKey) ?? "null";
    return pref == "null" || pref.isEmpty ? false : true;
  }

  bool isInappPurchaseAvalable() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool iap = model.data?.generalSetting?.appPurchase == "1" ? true : false;
    return iap;
  }
}
