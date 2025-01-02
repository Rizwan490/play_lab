import 'package:play_lab/constants/method.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/services/api_service.dart';

class WatchPartyRepo {
  ApiClient apiClient;
  WatchPartyRepo({required this.apiClient});

  Future<ResponseModel> createWatchParty(
    String episodeId,
    String partyCode, {
    required String itemId,
  }) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.createPartyEndPoint}?item_id=$itemId&episode_id=$episodeId&party_code=$partyCode";
    final response = await apiClient.request(
      url,
      Method.postMethod,
      null,
      passHeader: true,
    );
    return response;
  }

  Future<ResponseModel> playPause({
    required String partyId,
    required String status,
  }) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.partyPlayerSettingsEndPoint}";
    Map<String, String> body = {
      'party_id': partyId,
      'status': status,
    };
    final response = await apiClient.request(url, Method.postMethod, body, passHeader: true);
    return response;
  }

  Future<ResponseModel> acceptRequest({required String id}) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.acceptPartyJoinRequestEndPoint}/$id";
    final response = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> rejectRequest({required String id}) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.rejectPartyJoinRequestEndPoint}/$id";
    final response = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> removeUser({required String memberId}) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.removeUserFromPartyEndPoint}/$memberId";
    final response = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> leaveUser({
    required String roomId,
    required String userId,
  }) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.leavePartyEndPoint}$roomId/$userId";
    final response = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> closeParty({required String id}) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.closePartyEndPoint}$id";
    final response = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> sendMsg({
    required String partyId,
    required String msg,
  }) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.sendMsgEndPoint}";
    Map<String, String> body = {
      'message': msg,
      'party_id': partyId,
    };
    final response = await apiClient.request(url, Method.postMethod, body, passHeader: true);
    return response;
  }

  //
  Future<ResponseModel> joinWatchParty({
    required String partyCode,
  }) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.joinPartyEndPoint}";
    Map<String, String> body = {
      'party_code': partyCode,
    };
    final response = await apiClient.request(
      url,
      Method.postMethod,
      body,
      passHeader: true,
    );
    return response;
  }

  //
  Future<ResponseModel> getRoomDetails({
    required String partyCode,
    String? guestId = "0",
  }) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.partyRoomDetailsEndPoint}/$partyCode/$guestId";
    // print('url $url');
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  //
  Future<ResponseModel> getPartyHistory({
    required String page,
  }) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.watchPartyHistoryEndPoint}?page=$page";
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }
}
