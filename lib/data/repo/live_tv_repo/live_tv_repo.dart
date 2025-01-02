import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/services/api_service.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';

class LiveTvRepo {
  ApiClient apiClient;
  LiveTvRepo({required this.apiClient});

  Future<dynamic> getLiveTv(int page) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.liveTelevisionEndPoint}?page=$page';
    print(url.toString());
    final response = await apiClient.request(url, Method.getMethod, null);
    print(response.responseJson);
    return response;
  }

  Future<dynamic> getLiveTvDetails(String tvId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.liveTvDetailsEndPoint}$tvId';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> subcribeChannel(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.buyPlanEndPoint}';
    Map<String, dynamic> params = {'id': id.toString(), 'type': 'channel_category'};
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<dynamic> getSubcriptionData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.userSubcriptionEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }
}
