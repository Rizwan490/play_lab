import 'dart:convert';

import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/subscribe_plan/subscribe_plan_response_model.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

import '../../../constants/method.dart';

class SubscribePlanRepo {
  ApiClient apiClient;
  SubscribePlanRepo({required this.apiClient});

  Future<bool> canBuyPlan() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.checkPlanStatusEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
    if (model.status == "success") {
      return true;
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [''], msg: [], isError: true);
      return false;
    }
  }

  Future<dynamic> getPlan({required int page}) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.getPlanEndPoint}?page=$page';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> buyPlan(int id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.buyPlanEndPoint}';
    Map<String, dynamic> params = {'id': id.toString(), 'type': 'plan'};
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<dynamic> verifyPlan({
    required PlanModel plan,
    required String token,
    required String method,
    required String currency,
    required String amount,
    required String purchaseCode,
    required String packageName,
    required String productId,
  }) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.purchasePlanEndPoint}';
    Map<String, dynamic> params = {
      'plan_id': plan.id.toString(),
      'type': 'plan',
      'user_id': apiClient.sharedPreferences.getString(SharedPreferenceHelper.userIDKey),
      'amount': amount,
      'currency': currency,
      'token': token,
      'method_code': method,
      'purchaseToken': token,
      'productId': productId,
      'purchase_code': purchaseCode,
      'packageName': packageName,
    };
    print("Subcribe repo");
    print(params);
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }
}
