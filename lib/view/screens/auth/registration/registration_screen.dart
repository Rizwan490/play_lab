import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/controller/auth/social_login_controller.dart';
import 'package:play_lab/data/repo/auth/social_login_repo.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:play_lab/view/screens/auth/registration/widget/socaical_auth_widget.dart';
import 'package:play_lab/view/screens/auth/registration/widget/validation_widget.dart';
import 'package:play_lab/view/will_pop_widget.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/util.dart';
import '../../../../data/controller/auth/auth/signup_controller.dart';
import '../../../../data/repo/auth/general_setting_repo.dart';
import '../../../../data/repo/auth/signup_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/auth_image.dart';
import '../../../components/bg_widget/bg_image_widget.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/from_errors.dart';
import '../../../components/buttons/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    MyUtil.changeTheme();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    Get.put(SignupRepo(apiClient: Get.find()));
    Get.put(SocialLoginRepo(apiClient: Get.find()));
    Get.put(SocialLoginController(repo: Get.find()));
    final controller = Get.put(SignUpController(signUpRepo: Get.find(), sharedPreferences: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
    });
  }

  String? selectedValue;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: Stack(
        children: [
          const MyBgWidget(),
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: GetBuilder<SignUpController>(
                  builder: (controller) => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * .02),
                              const AuthImageWidget(),
                              SizedBox(height: MediaQuery.of(context).size.height * .05),
                              const SocaicalAuthWidget(),
                              SizedBox(height: MediaQuery.of(context).size.height * .02),
                              CustomTextField(
                                fillColor: MyColor.textFiledFillColor,
                                controller: controller.fNameController,
                                focusNode: controller.firstNameFocusNode,
                                inputType: TextInputType.text,
                                nextFocus: controller.lastNameFocusNode,
                                hintText: MyStrings.firstName,
                                maxLines: 1,
                                onChanged: (value) {
                                  return;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return MyStrings.kFirstNameNullError.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                fillColor: MyColor.textFiledFillColor,
                                controller: controller.lNameController,
                                focusNode: controller.lastNameFocusNode,
                                nextFocus: controller.emailFocusNode,
                                hintText: MyStrings.lastName,
                                inputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                                onChanged: (value) {
                                  return;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return MyStrings.kLastNameNullError;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                fillColor: MyColor.textFiledFillColor,
                                controller: controller.emailController,
                                focusNode: controller.emailFocusNode,
                                nextFocus: controller.passwordFocusNode,
                                hintText: MyStrings.email,
                                inputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.next,
                                onChanged: (value) {
                                  return;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return MyStrings.kEmailNullError;
                                  }
                                  if (!MyStrings.emailValidatorRegExp.hasMatch(value)) {
                                    return MyStrings.kInvalidEmailError;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                                child: ValidationWidget(
                                  list: controller.passwordValidationRules,
                                ),
                              ),
                              Focus(
                                onFocusChange: (hasFocus) {
                                  controller.changePasswordFocus(hasFocus);
                                },
                                child: CustomTextField(
                                  controller: controller.passwordController,
                                  focusNode: controller.passwordFocusNode,
                                  nextFocus: controller.confirmPasswordFocusNode,
                                  hintText: MyStrings.password,
                                  isShowSuffixIcon: true,
                                  isPassword: true,
                                  fillColor: MyColor.textFiledFillColor,
                                  inputType: TextInputType.text,
                                  onChanged: (value) {
                                    if (controller.checkPasswordStrength) {
                                      controller.updateValidationList(value);
                                    }
                                    return;
                                  },
                                  validator: (value) {
                                    return controller.validatePassword(value ?? '');
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                fillColor: MyColor.textFiledFillColor,
                                controller: controller.cPasswordController,
                                focusNode: controller.confirmPasswordFocusNode,
                                inputAction: TextInputAction.done,
                                isPassword: true,
                                hintText: MyStrings.confirmPassword,
                                isShowSuffixIcon: true,
                                onChanged: (value) {},
                                validator: (value) {
                                  if (controller.passwordController.text != controller.cPasswordController.text) {
                                    return MyStrings.kMatchPassError.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              controller.needAgree
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Checkbox(
                                              side: WidgetStateBorderSide.resolveWith((states) => const BorderSide(width: 2, color: Colors.white)),
                                              activeColor: MyColor.primaryColor,
                                              value: controller.agreeTC,
                                              checkColor: MyColor.colorWhite,
                                              onChanged: (value) {
                                                controller.updateAgreeTC();
                                              }),
                                        ),
                                        Flexible(
                                          child: Text.rich(
                                            TextSpan(text: '${MyStrings.iAgreeWith.tr} ', style: mulishRegular, children: [
                                              TextSpan(
                                                  text: MyStrings.policies.tr,
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      Get.toNamed(RouteHelper.privacyScreen);
                                                    },
                                                  style: mulishBold.copyWith(color: MyColor.primaryColor, decorationColor: MyColor.primaryColor, decoration: TextDecoration.underline)),
                                            ]),
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(height: 10),
                              FormError(errors: controller.errors),
                              const SizedBox(height: 20),
                              controller.isLoading
                                  ? const RoundedLoadingButton()
                                  : RoundedButton(
                                      text: MyStrings.submit,
                                      press: () {
                                        if (formKey.currentState!.validate()) {
                                          controller.signUpUser();
                                        }
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
