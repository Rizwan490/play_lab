import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/general_setting/general_settings_response_model.dart';
import 'package:play_lab/data/model/global/pusher_event_response_model.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class WatchPartyHistoryPusherController extends GetxController {
  ApiClient apiClient;
  WatchPartyHistoryPusherController({required this.apiClient});
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  bool isPusherLoading = false;
  String appKey = '';
  String cluster = '';
  String token = '';
  String userId = '';
  String authUrl = "${UrlContainer.baseUrl}${UrlContainer.pusherAuthenticate}";
  PusherConfig pusherConfig = PusherConfig();
  final StreamController<PusherEvent> _eventStreamController = StreamController<PusherEvent>.broadcast();
  Stream<PusherEvent> get eventStream => _eventStreamController.stream;

  final channels = [
    'private-accept-join-request',
    'private-cancel-party',
    'private-player-setting',
    "private-conversation-message",
    'private-reject-join-request',
    'private-reload-party',
    'private-send-notification',
  ];
  void subscribePusher() async {
    isPusherLoading = true;
    pusherConfig = apiClient.getPushConfig();
    appKey = pusherConfig.appKey ?? '';
    cluster = pusherConfig.cluster ?? '';
    token = apiClient.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey) ?? '';
    userId = apiClient.sharedPreferences.getString(SharedPreferenceHelper.userIDKey) ?? '';
    update();
    for (var ch in channels) {
      configure(ch);
    }

    isPusherLoading = false;
    update();
  }

  Future<void> configure(String channelName) async {
    await pusher.init(
      apiKey: appKey,
      cluster: cluster,
      onEvent: onEvent,
      onSubscriptionError: onSubscriptionError,
      onError: onError,
      onSubscriptionSucceeded: onSubscriptionSucceeded,
      onConnectionStateChange: onConnectionStateChange,
      onMemberAdded: (channelName, member) {},
      onAuthorizer: onAuthorizer,
    );
    await pusher.subscribe(channelName: channelName);

    await pusher.connect();
  }

  Future<Map<String, dynamic>?> onAuthorizer(String channelName, String socketId, options) async {
    try {
      final Map<String, dynamic> requestData = {"socket_id": socketId, "channel_name": channelName};
      http.Response result = await http.post(
        Uri.parse(authUrl),
        body: json.encode(requestData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (result.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(result.body);
        return json;
      } else {
        return null; // or throw an exception
      }
    } catch (e) {
      printx('Exception during HTTP request: $e');
      return null; // or throw an exception
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) async {
    // print("pusher history connection state change $currentState and previous state $previousState");
  }

  void onEvent(PusherEvent event) {
    _eventStreamController.add(event);
    printx('pusher history event ${event.channelName}');
    PusherResponseModel model = PusherResponseModel.fromJson(jsonDecode(event.data));
    final modify = model.copyWith(
      channelName: event.channelName,
      eventName: event.eventName,
      hostId: model.hostId ?? '',
      html: model.html ?? '',
      redirectUrl: model.redirectUrl ?? '',
      remark: model.remark ?? '',
      userId: model.userId ?? '',
      partyCode: model.partyCode ?? '',
    );
    update();
    updateEvent(modify);
  }

  void onError(String message, int? code, dynamic e) {}

  void onSubscriptionSucceeded(String channelName, dynamic data) {}

  void onSubscriptionError(String message, dynamic e) {}

  //----------Pusher Response --------------------------------
  updateEvent(PusherResponseModel event) {
    if (event.channelName == "private-reject-join-request" || event.channelName == 'private-accept-join-request') {
      privateRejectJoin(event);
    }
  }

  void privateRejectJoin(PusherResponseModel event) {
    if (event.eventName!.toLowerCase() == 'accept-join-request'.toLowerCase() && event.remark == "accept-join-request") {
      if (event.userId == userId) {
        Get.toNamed(RouteHelper.watchPartyRoomScreen, arguments: [event.partyCode, event.userId]);
      }
    } else {
      Get.back();
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.joinRequestRejected], msg: [], isError: true);
    }
  }
}
