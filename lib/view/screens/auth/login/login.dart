import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/data/controller/auth/social_login_controller.dart';
import 'package:play_lab/data/repo/auth/social_login_repo.dart';
import 'package:play_lab/view/components/auth_image.dart';
import 'package:play_lab/view/components/bottom_Nav/bottom_nav.dart';
import 'package:play_lab/view/components/buttons/circle_button_with_icon.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:play_lab/view/will_pop_widget.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../constants/my_strings.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/auth/login_controller.dart';
import '../../../../data/repo/auth/login_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/bg_widget/bg_image_widget.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/custom_text_form_field.dart';
import '.././../../../core/utils/dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool b = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: MyColor.transparentColor, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.colorBlack, systemNavigationBarIconBrightness: Brightness.light));
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
    Get.put(SocialLoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));
    Get.put(SocialLoginController(repo: Get.find()));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      b = true;
      Get.find<LoginController>().isLoading = false;
    });
  }

  @override
  void dispose() {
    b = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
        body: GetBuilder<LoginController>(
          builder: (controller) => SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                const MyBgWidget(
                  image: MyImages.onboardingBG,
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .09),
                          const AuthImageWidget(),
                          SizedBox(height: MediaQuery.of(context).size.height * .06),
                          InputTextFieldWidget(
                            fillColor: Colors.grey[600]!.withOpacity(0.3),
                            hintTextColor: Colors.white,
                            controller: controller.emailController,
                            hintText: MyStrings.enterUserNameOrEmail,
                          ),
                          const SizedBox(height: 5),
                          InputTextFieldWidget(
                            fillColor: Colors.grey[600]!.withOpacity(0.3),
                            hintTextColor: Colors.white,
                            isPassword: true,
                            controller: controller.passwordController,
                            isAddMargin: false,
                            hintText: MyStrings.enterYourPassword_,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [],
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.forgetPasswordScreen);
                                  },
                                  child: Text(
                                    MyStrings.forgetYourPassword.tr,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: mulishSemiBold.copyWith(
                                      color: MyColor.primaryColor,
                                      fontSize: Dimensions.fontDefault,
                                      decoration: TextDecoration.underline,
                                      decorationColor: MyColor.primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          controller.isLoading
                              ? const Center(child: RoundedLoadingButton())
                              : RoundedButton(
                                  press: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.loginUser();
                                    }
                                  },
                                  text: MyStrings.signIn,
                                ),
                          !controller.isAllSocialAuthDisable()
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * .02,
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Divider(color: MyColor.textColor, thickness: 1.2),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(MyStrings.or.tr),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Expanded(child: Divider(color: MyColor.textColor, thickness: 1.2)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * .02,
                                    ),
                                    GetBuilder<SocialLoginController>(builder: (socialController) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Platform.isAndroid && controller.isSingleSocialAuthEnable(isGoogle: true)
                                              ? SocialLoginButton(
                                                  textColor: MyColor.colorBlack,
                                                  bg: MyColor.colorWhite,
                                                  text: MyStrings.google,
                                                  press: () {
                                                    // controller.signInWithGoogle();
                                                    socialController.signInWithGoogle();
                                                  },
                                                  imageSize: 30,
                                                  fromAsset: true,
                                                  isTextHide: true,
                                                  isIcon: false,
                                                  padding: 0,
                                                  circleSize: 30,
                                                  imageUrl: MyImages.gmailIcon,
                                                )
                                              : const SizedBox.shrink(),
                                          const SizedBox(width: Dimensions.space15),
                                          controller.isSingleSocialAuthEnable(isGoogle: false)
                                              ? SocialLoginButton(
                                                  bg: MyColor.fbColor,
                                                  isTextHide: true,
                                                  text: MyStrings.facebook,
                                                  press: () {
                                                    socialController.signInWithFacebook();
                                                  },
                                                  imageSize: 30,
                                                  isIcon: false,
                                                  fromAsset: true,
                                                  padding: 0,
                                                  circleSize: 30,
                                                  imageUrl: MyImages.fbIcon,
                                                )
                                              : const SizedBox.shrink(),
                                          const SizedBox(width: Dimensions.space15),
                                          controller.loginRepo.apiClient.isLinkdinAuthEnable()
                                              ? SocialLoginButton(
                                                  bg: MyColor.fbColor,
                                                  isTextHide: true,
                                                  text: MyStrings.linkdin,
                                                  press: () {
                                                    socialController.signInWithLinkedin(context);
                                                  },
                                                  imageSize: 30,
                                                  isIcon: false,
                                                  fromAsset: true,
                                                  padding: 0,
                                                  circleSize: 30,
                                                  imageUrl: MyImages.linkedinIcon,
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      );
                                    }),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: Dimensions.space20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  MyStrings.notAccount.tr,
                                  style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
                                ),
                              ),
                              const SizedBox(width: Dimensions.space10),
                              GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed(RouteHelper.registrationScreen);
                                },
                                child: Text(
                                  MyStrings.signUp.tr,
                                  style: mulishBold.copyWith(fontSize: 18, color: MyColor.primaryColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * .06),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
