import 'dart:convert';

import '../../../constants/method.dart';
import '../../../constants/my_strings.dart';
import '../../../core/utils/url_container.dart';

import '../../../view/components/show_custom_snackbar.dart';
import '../../model/authorization/authorization_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class SmsEmailVerificationRepo {
  ApiClient apiClient;

  SmsEmailVerificationRepo({required this.apiClient});

  Future<bool> verify(String code, {bool isEmail = true, bool isTFA = false}) async {
    final map = modelToMap(code, isEmail);

    String url = '${UrlContainer.baseUrl}${isEmail ? UrlContainer.verifyEmailEndPoint : UrlContainer.verifySmsEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'error') {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? ['${isEmail ? 'Email' : 'Sms'} ${MyStrings.verificationFailed}'], msg: [], isError: true);
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Map<String, String> modelToMap(String code, bool isEmail) {
    Map<String, String> bodyFields = {
      'code': code,
    };

    return bodyFields;
  }

  Future<bool> sendAuthorizationRequest() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.authorizationCodeEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    if (response.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status == 'error') {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: false);
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resendVerifyCode({required bool isEmail}) async {
    final queryString = '${UrlContainer.baseUrl}${UrlContainer.resendVerifyCodeEndPoint}/${isEmail ? 'email' : 'mobile'}';

    final response = await apiClient.request(queryString, Method.getMethod, null, passHeader: true);

    if (response.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));

      if (model.status == 'error') {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.resendCodeFail], msg: [], isError: true);
        return false;
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [''], msg: model.message?.success ?? [MyStrings.successfullyCodeResend], isError: false);
        return true;
      }
    } else {
      return false;
    }
  }
}
