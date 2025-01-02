import 'dart:convert';

import 'package:play_lab/constants/my_strings.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/common_api_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class ChangePasswordRepo {
  ApiClient apiClient;
  ChangePasswordRepo({required this.apiClient});

  String token = '', tokenType = '';

  Future<bool> changePassword(String currentPass, String password) async {
    final params = modelToMap(currentPass, password);

    String url = '${UrlContainer.baseUrl}${UrlContainer.changePasswordEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    if (responseModel.statusCode == 200) {
      CommonApiResponseModel model = CommonApiResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.message?.success != null && model.message!.success!.isNotEmpty) {
        CustomSnackbar.showCustomSnackbar(errorList: [], msg: model.message?.success ?? [MyStrings.passwordChanged], isError: false);
        return true;
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.failedToChangedPassword], msg: [], isError: true);
        return false;
      }
    } else {
      return false;
    }
  }

  modelToMap(String currentPassword, String newPass) {
    Map<String, dynamic> map2 = {'current_password': currentPassword, 'password': newPass, 'password_confirmation': newPass};
    return map2;
  }
}
