import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import '../../../core/helper/messages.dart';
import '../../../core/helper/shared_pref_helper.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../data/controller/localization/localization_controller.dart';
import '../../../data/model/global/response_model/response_model.dart';
import '../../../data/model/language/language_model.dart';
import '../../../data/repo/auth/general_setting_repo.dart';

class LanguageDialogBody extends StatefulWidget {
  final List<MyLanguageModel> langList;
  final bool fromSplashScreen;

  const LanguageDialogBody({super.key, required this.langList, this.fromSplashScreen = false});

  @override
  State<LanguageDialogBody> createState() => _LanguageDialogBodyState();
}

class _LanguageDialogBodyState extends State<LanguageDialogBody> {
  int pressIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              MyStrings.selectALanguage.tr,
              style: mulishRegular.copyWith(color: MyColor.textColor, fontSize: Dimensions.fontLarge),
            ),
          ),
          const SizedBox(
            height: Dimensions.space15,
          ),
          Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.langList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          pressIndex = index;
                        });
                        String languageCode = widget.langList[index].languageCode;
                        final repo = Get.put(GeneralSettingRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
                        final localizationController = Get.put(LocalizationController(sharedPreferences: Get.find()));
                        ResponseModel response = await repo.getLanguage(languageCode);
                        if (response.statusCode == 200) {
                          try {
                            Map<String, Map<String, String>> language = {};
                            var resJson = jsonDecode(response.responseJson);
                            await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.langListKey, response.responseJson);
                            var value = resJson['data']['language_data'] as Map<String, dynamic>;
                            Map<String, String> json = {};

                            value.forEach((key, value) {
                              json[key] = value.toString();
                            });

                            language['${widget.langList[index].languageCode}_${'US'}'] = json;

                            Get.clearTranslations();
                            Get.addTranslations(Messages(languages: language).keys);

                            Locale local = Locale(widget.langList[index].languageCode, 'US');
                            // localizationController.setLanguage(local);
                            if (widget.fromSplashScreen) {
                              Get.offAndToNamed(
                                RouteHelper.loginScreen,
                              );
                            } else {
                              Get.back();
                            }
                          } catch (e) {
                            CustomSnackbar.showCustomSnackbar(errorList: [e.toString()], msg: [], isError: true);
                            Get.back();
                          }
                        } else {
                          CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
                          setState(() {
                            pressIndex = -1;
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                        decoration: BoxDecoration(color: MyColor.bgColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                        child: pressIndex == index
                            ? const Center(
                                child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: MyColor.primaryColor)),
                              )
                            : Text(
                                (widget.langList[index].languageName).tr,
                                style: mulishRegular.copyWith(color: MyColor.textColor),
                              ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
