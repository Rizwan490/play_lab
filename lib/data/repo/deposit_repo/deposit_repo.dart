import 'dart:convert';

import 'package:play_lab/data/model/global/response_model/response_model.dart';

import '../../../constants/method.dart' as m;
import '../../../core/utils/url_container.dart';
import '../../model/deposit/deposit_history_main_response_model.dart';
import '../../model/deposit/insert_deposit_response_model.dart';
import '../../model/deposit/main_deposit_method_response_model.dart';
import '../../services/api_service.dart';

class DepositRepo {
  ApiClient apiClient;
  DepositRepo({required this.apiClient});

  Future<DepositHistoryMainResponseModel> loadAllDepositHistory(int page) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.depositHistoryEndPoint}$page';
    final response = await apiClient.request(url, m.Method.getMethod, null, passHeader: true);
    DepositHistoryMainResponseModel model = DepositHistoryMainResponseModel.fromJson(jsonDecode(response.responseJson));
    return model;
  }

  Future<MainDepositMethodResponseModel> getDepositMethod() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.depositMethodEndPoint}';
    final response = await apiClient.request(url, m.Method.getMethod, null, passHeader: true);
    MainDepositMethodResponseModel model = MainDepositMethodResponseModel.fromJson(jsonDecode(response.responseJson));
    if (model.data != null && model.data?.methods?.isNotEmpty == true) {
      model.setCode(200);
      return model;
    } else {
      model.setCode(400);
      return model;
    }
  }

  Future<InsertDepositResponseModel> insertDeposit(
    String subId,
    double amount,
    String? methodCode,
    String? currency, {
    String? isPlan,
  }) async {
    Map<String, dynamic> mapData = getInsertDepositMap(subId, amount.toString(), methodCode, currency);
    String url = '${UrlContainer.baseUrl}${UrlContainer.depositInsertEndPoint}';
    final response = await apiClient.request(url, m.Method.postMethod, mapData, passHeader: true);
    InsertDepositResponseModel model = InsertDepositResponseModel.fromJson(jsonDecode(response.responseJson));
    return model;
  }

  Map<String, dynamic> getInsertDepositMap(String subId, String? amount, String? methodCode, String? currency, {String? isPlan}) {
    Map<String, dynamic> map = {'subscription_id': subId, 'amount': amount, 'method_code': methodCode, 'currency': currency ?? '00'};
    return map;
  }

  Future<ResponseModel> sendManualPaymentRequest(String token, String methodCode, String amount, String planId, String cardHolderName) async {
    Map<String, dynamic> map = {'username': cardHolderName, 'token': token, 'plan_id': planId, 'amount': amount, 'method_code': methodCode};
    String url = '${UrlContainer.baseUrl}${UrlContainer.manualPaymentEndpoint}';
    ResponseModel response = await apiClient.request(url, m.Method.postMethod, map, passHeader: true);
    return response;
  }
}
