import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/my_strings.dart';
import '../../../../core/helper/shared_pref_helper.dart';
import '../../../../core/route/route.dart';
import '../../../../view/components/show_custom_snackbar.dart';
import '../../../repo/auth/sms_email_verification_repo.dart';

class EmailVerificationController extends GetxController {
  bool dataLoading = false;
  bool isLoading = false;
  SmsEmailVerificationRepo repo;
  SharedPreferences sharedPreferences;
  EmailVerificationController({required this.repo, required this.sharedPreferences});

  bool hasError = false;
  String currentText = "";

  bool needSmsVerification = false;
  bool isProfileCompleteEnable = false;

  String get getUserEmailAddress => sharedPreferences.getString(SharedPreferenceHelper.userEmailKey) ?? '';

  verifySms() async {}

  loadData() async {
    dataLoading = true;
    await repo.sendAuthorizationRequest();
    dataLoading = false;
    update();
  }

  verifyEmail(String text) async {
    if (text.isEmpty) {
      return;
    }

    changeIsLoadingStatus(true);
    final bool isSuccess = await repo.verify(text, isEmail: true);

    if (isSuccess) {
      if (needSmsVerification) {
        CustomSnackbar.showCustomSnackbar(errorList: [], msg: [MyStrings.emailOtpSuccessMessage], isError: false);
        Get.offAndToNamed(RouteHelper.smsVerificationScreen, arguments: isProfileCompleteEnable);
      } else {
        Get.offAllNamed(
          isProfileCompleteEnable ? RouteHelper.profileComplete : RouteHelper.homeScreen,
        );
      }
    }
    changeIsLoadingStatus(false);
  }

  changeIsLoadingStatus(bool b) {
    isLoading = b;
    update();
  }

  bool resendLoading = false;
  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: true);
    resendLoading = false;
    update();
  }

  void clearData() {
    resendLoading = false;
    isLoading = false;
    dataLoading = true;
  }
}
