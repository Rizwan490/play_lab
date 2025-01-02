import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/otp_field_widget/otp_field_widget.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../data/controller/auth/auth/forget_password_controller.dart';
import '../../../../../data/repo/auth/login_repo.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/auth_image.dart';
import '../../../../components/bg_widget/bg_image_widget.dart';
import '../../../../components/buttons/rounded_button.dart';

class VerifyForgetPassScreen extends StatefulWidget {
  const VerifyForgetPassScreen({super.key});

  @override
  State<VerifyForgetPassScreen> createState() => _VerifyForgetPassScreenState();
}

class _VerifyForgetPassScreenState extends State<VerifyForgetPassScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    final controller = Get.put(ForgetPasswordController(loginRepo: Get.find()));
    controller.email = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyBgWidget(),
        PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(
              title: MyStrings.passVerification,
              fromAuth: true,
            ),
            body: SizedBox(
              child: GetBuilder<ForgetPasswordController>(
                builder: (controller) => SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * .07,
                                ),
                                const AuthImageWidget(),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * .07,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .1, vertical: 8),
                                  child: RichText(
                                    text: TextSpan(text: MyStrings.weHaveSent.tr, children: [TextSpan(text: ' ${MyStrings.yourEmailAddress.tr}', style: const TextStyle(color: MyColor.t2, fontSize: Dimensions.authTextSize))], style: const TextStyle(color: MyColor.t2, fontSize: Dimensions.authTextSize)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                OTPFieldWidget(onChanged: (value) {
                                  controller.currentText = value;
                                }),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  child: controller.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : RoundedButton(
                                          width: 1,
                                          text: 'Verify',
                                          press: () {
                                            if (controller.currentText.length != 6) {
                                              controller.hasError = true;
                                            } else {
                                              controller.verifyForgetPasswordCode(controller.currentText);
                                            }
                                          }),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      MyStrings.didNotReceiveCode.tr,
                                      style: mulishRegular,
                                    ),
                                    controller.isResendLoading
                                        ? const SpinKitFadingCircle(
                                            size: 20,
                                            color: MyColor.primaryColor,
                                          )
                                        : TextButton(
                                            onPressed: () {
                                              controller.resendForgetPassCode();
                                            },
                                            child: Text(MyStrings.resend.tr, style: mulishBold.copyWith(decoration: TextDecoration.underline, color: MyColor.colorWhite)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
