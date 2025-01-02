import 'dart:convert';
import 'dart:io';

import 'package:play_lab/core/route/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/model/auth/registration_response_model.dart';
import 'package:play_lab/data/model/country_model/country_model.dart';
import 'package:play_lab/data/model/global/global_user_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/environment.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

import '../../../constants/my_strings.dart';
import '../../../core/helper/shared_pref_helper.dart';
import '../../../core/utils/url_container.dart';
import '../../model/account/profile_response_model.dart';
import '../../model/account/user_post_model/user_post_model.dart';
import '../../repo/account/profile_repo.dart';

class ProfileController extends GetxController implements GetxService {
  ProfileRepo profileRepo;

  ProfileResponseModel model = ProfileResponseModel();

  String imageStaticUrl = '';
  String callFrom = '';

  ProfileController({required this.profileRepo});

  List<String> errors = [];
  String imageUrl = '';
  String? currentPass, password, confirmPass;
  bool isLoading = false;

  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? userName;
  String? phoneNo;

  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  File? imageFile;

  addError({required String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
    }
  }

  removeError({required String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
    }
  }

  loadProfileInfo() async {
    isLoading = true;
    update();
    model = await profileRepo.loadProfileInfo();
    if (model.data != null && model.status == 'success') {
      loadData(model);
    } else {
      isLoading = false;
      update();
    }
    await getCountryData();
  }

  updateProfile(String callFrom) async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text.toString();
    String address = addressController.text.toString();
    String city = cityController.text.toString();
    String zip = zipCodeController.text.toString();
    String state = stateController.text.toString();
    GlobalUser? user = model.data?.user;

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      isLoading = true;
      update();

      UserPostModel model = UserPostModel(
        image: imageFile,
        firstName: firstName,
        lastName: user?.email ?? '',
        email: emailController.text == '' ? '' : emailController.text,
        username: userNameController.text,
        address: address,
        state: state,
        zip: zip,
        city: city,
        mobile: mobileNoController.text == '' ? '' : mobileNoController.text,
        country: countryName ?? '',
        mobileCode: mobileCode != null ? mobileCode!.replaceAll("[+]", "") : "",
        countryCode: countryCode ?? '',
      );
      bool b = await profileRepo.updateProfile(model, callFrom);

      if (b) {
        if (callFrom.toLowerCase() == 'profile_complete'.toLowerCase()) {
          Get.offAllNamed(RouteHelper.homeScreen);

          return;
        } else {
          await loadProfileInfo();
          callFrom = 'profile';
        }
      }

      isLoading = false;
      update();
    } else {
      if (firstName.isEmpty) {
        addError(error: MyStrings.kFirstNameNullError);
      }
      if (lastName.isEmpty) {
        addError(error: MyStrings.kLastNameNullError);
      }
    }

    update();
  }

  bool submitLoading = false;
  completeProfile() async {
    try {
      String address = addressController.text.toString();
      String city = cityController.text.toString();
      String zip = zipCodeController.text.toString();
      String state = stateController.text.toString();
      GlobalUser? user = model.data?.user;
      if (userNameController.text.isEmpty) {
        CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.enterYourUsername], msg: [], isError: true);
        return;
      }

      submitLoading = true;
      update();

      UserPostModel userPostModel = UserPostModel(
        image: null,
        firstName: user?.firstName ?? '',
        lastName: user?.lastName ?? '',
        email: user?.email ?? '',
        username: userNameController.text,
        address: address,
        state: state,
        zip: zip,
        city: city,
        mobile: mobileNoController.text == '' ? '' : mobileNoController.text,
        country: countryName ?? '',
        mobileCode: mobileCode != null ? mobileCode!.replaceAll("[+]", "") : "",
        countryCode: countryCode ?? '',
      );

      final RegistrationResponseModel responseModel = await profileRepo.completeProfile(userPostModel);

      if (responseModel.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        clearData();
        checkAndGotoNextStep(responseModel.data?.user);
        CustomSnackbar.showCustomSnackbar(msg: responseModel.message?.success ?? [MyStrings.success.tr], errorList: [], isError: false);
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: responseModel.message?.error ?? [MyStrings.somethingWentWrong.tr], isError: true, msg: []);
      }
    } catch (e) {
      submitLoading = false;
      update();
    }

    submitLoading = false;
    update();
  }

  void loadData(ProfileResponseModel? model) {
    imageUrl = '${UrlContainer.baseUrl}/assets/images/user/profile/${model?.data?.user?.image}';
    firstNameController.text = model?.data?.user?.firstName ?? '';
    profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${model?.data?.user?.firstName ?? ''} ${model?.data?.user?.lastName ?? ''}');
    lastNameController.text = model?.data?.user?.lastName ?? '';
    emailController.text = model?.data?.user?.email ?? '';
    mobileNoController.text = (model?.data?.user?.mobile ?? '').replaceAll('null', '');
    addressController.text = model?.data?.user?.address ?? '';
    stateController.text = model?.data?.user?.state ?? '';
    zipCodeController.text = model?.data?.user?.zip ?? '';
    cityController.text = model?.data?.user?.city ?? '';
    countryController.text = model?.data?.user?.country ?? '';
    isLoading = false;

    update();
  }

  void checkAndGotoNextStep(GlobalUser? user) async {
    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == '1' ? false : true;

    await profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, user?.email ?? '');
    await profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userIDKey, user?.id.toString() ?? '');
    await profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.phoneNumberKey, user?.mobile ?? '');
    await profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, user?.username ?? '');
    await profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userImageKey, user?.image ?? '');
    await profileRepo.sendUserToken();

    if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else {
      await profileRepo.sendUserToken();
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.homeScreen);
      });
    }
  }

  TextEditingController searchCountryController = TextEditingController();
  bool countryLoading = true;
  List<Countries> countryList = [];
  List<Countries> filteredCountries = [];

  String dialCode = Environment.defaultPhoneCode;
  void updateMobilecode(String code) {
    dialCode = code;
    update();
  }

  Future<dynamic> getCountryData() async {
    ResponseModel mainResponse = await profileRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      CountryModel model = CountryModel.fromJson(jsonDecode(mainResponse.responseJson));
      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
        filteredCountries.addAll(tempList);
      }
      var selectDefCountry = tempList!.firstWhere(
        (country) => country.countryCode!.toLowerCase() == Environment.defaultCountryCode.toLowerCase(),
        orElse: () => Countries(),
      );
      if (selectDefCountry.dialCode != null) {
        selectCountryData(selectDefCountry);
        setCountryNameAndCode(selectDefCountry.country.toString(), selectDefCountry.countryCode.toString(), selectDefCountry.dialCode.toString());
      }
      countryLoading = false;
      update();
      return;
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [mainResponse.message], msg: [], isError: true);
      countryLoading = false;
      update();
      isLoading = false;
      update();
      return;
    }
  }

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  Countries selectedCountryData = Countries();
  selectCountryData(Countries value) {
    selectedCountryData = value;
    update();
  }

  clearData() {
    userNameController.text = '';
    countryCode = '';
    countryCode = '';
    mobileCode = '';
    mobileNoController.text = '';
  }
}
