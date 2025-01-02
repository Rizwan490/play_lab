import 'package:play_lab/constants/method.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';

import '../../../core/utils/url_container.dart';
import '../../services/api_service.dart';

class TournamentRepo {
  ApiClient apiClient;
  TournamentRepo({required this.apiClient});

  Future<dynamic> getEventList() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.liveTournamentsListEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> getSubcriptionData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.userSubcriptionEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> getEventDetails(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.liveTournamentDetailsEndPoint}/$id';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> watchGame(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.gameWatchEndPoint}/$id';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> buyEvent(String id, {bool isGame = false}) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.buyPlanEndPoint}';
    Map<String, dynamic> params = {
      'id': id.toString(),
      'type': isGame ? "game" : 'tournament',
    };
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }
}
