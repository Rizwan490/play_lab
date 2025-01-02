import 'package:play_lab/constants/method.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/services/api_service.dart';

class AllEpisodeRepo {
  ApiClient apiClient;

  AllEpisodeRepo({required this.apiClient});

  Future<dynamic>getEpisode(int page)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.allEpisodeEndPoint}$page';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }


}
