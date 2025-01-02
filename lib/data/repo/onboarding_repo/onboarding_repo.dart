import 'package:play_lab/constants/method.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/services/api_service.dart';

class OnboardingRepo {
  ApiClient apiClient;

  OnboardingRepo({required this.apiClient});

  Future<dynamic> getOnboardingData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.onboardingEndPoint}';
    ResponseModel model = await apiClient.request(url, Method.getMethod, null);
    return model;
  }
}
