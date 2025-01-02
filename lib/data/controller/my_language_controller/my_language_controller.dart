import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/helper/messages.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/localization/localization_controller.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/language/language_model.dart';
import 'package:play_lab/data/model/language/main_language_response_model.dart';
import 'package:play_lab/data/repo/auth/general_setting_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLanguageController extends GetxController {
  GeneralSettingRepo repo;
  LocalizationController localizationController;
  MyLanguageController({required this.repo, required this.localizationController});

  bool isLoading = true;
  String languageImagePath = "";
  List<MyLanguageModel> langList = [];

  void loadLanguage() {
    langList.clear();
    isLoading = true;

    SharedPreferences pref = repo.apiClient.sharedPreferences;
    String languageString = pref.getString(SharedPreferenceHelper.langListKey) ?? '';

    var language = jsonDecode(languageString);
    MainLanguageResponseModel model = MainLanguageResponseModel.fromJson(language);
    languageImagePath = "${UrlContainer.baseUrl}${model.data?.imagePath ?? ''}";
    if (model.data?.languages != null && model.data!.languages!.isNotEmpty) {
      for (var listItem in model.data!.languages!) {
        MyLanguageModel model = MyLanguageModel(languageCode: listItem.code ?? '', countryCode: listItem.name ?? '', languageName: listItem.name ?? '', imageUrl: listItem.image ?? '');
        langList.add(model);
      }
    }

    String languageCode = pref.getString(SharedPreferenceHelper.langCode) ?? 'en';

    if (kDebugMode) {
      // print('current lang code: $languageCode');
    }

    if (langList.isNotEmpty) {
      int index = langList.indexWhere((element) => element.languageCode.toLowerCase() == languageCode.toLowerCase());

      changeSelectedIndex(index);
    }

    isLoading = false;
    update();
  }

  String selectedLangCode = 'en';

  bool isChangeLangLoading = false;
  void changeLanguage(int index) async {
    isChangeLangLoading = true;
    update();

    MyLanguageModel selectedLangModel = langList[index];
    String languageCode = selectedLangModel.languageCode;
    try {
      ResponseModel response = await repo.getLanguage(languageCode);

      if (response.statusCode == 200) {
        var resJson = jsonDecode(response.responseJson);
        await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.langListKey, response.responseJson);

        Locale local = Locale(selectedLangModel.languageCode, 'US');
        localizationController.setLanguage(local, "$languageImagePath/${langList[index].imageUrl}");

        var value = resJson['data']['language_data'].toString() == '[]' ? {} : resJson['data']['language_data'];
        Map<String, String> json = {};
        value.forEach((key, value) {
          json[key] = value.toString();
        });

        Map<String, Map<String, String>> language = {};
        language['${selectedLangModel.languageCode}_${'US'}'] = json;

        Get.clearTranslations();
        Get.addTranslations(Messages(languages: language).keys);

        Get.back();
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
      }
    } catch (e) {
      print(e.toString());
    }

    isChangeLangLoading = false;
    update();
  }

  int selectedIndex = 0;
  void changeSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }
}
