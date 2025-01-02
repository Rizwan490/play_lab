import 'package:get/get.dart';
import 'package:play_lab/data/controller/reels/reels_controller.dart';
import 'package:play_lab/data/repo/reels_repo/reels_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/controller/localization/localization_controller.dart';
import '../../data/controller/nav_controller/nav_drawer_controller.dart';
import '../../data/controller/splash_controller.dart';
import '../../data/repo/auth/general_setting_repo.dart';
import '../../data/repo/splash/splash_repo.dart';
import '../../data/services/api_service.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find(), gsRepo: Get.find(), localizationController: Get.find()));
  Get.lazyPut(() => NavDrawerController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ReelsRepo(apiClient: Get.find()));
  Get.lazyPut(() => ReelsController(repo: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo(sharedPreferences: Get.find(), apiClient: Get.find()));

  Map<String, Map<String, String>> language = {};
  language['en_US'] = {'': ''};

  return language;
}
