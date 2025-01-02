import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/data/repo/auth/general_setting_repo.dart';
import 'package:play_lab/data/repo/splash/splash_repo.dart';
import 'package:play_lab/data/services/api_service.dart';

import '../../../data/controller/localization/localization_controller.dart';
import '../../../data/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SplashRepo(apiClient: Get.find()));
    Get.put(GeneralSettingRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(SplashController(splashRepo: Get.find(), gsRepo: Get.find(), localizationController: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: MyColor.transparentColor, statusBarColor: MyColor.transparentColor, statusBarIconBrightness: Brightness.light, systemNavigationBarIconBrightness: Brightness.light));
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.transparentColor,
        body: GetBuilder<SplashController>(
          builder: (controller) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(5),
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(MyImages.logo))),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
