import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/watch_party_controller/watch_party_controller.dart';
import 'package:play_lab/data/model/general_setting/general_settings_response_model.dart';
import 'package:play_lab/data/model/global/pusher_event_response_model.dart';
import 'package:play_lab/data/model/global/pusher_player_settings_response_model.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/dialog/app_dialog.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherWatchRoomHelperController extends GetxController {
  ApiClient apiClient;
  WatchPartyController controller;
  PusherWatchRoomHelperController({required this.apiClient, required this.controller});
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  bool isPusherLoading = false;
  String appKey = '';
  String cluster = '';
  String token = '';
  String userId = '';
  String authUrl = "${UrlContainer.baseUrl}${UrlContainer.pusherAuthenticate}";
  PusherConfig pusherConfig = PusherConfig();

  final channels = [
    'private-accept-join-request',
    'private-cancel-party',
    'private-leave-watch-party',
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
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) async {
    printx("on connection state change $previousState $currentState");
  }

  void onEvent(PusherEvent event) {
    if (event.channelName == "private-player-setting") {
      PusherPlayerSettingsResponseModel settings = PusherPlayerSettingsResponseModel.fromJson(jsonDecode(event.data));
      if (settings.partyCode == controller.code) {
        if (settings.status == "play") {
          controller.playVideo();
        } else {
          controller.pauseVideo();
        }
      }
    } else if (event.channelName == "private-cancel-party") {
      if (event.eventName == "cancel-party") {
        PusherResponseModel responseModel = PusherResponseModel.fromJson(jsonDecode(event.data));
        if (responseModel.partyCode == controller.code) {
          clearData();
          Get.offAllNamed(RouteHelper.homeScreen);
        }
      }
    } else {
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
        status: model.status ?? '',
        allMemberId: model.allMemberId ?? [],
        conversation: model.conversation,
        username: model.username ?? '',
        requestMemberId: model.requestMemberId ?? '',
      );

      updateEvent(modify);
    }
  }

  void onError(String message, int? code, dynamic e) {
    printx("onError: $message");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {}

  void onSubscriptionError(String message, dynamic e) {
    printx("onSubcription Erro: $isPusherLoading$message");
  }

  //----------Pusher Response --------------------------------

  updateEvent(PusherResponseModel event) {
    if (event.channelName?.toLowerCase() == "private-reject-join-request" || event.channelName == 'private-accept-join-request') {
      if (event.partyCode == controller.code) {
        joinRejection(event);
      }
    } else if (event.channelName?.toLowerCase() == "private-conversation-message") {
      conversation(event);
    } else if (event.channelName?.toLowerCase() == "private-leave-watch-party") {
      userLeaveEvent(event);
    } else if (event.channelName?.toLowerCase() == "private-conversation-message") {
      conversation(event);
    } else if (event.channelName?.toLowerCase() == "private-send-notification") {
      if (event.hostId == userId) {
        AppDialog().joinRequestDialog(
          Get.context!,
          accept: () {
            controller.acceptUser(event.requestMemberId ?? '');
          },
          reject: () {
            controller.rejectUser(event.requestMemberId ?? '');
          },
          event.username ?? '',
        );
      }
    } else {}
  }

  void joinRejection(PusherResponseModel event) {
    if (event.eventName!.toLowerCase() == 'accept-join-request'.toLowerCase()) {
      if (event.remark == "accept-join-request") {
        if (event.userId.toString() == userId.toString()) {
          Get.toNamed(RouteHelper.watchPartyRoomScreen, arguments: [event.partyCode, event.userId]);
        }
      }
    } else {
      if (controller.isCurrentUserHost == false && event.userId == userId) {
        if (Get.previousRoute == RouteHelper.watchPartyHistoryScreen) {
          Get.offAllNamed(RouteHelper.homeScreen);
          CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.hostRemoveFromPartyMsg], msg: [], isError: true);
        } else {
          Get.back();
          CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.joinRequestRejected], msg: [], isError: true);
        }
      }
    }
  }

  void conversation(PusherResponseModel event) {
    print("event.channelName ${event.channelName}");
    if (event.conversation != null && controller.code == event.partyCode) {
      // check  current party code == my party code  then conversation is not empty
      controller.chatList.add(event.conversation!);
      controller.scrollController.animateTo(controller.scrollController.offset + 80, duration: const Duration(microseconds: 500), curve: Curves.easeInOut);
      controller.update();
    }
  }

  void userLeaveEvent(PusherResponseModel event) {
    if (event.partyCode == controller.code) {
      controller.updateRoomData(partyCode: controller.code);
    }
  }

  //info: close pusher channel when back
  void clearData() {
    closePusher();
    controller.videoPlayerController.dispose();
    controller.chatList.clear();
    controller.update();
  }

  void closePusher() async {
    for (var ch in channels) {
      await pusher.unsubscribe(channelName: ch);
      await pusher.disconnect();
    }
  }
}
