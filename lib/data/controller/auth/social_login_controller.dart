import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:play_lab/constants/constant_helper.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/data/model/auth/login_response_model.dart';
import 'package:play_lab/data/model/general_setting/general_settings_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/repo/auth/social_login_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:play_lab/view/package/signin_with_linkdin/signin_with_linkedin.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SocialLoginController extends GetxController {
  SocialLoginRepo repo;
  SocialLoginController({required this.repo});

  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isGoogleSignInLoading = false;
  Future<void> signInWithGoogle() async {
    try {
      isGoogleSignInLoading = true;
      update();
      googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        isGoogleSignInLoading = false;
        update();
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      await socialLoginUser(provider: 'google', accessToken: googleAuth.accessToken ?? '');
    } catch (e) {
      debugPrint(e.toString());
      CustomSnackbar.showCustomSnackbar(errorList: [e.toString()], isError: true, msg: []);
    }

    isGoogleSignInLoading = false;
    update();
  }
//

  bool facebookLoginLoading = false;
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
      
        String token = loginResult.accessToken?.tokenString ?? '';

        await socialLoginUser(accessToken: token, provider: 'facebook');
      } else {}
    } catch (e) {
      PrintHelper.printHelper(e.toString());
    }

    // Create a credential from the access token
  }

  //SIGN IN With LinkeDin
  bool isLinkedinLoading = false;
  Future<void> signInWithLinkedin(BuildContext context) async {
    try {
      isLinkedinLoading = false;
      update();

      SocialiteCredentials linkedinCredential = repo.apiClient.getSocialCredentialsConfigData();
      String linkedinCredentialRedirectUrl = "${repo.apiClient.getSocialCredentialsRedirectUrl()}/linkedin";
      printx(linkedinCredentialRedirectUrl);
      printx(linkedinCredential.linkedin?.toJson());
      SignInWithLinkedIn.signIn(
        context,
        config: LinkedInConfig(clientId: linkedinCredential.linkedin?.clientId ?? '', clientSecret: linkedinCredential.linkedin?.clientSecret ?? '', scope: ['openid', 'profile', 'email'], redirectUrl: linkedinCredentialRedirectUrl),
        onGetAuthToken: (data) {
          printx('Auth token data: ${data.toJson()}');
        },
        onGetUserProfile: (token, user) async {
          printx('${token.idToken}-');
          printx('LinkedIn User: ${user.toJson()}');
          await socialLoginUser(provider: 'linkedin', accessToken: token.accessToken ?? '');
        },
        onSignInError: (error) {
          printx('Error on sign in: $error');
          CustomSnackbar.showCustomSnackbar(errorList: [error.description ?? MyStrings.loginFailedTryAgain.tr], isError: true, msg: []);
          isLinkedinLoading = false;
          update();
        },
      );
    } catch (e) {
      debugPrint(e.toString());

      CustomSnackbar.showCustomSnackbar(errorList: [e.toString()], isError: true, msg: []);
    }
  }

  Future socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    try {
      ResponseModel responseModel = await repo.socialLoginUser(
        accessToken: accessToken,
        provider: provider,
      );
      if (responseModel.statusCode == 200) {
        LoginResponseModel loginModel = LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
          checkAndGotoNextStep(loginModel);
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: loginModel.message?.error ?? [MyStrings.loginFailedTryAgain.tr], isError: true, msg: []);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], isError: true, msg: []);
      }
    } catch (e) {
      //printx(e.toString());
    }
  }

  bool checkSocialAuthActiveOrNot({String provider = 'all'}) {
    if (provider == 'google') {
      return repo.apiClient.getSocialCredentialsConfigData().google?.status == '1';
    } else if (provider == 'facebook') {
      return repo.apiClient.getSocialCredentialsConfigData().facebook?.status == '1';
    } else if (provider == 'linkedin') {
      return repo.apiClient.getSocialCredentialsConfigData().linkedin?.status == '1';
    } else {
      return repo.apiClient.isSocialAnyOfSocialLoginOptionEnable();
    }
  }

//
  void checkAndGotoNextStep(LoginResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.user?.ev.toString() == "0" ? true : false;
    bool needSmsVerification = responseModel.data?.user?.sv.toString() == '0' ? true : false;

    String expDate = responseModel.data?.user?.exp ?? '';

    repo.apiClient.storeExpiredDate(expDate);

    await repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, responseModel.data?.accessToken ?? '');
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, responseModel.data?.tokenType ?? '');
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, responseModel.data?.user?.email ?? '');
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userIDKey, responseModel.data?.user?.id.toString() ?? '');
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.phoneNumberKey, responseModel.data?.user?.mobile ?? '');
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, responseModel.data?.user?.username ?? '');
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userImageKey, responseModel.data?.user?.image ?? '');

    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userFullNameKey, '${responseModel.data?.user?.firstName ?? ''} ${responseModel.data?.user?.lastName ?? ''}');

    await repo.sendUserToken();

    bool isProfileCompleteEnable = responseModel.data?.user?.profileComplete == '0' ? true : false;
    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileComplete);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else {
      Get.offAndToNamed(RouteHelper.homeScreen);
    }
  }
}
