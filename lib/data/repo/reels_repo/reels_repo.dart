import 'package:play_lab/constants/method.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/services/api_service.dart';

class ReelsRepo {
  ApiClient apiClient;
  ReelsRepo({required this.apiClient});
  //

  Future<dynamic> getReels(bool isMylist) async {
    String url = isMylist ? '${UrlContainer.baseUrl}${UrlContainer.authSortsEndPoint}' : '${UrlContainer.baseUrl}${UrlContainer.sortsEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> likeDislikeVideo({required String id, required String type}) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.likeEndPoint}';
    Map<String, String> map = {'id': id, 'type': type};
    final response = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return response;
  }

  Future<dynamic> favorite({required String id}) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.favoriteList}';
    Map<String, String> map = {'id': id};
    final response = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return response;
  }
}
