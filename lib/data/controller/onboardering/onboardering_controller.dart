import 'dart:convert';

import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/onboarding/onboarding_response_model.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/onboarding_repo/onboarding_repo.dart';

class OnboardingController extends GetxController {
  String firstHeader = '';
  String secondHeader = '';
  String thirdHeader = '';

  String firstSubHeader = '';
  String secondSubHeader = '';
  String thirdSubHeader = '';

  String bgImageUrl = '';

  bool isLoading = true;

  OnboardingRepo onboardingRepo;

  OnboardingController({required this.onboardingRepo});

  getOnboardingData(ResponseModel responseModel) async {
    if (responseModel.statusCode == 200) {
      OnboardingResponseModel model = OnboardingResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.data == null) {
        return;
      } else {
        firstHeader = model.data?.welcome?.screen1Heading ?? '';
        secondHeader = model.data?.welcome?.screen2Heading ?? '';
        thirdHeader = model.data?.welcome?.screen3Heading ?? '';

        firstSubHeader = model.data?.welcome?.screen1Subheading ?? '';
        secondSubHeader = model.data?.welcome?.screen2Subheading ?? '';
        thirdSubHeader = model.data?.welcome?.screen3Subheading ?? '';

        bgImageUrl = '${UrlContainer.baseUrl}${model.data?.path}/${model.data?.welcome?.backgroundImage}';
        onboardingRepo.apiClient.storeAppOpeningStatus();
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }
    isLoading = false;
    update();
  }

  gotoLoginPage() {
    Get.toNamed(RouteHelper.loginScreen);
  }

  getHeaderText(int index) {
    if (index == 0) {
      return firstHeader;
    } else if (index == 1) {
      return secondHeader;
    } else if (index == 2) {
      return thirdHeader;
    } else {
      return '';
    }
  }

  getSubHeaderText(int index) {
    if (index == 0) {
      return firstSubHeader;
    } else if (index == 1) {
      return secondSubHeader;
    } else if (index == 2) {
      return thirdSubHeader;
    } else {
      return '';
    }
  }

  void gotoLoginScreen() {
    Get.toNamed(RouteHelper.loginScreen);
  }
}
