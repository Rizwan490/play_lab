import 'dart:convert';

import 'package:play_lab/constants/method.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/account/profile_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/services/api_service.dart';

class HomeRepo {
  ApiClient apiClient;
  HomeRepo({required this.apiClient});

  Future<dynamic> dashboard() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.dashboardEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> getSubcriptionData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.userSubcriptionEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> subcribeChannel(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.buyPlanEndPoint}';
    Map<String, dynamic> params = {'id': id.toString(), 'type': 'channel_category'};
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<dynamic> getSlider() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.movieSliderEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic> getLiveTv() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.liveTelevisionEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic> getFeaturedMovie() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.featuredMovieEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic> getPopUpAds() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.popUpAdsEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic> getRecentMovie() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.recentMovieEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic> getLatestSeries() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.latestSeriesEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic> getSingleBannerImage() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.singleBannerEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic> getTrailerMovie() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.trailerMovieEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic> getFreeZoneMovie(int page) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.freeZoneEndPoint}?page=${page.toString()}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<ProfileResponseModel> loadProfileInfo() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';

    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    if (responseModel.statusCode == 200) {
      ProfileResponseModel model = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'success') {
        await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userImageKey, model.data?.user?.image ?? '');
        await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userFullNameKey, '${model.data?.user?.firstName} ${model.data?.user?.lastName}');
        apiClient.storeExpiredDate(model.data?.user?.exp ?? '');
        apiClient.storeUserProvider(model.data?.user?.provider ?? 'null');

        return model;
      } else {
        return ProfileResponseModel();
      }
    } else {
      return ProfileResponseModel();
    }
  }
}
