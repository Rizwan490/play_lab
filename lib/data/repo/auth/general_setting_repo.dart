import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/method.dart';
import '../../../constants/my_strings.dart';
import '../../../core/helper/shared_pref_helper.dart';
import '../../../core/utils/url_container.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/general_setting/general_settings_response_model.dart';
import '../../model/global/response_model/response_model.dart';

class GeneralSettingRepo {
  SharedPreferences sharedPreferences;
  ApiClient apiClient;

  GeneralSettingRepo({required this.sharedPreferences, required this.apiClient});

  Future<GeneralSettingsResponseModel> getGeneralSetting() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: false);

    if (kDebugMode) {
      print(url.toString());
      print(response.responseJson);
    }

    if (response.statusCode == 200) {
      GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status == 'success') {
        apiClient.storeGeneralSetting(model);
        apiClient.storeTimeZone(model.data?.timeZone ?? 'UTC');
        apiClient.storePushSetting(model.data?.generalSetting?.pusherConfig ?? PusherConfig());
        print("model.data.generalSetting.pusherConfig.appKey ${model.data?.generalSetting?.pusherConfig?.appKey}");
        return model;
      } else {
        List<String> message = [MyStrings.somethingWentWrong];
        CustomSnackbar.showCustomSnackbar(errorList: message, msg: [], isError: true);
        return model;
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
      return GeneralSettingsResponseModel();
    }
  }

  GeneralSettingsResponseModel getGeneralSettingFromSharedPreferences() {
    GeneralSettingsResponseModel model;
    if (sharedPreferences.containsKey(SharedPreferenceHelper.generalSettingKey)) {
      String? obj = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey);
      if (obj != null) {
        model = GeneralSettingsResponseModel.fromJson(jsonDecode(obj));
      }
      model = GeneralSettingsResponseModel();
      return model;
    } else {
      model = GeneralSettingsResponseModel();
      return model;
    }
  }

  storeGeneralSetting(GeneralSettingsResponseModel model) {
    String json = jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingsResponseModel getGSData() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    if (kDebugMode) {
      // print('${model.data?.generalSetting?.curText}');
    }
    return model;
  }

  Future<dynamic> getLanguage(String languageCode) async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.languageUrl}?code=$languageCode';
      ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: false);
      return response;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }
  }
}
