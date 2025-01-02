// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, unused_local_variable
import 'dart:convert';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';
import 'package:play_lab/data/model/general_setting/general_settings_response_model.dart';
import 'package:play_lab/data/model/global/global_user_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/party_room/room_details_response_model.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

import 'package:play_lab/data/repo/watch_party/watch_party_repo.dart';
import 'package:video_player/video_player.dart';

class WatchPartyController extends GetxController {
  WatchPartyRepo repo;

  WatchPartyController({required this.repo});
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
  late VideoPlayerController videoPlayerController;
  late ChewieController? chewieController;
  TextEditingController msgController = TextEditingController();
  RoomDetailsResponseModel roomModel = RoomDetailsResponseModel();

  List<Conversation> chatList = [];
  List<Conversation> partyMemberList = [];
  PusherConfig pusherConfig = PusherConfig();

  void _onProgressUpdate() async {
    final currentPosition = videoPlayerController.value.position.inSeconds;
    if (currentPosition >= videoPlayerController.value.duration.inSeconds) {
      videoPlayerController.pause();
      chewieController?.pause();
    }
    isShowBackBtn = videoPlayerController.value.isPlaying ? false : true;
    update();
  }

  void playVideo() {
    videoPlayerController.play();
    update();
  }

  void pauseVideo() {
    videoPlayerController.pause();
    update();
  }

  Future<void> initializePlayer(
    String s,
  ) async {
    // await loadSubtitles();
    String url = s;
    update();

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url), videoPlayerOptions: VideoPlayerOptions());

    await videoPlayerController.initialize().then((value) {
      update();
    });

    try {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 16 / 9,
        showControlsOnInitialize: false,
        autoPlay: false,
        autoInitialize: true,
        showControls: false,
        errorBuilder: (context, error) {
          String errorMessage = '';
          if (error.contains('VideoError')) {
            errorMessage = MyStrings.videoSourceError;
          } else if (error.contains('PlatformException')) {
            errorMessage = MyStrings.platformSpecificError;
          } else {
            errorMessage = MyStrings.unknownVideoError;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Center(
              child: Text(
                errorMessage.tr,
                style: mulishBold.copyWith(color: MyColor.colorWhite),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        allowFullScreen: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        materialProgressColors: ChewieProgressColors(
          playedColor: const Color.fromRGBO(255, 255, 255, 1), // Color for the played portion of the progress bar
          handleColor: const Color.fromRGBO(255, 255, 255, 1), // Colo// r for the handle (thumb) of the progress bar
          backgroundColor: const Color.fromRGBO(156, 156, 156, 0.5), // Color for the background of the progress bar
          bufferedColor: const Color.fromRGBO(255, 255, 255, 0.3), // Color for the buffered portion of the progress bar
        ),
      );
      videoPlayerController.addListener(_onProgressUpdate);
    } catch (e) {
      if (kDebugMode) {
        // print('exception1: ${e.toString()}');
      }
    }
    videoUrl = url;
    if (kDebugMode) {
      // print('first video url: $videoUrl');
    }
    playVideoLoading = false;
    update();
  }

  String userId = "-1";
  bool get isCurrentUserHost => userId == roomModel.data?.partyRoom?.userId ? true : false;
  String appKey = '';
  String cluster = '';
  bool isChatSelected = false;
  String token = '';
  String authUrl = "${UrlContainer.baseUrl}${UrlContainer.pusherAuthenticate}";
  void loadData({bool fromHistory = false, required String id, required String guestId}) async {
    isLoading = true;
    isChatSelected = false;
    msgController.text = "";
    pusherConfig = repo.apiClient.getPushConfig();
    appKey = pusherConfig.appKey ?? '';
    cluster = pusherConfig.cluster ?? '';
    token = repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey) ?? '';
    userId = repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userIDKey) ?? '';

    update();
    if (fromHistory == false) {
      await getRoomDetails(
        partyCode: id,
        guestId: guestId,
      );
    }
    isLoading = false;
    update();
  }

  changeChatSelection() {
    isChatSelected = !isChatSelected;
    update();
  }

  List<RoomVideoSubtitle> selectedSubtitleDataList = [];
  String subtitleString = '';
  String subTitlePath = '';
  bool isShowBackBtn = false;
  bool playVideoLoading = false;
  String videoUrl = '';
  String playerImage = '';
  String playerAssetPath = '';
  String code = '';
  bool lockVideo = false;
  GlobalUser? user;

  Future<void> getRoomDetails({
    required String partyCode,
    String? guestId,
  }) async {
    try {
      isLoading = true;
      update();
      ResponseModel responseModel = await repo.getRoomDetails(partyCode: partyCode, guestId: guestId);
      if (responseModel.statusCode == 200) {
        RoomDetailsResponseModel model = RoomDetailsResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == MyStrings.success) {
          roomModel = model;
          playerImage = roomModel.data?.item?.image?.landscape ?? '';
          playerAssetPath = roomModel.data?.item?.image?.landscape ?? '';
          chatList = model.data?.conversations ?? [];
          partyMemberList = model.data?.partyMembers ?? [];
          code = model.data?.partyRoom?.partyCode ?? '-1';
          update();
          await initializePlayer(roomModel.data?.videos?.first.content ?? '');
        } else {
          Get.back();
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [], msg: [], isError: true);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateRoomData({
    required String partyCode,
    String? guestId,
  }) async {
    try {
      ResponseModel responseModel = await repo.getRoomDetails(partyCode: partyCode, guestId: guestId);
      if (responseModel.statusCode == 200) {
        RoomDetailsResponseModel model = RoomDetailsResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == MyStrings.success) {
          chatList.clear();
          partyMemberList.clear();

          chatList.addAll(model.data?.conversations ?? []);
          partyMemberList.addAll(model.data?.partyMembers ?? []);
        }
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> acceptUser(String memberId) async {
    ResponseModel responseModel = await repo.acceptRequest(id: memberId);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        updateRoomData(partyCode: roomModel.data?.partyRoom?.partyCode ?? '');
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }
  }

  Future<void> rejectUser(String memberId) async {
    ResponseModel responseModel = await repo.rejectRequest(
      id: memberId,
    );
    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == "success") {
        videoPlayerController.value.isPlaying ? playVideo() : pauseVideo();
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }
  }

  Future<void> playPauseVideo(String partyId) async {
    ResponseModel responseModel = await repo.playPause(
      status: videoPlayerController.value.isPlaying ? 'pause' : 'play',
      partyId: partyId,
    );
    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == "success") {
        videoPlayerController.value.isPlaying ? playVideo() : pauseVideo();
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }
  }

  Future<void> removeUser(String memberId) async {
    ResponseModel responseModel = await repo.removeUser(
      memberId: memberId,
    );
    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == "success") {
        updateRoomData(partyCode: roomModel.data?.partyRoom?.partyCode ?? '');
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }
  }

  Future<void> leaveParty() async {
    ResponseModel responseModel = await repo.leaveUser(
      roomId: roomModel.data?.partyRoom?.id.toString() ?? '',
      userId: userId,
    );
    print(userId);
    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == "success") {
        Get.offAllNamed(RouteHelper.homeScreen);
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }
  }

// party methods:
  bool isClosePartyLoading = false;
  Future<void> closeParty(id) async {
    isClosePartyLoading = true;
    update();
    ResponseModel responseModel = await repo.closeParty(id: id);
    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == MyStrings.success) {
        Get.offAllNamed(RouteHelper.homeScreen); //

        CustomSnackbar.showCustomSnackbar(errorList: [], msg: model.message?.success ?? [MyStrings.somethingWentWrong], isError: false);
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }
    isClosePartyLoading = false;
    update();
  }

  bool isSendingMsg = false;
  Future<void> sendMessage(partyId) async {
    isSendingMsg = true;
    String msg = msgController.text;
    msgController.text = "${MyStrings.sending.tr}...";
    update();
    if (msg == "${MyStrings.sending.tr}...") {
      return;
    } else {
      ResponseModel responseModel = await repo.sendMsg(partyId: partyId, msg: msg);
      if (responseModel.statusCode == 200) {
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == "success") {
          msg = '';
          msgController.text = '';
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
      }
    }
    isSendingMsg = false;
    update();
  }

  Future<void> clearCache() async {
    try {
      DefaultCacheManager().emptyCache();
      final appDir = (await getTemporaryDirectory()).path;
      await Directory(appDir).delete(recursive: true);
    } catch (e) {
      if (kDebugMode) {
        // print('-----------clear directory');
      }
    }
  }
}
