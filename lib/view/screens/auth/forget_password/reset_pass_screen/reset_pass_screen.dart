import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/util.dart';
import '../../../../../data/controller/auth/auth/forget_password_controller.dart';
import '../../../../../data/repo/auth/login_repo.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/app_bar/custom_appbar.dart';
import '../../../../components/auth_image.dart';
import '../../../../components/bg_widget/bg_image_widget.dart';
import '../../../../components/buttons/rounded_button.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../components/from_errors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    MyUtil.changeTheme();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    final controller = Get.put(ForgetPasswordController(loginRepo: Get.find()));
    controller.email = Get.arguments;
    super.initState();
  }

  @override
  void dispose() {
    Get.find<ForgetPasswordController>().errors.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ForgetPasswordController>().isLoading = false;
    return Stack(
      children: [
        const MyBgWidget(),
        PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: MyStrings.resetPassword.tr, fromAuth: true),
            body: GetBuilder<ForgetPasswordController>(
              builder: (controller) => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  child: ListView(
                    shrinkWrap: true,
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
                          text: TextSpan(text: MyStrings.resetLabelText.tr, style: const TextStyle(color: MyColor.t2, fontSize: Dimensions.authTextSize)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          CustomTextField(
                              fillColor: MyColor.textFiledFillColor,
                              focusNode: controller.passwordFocusNode,
                              nextFocus: controller.confirmPasswordFocusNode,
                              hintText: MyStrings.password,
                              isShowSuffixIcon: true,
                              isPassword: true,
                              inputType: TextInputType.text,
                              onChanged: (value) {
                                controller.password = value;
                                if (value.isNotEmpty) {
                                  controller.removeError(error: MyStrings.kPassNullError);
                                } else {
                                  controller.addError(error: MyStrings.kPassNullError);
                                }
                                if (controller.password.toString() == controller.confirmPassword.toString()) {
                                  controller.removeError(error: MyStrings.kMatchPassError);
                                  return;
                                } else {
                                  controller.addError(error: MyStrings.kMatchPassError);
                                  return;
                                }
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                              fillColor: MyColor.textFiledFillColor,
                              inputAction: TextInputAction.done,
                              isPassword: true,
                              hintText: MyStrings.confirmPassword,
                              isShowSuffixIcon: true,
                              onChanged: (value) {
                                controller.confirmPassword = value;
                                if (controller.password.toString() == controller.confirmPassword.toString()) {
                                  controller.removeError(error: MyStrings.kMatchPassError);
                                  return;
                                } else {
                                  controller.addError(error: MyStrings.kMatchPassError);
                                  return;
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          FormError(errors: controller.errors),
                          const SizedBox(
                            height: 50,
                          ),
                          controller.isLoading
                              ? const RoundedLoadingButton()
                              : RoundedButton(
                                  width: 1,
                                  text: MyStrings.submit,
                                  press: () {
                                    controller.resetPassword();
                                  },
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
