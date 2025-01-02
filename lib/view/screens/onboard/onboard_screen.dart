import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/core/utils/util.dart';
import 'package:play_lab/data/controller/onboardering/onboardering_controller.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/screens/onboard/bg_image_widget.dart';

import '../../../data/repo/onboarding_repo/onboarding_repo.dart';
import 'widget/button_continue/button_continue.dart';
import 'widget/button_get_start/button_get_start.dart';
import 'widget/button_next/button_next.dart';
import 'widget/button_skip/button_skip.dart';
import 'widget/sub_title_widget/sub_title_widget.dart';
import 'widget/title_widget/title_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int totalPages = 3;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    MyUtil.changeTheme();
    final argument = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(OnboardingRepo(apiClient: Get.find()));
    final controller = Get.put(OnboardingController(onboardingRepo: Get.find()));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getOnboardingData(argument);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: (controller) => controller.isLoading
          ? Scaffold(
              extendBodyBehindAppBar: true,
              body: Image.asset(
                MyImages.bgImage,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            )
          : PageView.builder(
              controller: _controller,
              itemCount: totalPages,
              itemBuilder: (context, index) {
                return Scaffold(
                  extendBodyBehindAppBar: true,
                  body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    //color: Colors.black,
                    child: Stack(
                      children: [
                        BgImageWidget(bgImage: controller.bgImageUrl),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 50,
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleWidget(text: controller.getHeaderText(index)),
                              const SizedBox(height: 15),
                              SubTitleWidget(text: controller.getSubHeaderText(index)),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: index == (totalPages - 1)
                                    ? ButtonContinue(press: () {
                                        controller.gotoLoginScreen();
                                      })
                                    : index != (0)
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 12,
                                                child: ListView.builder(
                                                  itemCount: totalPages,
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (context, i) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(right: 10.0),
                                                      child: Container(
                                                        width: index == i ? 12 : 12.0,
                                                        decoration: BoxDecoration(color: index == i ? MyColor.primaryColor : MyColor.colorWhite, borderRadius: const BorderRadius.all(Radius.circular(6.0))),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              ButtonNext(press: () {
                                                gotoNextPage();
                                              }),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              ButtonGetStart(
                                                press: () {
                                                  gotoNextPage();
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              index == 0
                                                  ? ButtonSkip(
                                                      press: () {
                                                        controller.gotoLoginScreen();
                                                      },
                                                    )
                                                  : const SizedBox()
                                            ],
                                          ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  void gotoNextPage() {
    _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
