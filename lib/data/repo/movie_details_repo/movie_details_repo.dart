import 'dart:convert';

import 'package:play_lab/constants/method.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/services/api_service.dart';

class MovieDetailsRepo {
  ApiClient apiClient;

  MovieDetailsRepo({required this.apiClient});

  Future<dynamic> getVideoDetails(int itemId, {int episodeId = -1}) async {
    late ResponseModel response;
    String token = apiClient.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey) ?? '';
    String url = '';
    if (episodeId == -1 || episodeId == 0) {
      url = '${UrlContainer.baseUrl}${token.isEmpty ? UrlContainer.watchVideoEndPoint : UrlContainer.watchVideoPaidEndPoint}=$itemId';
    } else {
      url = '${UrlContainer.baseUrl}${token.isEmpty ? UrlContainer.watchVideoEndPoint : UrlContainer.watchVideoPaidEndPoint}=$itemId&episode_id=$episodeId';
    }
    if (token.isEmpty) {
      response = await apiClient.request(url, Method.getMethod, null);
    } else {
      response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    }
    return response;
  }

  Future<dynamic> getVideoData(int itemId, {int episodeId = -1}) async {
    String token = apiClient.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey) ?? '';
    late ResponseModel response;

    String url = '';
    if (token.isEmpty) {
      if (episodeId == -1) {
        url = '${UrlContainer.baseUrl}${UrlContainer.playVideoEndPoint}=$itemId';
      } else {
        url = '${UrlContainer.baseUrl}${UrlContainer.playVideoEndPoint}=$itemId&episode_id=$episodeId';
      }
      response = await apiClient.request(url, Method.getMethod, null);
    } else {
      if (episodeId == -1) {
        url = '${UrlContainer.baseUrl}${UrlContainer.playVideoPaidEndPoint}=$itemId';
      } else {
        url = '${UrlContainer.baseUrl}${UrlContainer.playVideoPaidEndPoint}=$itemId&episode_id=$episodeId';
      }
      response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    }

    return response;
  }

  Future<dynamic> checkWishlist(int itemId, {int episodeId = -1}) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.checkWishlistEndpoint}${episodeId < 1 ? 'item_id=${itemId.toString()}' : 'episode_id=${episodeId.toString()}'}';

    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
    return model.remark == 'true' ? true : false;
  }

  Future<dynamic> addInWishList(int itemId, {int episodeId = -1}) async {
    late ResponseModel response;
    String url = '';
    if (episodeId == -1) {
      url = '${UrlContainer.baseUrl}${UrlContainer.addInWishlistEndPoint}?item_id=$itemId';
    } else {
      url = '${UrlContainer.baseUrl}${UrlContainer.addInWishlistEndPoint}?episode_id=$episodeId';
    }
    response = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> removeFromWishList(int itemId, {int episodeId = -1}) async {
    late ResponseModel response;
    String url = '';
    if (episodeId == -1) {
      url = '${UrlContainer.baseUrl}${UrlContainer.removeFromWishlistEndPoint}item_id=$itemId';
    } else {
      url = '${UrlContainer.baseUrl}${UrlContainer.removeFromWishlistEndPoint}episode_id=$episodeId';
    }
    response = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> buyPlan(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.buyPlanEndPoint}';
    Map<String, dynamic> params = {
      'id': id.toString(),
      'type': 'item',
    };
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> createWatchParty(
    String episodeId, {
    required String itemId,
  }) async {
    String url = "";
    if (episodeId == "-1") {
      url = "${UrlContainer.baseUrl}${UrlContainer.createPartyEndPoint}?item_id=$itemId&";
    } else {
      url = "${UrlContainer.baseUrl}${UrlContainer.createPartyEndPoint}?item_id=$itemId&episode_id=$episodeId";
    }
    final response = await apiClient.request(
      url,
      Method.postMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
