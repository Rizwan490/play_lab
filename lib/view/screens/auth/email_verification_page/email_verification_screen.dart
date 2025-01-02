import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/util.dart';
import '../../../../data/controller/auth/auth/email_verification_controller.dart';
import '../../../../data/repo/auth/sms_email_verification_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/bg_widget/bg_image_widget.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/otp_field_widget/otp_field_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    MyUtil.changeTheme();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    Get.put(EmailVerificationController(repo: Get.find(), sharedPreferences: Get.find()));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //  controller.loadData();
    });
  }

  @override
  void dispose() {
    Get.find<EmailVerificationController>().clearData();
    super.dispose();
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
              title: MyStrings.emailVerification,
              isShowBackBtn: true,
              fromAuth: true,
              textColor: MyColor.colorWhite,
              bgColor: Colors.transparent,
            ),
            body: GetBuilder<EmailVerificationController>(
              builder: (controller) => controller.dataLoading
                  ? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .06),
                          Center(
                            child: Image.asset(
                              MyImages.emailVerifyImage,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * .06),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .07),
                            child: Text(MyStrings.viaEmailVerify.tr, maxLines: 3, textAlign: TextAlign.center, style: mulishRegular.copyWith(color: MyColor.textColor)),
                          ),
                          const SizedBox(height: 30),
                          OTPFieldWidget(
                            onChanged: (value) {
                              controller.currentText = value;
                            },
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * .03),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: controller.isLoading
                                ? const RoundedLoadingButton()
                                : RoundedButton(
                                    text: MyStrings.verify.tr,
                                    press: () {
                                      if (controller.currentText.length != 6) {
                                        controller.hasError = true;
                                      } else {
                                        controller.verifyEmail(controller.currentText);
                                      }
                                    }),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .04,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                MyStrings.didNotReceiveCode.tr,
                                style: mulishRegular,
                              ),
                              SizedBox(
                                height: controller.resendLoading ? 5 : 2,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.sendCodeAgain();
                                  },
                                  child: controller.resendLoading
                                      ? const SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            color: MyColor.primaryColor,
                                          ))
                                      : Text(MyStrings.resend.tr, style: mulishBold.copyWith(decoration: TextDecoration.underline, color: MyColor.colorWhite)))
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
