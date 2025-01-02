import 'package:play_lab/constants/method.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/services/api_service.dart';

class RentRepo {
  ApiClient apiClient;
  RentRepo({required this.apiClient});

  Future<dynamic> getRentHistory(String page) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.rentHistoryEndPoint}?page=$page';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}
