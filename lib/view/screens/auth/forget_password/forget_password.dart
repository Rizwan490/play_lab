import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/util.dart';
import '../../../../data/controller/auth/auth/forget_password_controller.dart';
import '../../../../data/repo/auth/login_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/auth_image.dart';
import '../../../components/bg_widget/bg_image_widget.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/from_errors.dart';
import '../../../components/buttons/rounded_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    MyUtil.changeTheme();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ForgetPasswordController>().isLoading = false;
      Get.find<ForgetPasswordController>().email = '';
    });
  }

  @override
  void dispose() {
    Get.find<ForgetPasswordController>().errors.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyBgWidget(),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar:const CustomAppBar(fromAuth: true,isShowBackBtn: true,title: MyStrings.forgetPassword),
            body: GetBuilder<ForgetPasswordController>(
              builder: (auth) => SingleChildScrollView(
                child: Column(
                  children: [
                   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                            child: RichText(
                              text: TextSpan(
                                  text: MyStrings.toRecover.tr,
                                  style: const TextStyle(color: MyColor.t2, fontSize: Dimensions.authTextSize)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          CustomTextField(
                            hintText: MyStrings.emailOrUserName,
                            isShowBorder: true,
                            isPassword: false,
                            fillColor: MyColor.textFiledFillColor,
                            isShowSuffixIcon: false,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.done,
                            onSuffixTap: () {},
                            onChanged: (value) {
                              auth.email = value;
                              if (value.isNotEmpty) {
                                auth.removeError(error: MyStrings.kEmailNullError);
                              }
                              if (value!.isEmpty) {
                                auth.addError(error: MyStrings.kEmailNullError);
                                auth.removeError(error: MyStrings.kInvalidEmailError);
                              }
                              return;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FormError(errors: auth.errors),
                          const SizedBox(
                            height: 20,
                          ),
                          auth.isLoading
                              ? const RoundedLoadingButton()
                              : RoundedButton(
                                  press: () {
                                    auth.submitForgetPassCode();
                                  },
                                  text: MyStrings.submit,
                                ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
