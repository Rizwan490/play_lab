import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/data/model/auth/registration_response_model.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/account/profile_response_model.dart';
import '../../model/account/user_post_model/user_post_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';
import 'package:http/http.dart' as http;

class ProfileRepo {
  ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  Future<bool> updateProfile(UserPostModel m, String callFrom) async {
    apiClient.initToken();
    String url = '${UrlContainer.baseUrl}${callFrom == 'profile' ? UrlContainer.updateProfileEndPoint : UrlContainer.profileCompleteEndPoint}';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    Map<String, String> map = {
      'firstname': m.firstName,
      'lastname': m.lastName,
      'address': m.address ?? '',
      'zip': m.zip ?? '',
      'state': m.state ?? "",
      'city': m.city ?? '',
    };

    request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});
    if (m.image != null) {
      print("update with image");
      request.files.add(http.MultipartFile('image', m.image!.readAsBytes().asStream(), m.image!.lengthSync(), filename: m.image!.path.split('/').last));
    }
    request.fields.addAll(map);
    http.StreamedResponse response = await request.send();

    String jsonResponse = await response.stream.bytesToString();
    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

    if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
      CustomSnackbar.showCustomSnackbar(errorList: [], msg: model.message?.success ?? [MyStrings.success], isError: false);
      return true;
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.requestFailed.tr], msg: [], isError: true);
      return false;
    }
  }

  Future<RegistrationResponseModel> completeProfile(UserPostModel m) async {
    apiClient.initToken();
    String url = '${UrlContainer.baseUrl}${UrlContainer.profileCompleteEndPoint}';
    final map = modelToMap(m);
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    final json = jsonDecode(res.responseJson);
    RegistrationResponseModel responseModel = RegistrationResponseModel.fromJson(json);
    return responseModel;
  }

  Future<dynamic> getCountryList() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
    ResponseModel model = await apiClient.request(url, Method.getMethod, null);
    return model;
  }

  Future<ProfileResponseModel> loadProfileInfo() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';

    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    if (responseModel.statusCode == 200) {
      ProfileResponseModel model = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'success') {
        await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userImageKey, model.data?.user?.image ?? '');

        return model;
      } else {
        return ProfileResponseModel();
      }
    } else {
      return ProfileResponseModel();
    }
  }

  Future<bool> sendUserToken() async {
    String deviceToken;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.fcmDeviceKey)) {
      deviceToken = apiClient.sharedPreferences.getString(SharedPreferenceHelper.fcmDeviceKey) ?? '';
    } else {
      deviceToken = '';
    }

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    if (deviceToken.isEmpty) {
      firebaseMessaging.getToken().then((fcmDeviceToken) async {
      });
    } else {
      firebaseMessaging.onTokenRefresh.listen((fcmDeviceToken) async {
        if (deviceToken == fcmDeviceToken) {
        } else {
          apiClient.sharedPreferences.setString(SharedPreferenceHelper.fcmDeviceKey, fcmDeviceToken);
        }
      });
    }
    return true;
  }

  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String, String> map = deviceTokenMap(deviceToken);
    await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return true;
  }

  Map<String, String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }

//
  Map<String, dynamic> modelToMap(UserPostModel model) {
    Map<String, dynamic> bodyFields = {
      'firstname': model.firstName,
      'lastname': model.lastName,
      'address': model.address ?? '',
      'zip': model.zip ?? '',
      'state': model.state ?? "",
      'city': model.city ?? '',
      'mobile': model.mobile,
      'email': model.email,
      'username': model.username,
      'country_code': model.countryCode,
      'country': model.country,
      "mobile_code": model.mobileCode,
    };

    return bodyFields;
  }
}
