import 'package:play_lab/constants/method.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/services/api_service.dart';

class AllMoviesRepo {
  ApiClient apiClient;

  AllMoviesRepo({required this.apiClient});

  Future<dynamic>getMovie(int page)async{
    String url='${UrlContainer.baseUrl}api/movies?page=$page';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }


}
