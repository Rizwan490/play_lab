import 'package:play_lab/constants/method.dart';

import '../../../core/utils/url_container.dart';
import '../../services/api_service.dart';

class FaqRepo {
  ApiClient apiClient;
  FaqRepo({required this.apiClient});

  Future<dynamic> loadFaq() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.faqEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }
}
