import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/data/controller/auth/social_login_controller.dart';
import 'package:play_lab/view/components/buttons/circle_button_with_icon.dart';

class SocaicalAuthWidget extends StatelessWidget {
  const SocaicalAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialLoginController>(builder: (controller) {
      return Column(
        children: [
          controller.repo.apiClient.isSocialAnyOfSocialLoginOptionEnable()
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    GetBuilder<SocialLoginController>(builder: (socialController) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Platform.isAndroid && controller.repo.apiClient.isFacebookAuthEnable()
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
                          controller.repo.apiClient.isGmailAuthEnable()
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
                          controller.repo.apiClient.isLinkdinAuthEnable()
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
                  ],
                )
              : const SizedBox.shrink(),
        ],
      );
    });
  }
}
