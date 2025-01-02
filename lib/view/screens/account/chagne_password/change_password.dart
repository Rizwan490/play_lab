import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../data/controller/account/change_password_controller.dart';
import '../../../../data/repo/account/change_password_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/from_errors.dart';
import '../../../components/label_text.dart';
import '../../../components/nav_drawer/custom_nav_drawer.dart';
import '../../../components/buttons/rounded_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ChangePasswordRepo(apiClient: Get.find()));
    Get.put(ChangePasswordController(changePasswordRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ChangePasswordController>().clearData();
    });
  }

  @override
  void dispose() {
    Get.find<ChangePasswordController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
        builder: (controller) => Scaffold(
              appBar: const CustomAppBar(
                title: MyStrings.changePassword,
                bgColor: Colors.transparent,
              ),
              drawer: const NavigationDrawerWidget(),
              backgroundColor: MyColor.secondaryColor,
              body: SizedBox(
                child: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: MyColor.primaryColor,
                        ),
                      )
                    : Center(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(border: Border.all(color: MyColor.bodyTextColor, width: 2), borderRadius: BorderRadius.circular(15), color: MyColor.secondaryColor),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LabelText(text: MyStrings.currentPassword),
                                CustomTextField(
                                  // hintText: MyStrings.currentPassword,
                                  isShowBorder: true,
                                  isPassword: false,
                                  isShowSuffixIcon: false,
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                  focusNode: controller.currentPassFocusNode,
                                  controller: controller.currentPassController,
                                  onSuffixTap: () {},
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      controller.removeError(error: MyStrings.currentPassNullError);
                                    }
                                    if (value.isEmpty) {
                                      controller.addError(error: MyStrings.currentPassNullError);
                                    }
                                    return;
                                  },
                                  nextFocus: controller.passwordFocusNode,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const LabelText(text: MyStrings.password),
                                CustomTextField(
                                  // hintText: MyStrings.enterNewPass,
                                  isShowBorder: true,
                                  isPassword: true,
                                  isShowSuffixIcon: true,
                                  inputType: TextInputType.text,
                                  inputAction: TextInputAction.next,
                                  focusNode: controller.passwordFocusNode,
                                  controller: controller.passController,
                                  onSuffixTap: () {},
                                  onChanged: (value) {
                                    if (controller.confirmPassController.text == controller.passController.text) {
                                      controller.removeError(error: MyStrings.kMatchPassError);
                                    } else {
                                      controller.addError(error: MyStrings.kMatchPassError);
                                    }
                                    if (value.isNotEmpty) {
                                      controller.removeError(error: MyStrings.kPassNullError);
                                    }
                                    if (value.isEmpty) {
                                      controller.addError(error: MyStrings.kPassNullError);
                                    }
                                    return;
                                  },
                                  nextFocus: controller.confirmPassFocusNode,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const LabelText(text: MyStrings.confirmPassword),
                                CustomTextField(
                                  // hintText: MyStrings.confirmPassword.capitalizeFirst??'',
                                  isShowBorder: true,
                                  isPassword: true,
                                  isShowSuffixIcon: true,
                                  inputType: TextInputType.text,
                                  inputAction: TextInputAction.done,
                                  focusNode: controller.confirmPassFocusNode,
                                  controller: controller.confirmPassController,
                                  onSuffixTap: () {},
                                  onChanged: (value) {
                                    if (controller.confirmPassController.text == controller.passController.text) {
                                      controller.removeError(error: MyStrings.kMatchPassError);
                                    } else {
                                      controller.addError(error: MyStrings.kMatchPassError);
                                    }
                                    return;
                                  },
                                ),
                                FormError(errors: controller.errors),
                                const SizedBox(
                                  height: 30,
                                ),
                                Center(
                                    child: RoundedButton(
                                        text: MyStrings.changePassword,
                                        press: () {
                                          controller.changePassword();
                                        }))
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ));
  }
}
