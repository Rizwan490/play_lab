import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/constant_helper.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/model/dashboard/user_subcription_response_model.dart';
import 'package:play_lab/data/model/tournament/event_details_response.dart';
import 'package:play_lab/data/model/tournament/event_list_response_model.dart';
import 'package:play_lab/data/model/global/tournament/tournament_model.dart';
import 'package:play_lab/data/model/global/tournament/game_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/subscribe_plan/buy_subscribe_plan_response_model.dart';
import 'package:play_lab/data/repo/event/event_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:video_player/video_player.dart';

class TournamentController extends GetxController {
  TournamentRepo repo;
  TournamentController({required this.repo});

  bool isLoading = true;
  List<TournamentModel> events = [];
  String? nextPageUrl;
  int currentPage = 0;

  void initialData() async {
    currency = repo.apiClient.getCurrencyOrUsername(isCurrency: true);
    currencySym = repo.apiClient.getCurrencyOrUsername(isSymbol: true);

    try {
      ResponseModel responseModel = await repo.getEventList();
      if (responseModel.statusCode == 200) {
        TournamentListResponseModel model = TournamentListResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == "success") {
          nextPageUrl = nextPageUrl;
          imagePath = model.data?.imagePath ?? '';
          events.addAll(model.data?.events?.data ?? []);
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
      }
    } catch (e) {
      printx(e.toString());
    }
    isLoading = false;
    update();
    if (repo.apiClient.isAuthorizeUser()) {
      loadSubcriptionData();
    }
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  List<String> subcribeGameList = [];
  Future<void> loadSubcriptionData() async {
    printx('load all subcription id');

    ResponseModel responseModel = await repo.getSubcriptionData();

    if (responseModel.statusCode == 200) {
      UserSubcriptionResponseModel model = UserSubcriptionResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'success') {
        subcribeGameList.addAll(model.data?.subscribedTournamentId ?? []);
        update();
      } else {
        //  CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      // CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }
  }

  //

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  TournamentModel event = TournamentModel(id: "-1");
  String imagePath = '';
  bool canPlay = false;
  List<GameModel> games = [];
  String currency = '';
  String currencySym = '';
  String videoUrl = '';
  Map<String, List<GameModel>> gamesmap = {};
  List<String> subscribedEventId = [];

  Future<void> getEventDetails(String id) async {
    isLoading = true;
    canPlay = false;
    currency = repo.apiClient.getCurrencyOrUsername(isCurrency: true);
    currencySym = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    games.clear();
    update();

    try {
      ResponseModel responseModel = await repo.getEventDetails(id);
      if (responseModel.statusCode == 200) {
        EventDetailsResponseModel model = EventDetailsResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == "success") {
          event = model.data?.event ?? TournamentModel(id: "-1");
          canPlay = model.data?.watchEligable.toString() == "true" ? true : false;
          games.addAll(model.data?.event?.games ?? []);
          gamesmap.addAll(model.data?.games ?? {});
          imagePath = model.data?.imagePath ?? '';
          subscribedEventId.addAll(model.data?.subscribedMatchId ?? []);
          update();
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
      }
    } catch (e) {
      printx(e.toString());
    }
    isLoading = false;
    update();
  }

  @override
  void onClose() {
    try {
      videoPlayerController.dispose();
      chewieController.dispose();
    } catch (e) {
      print(e.toString());
    }

    videoUrl = '';
    isLoading = true;
    super.onClose();
  }

  bool isInitialize = false;
  bool isVideoLoading = false;
  Future<dynamic> initializePlayer(String s) async {
    isVideoLoading = true;
    update();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(s));

    try {
      await videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 4 / 2,
        autoPlay: true,
        isLive: true,
        allowedScreenSleep: false,
        allowFullScreen: true,
        looping: true,
        autoInitialize: true,
        showControls: true,
        allowMuting: false,
        additionalOptions: (c) => [],
        allowPlaybackSpeedChanging: false,
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
      );

      chewieController.addListener(() {
        if (videoPlayerController.value.position == videoPlayerController.value.duration) {}
      });

      videoUrl = s;
      isInitialize = true;
    } catch (e) {
      printx('error: ${e.toString()}');
    }
    isVideoLoading = false;
    isLoading = false;
    update();
  }

  bool isBuyPlanClick = false;
  Future<void> subcribeNow({bool isGame = false, String gId = '-1'}) async {
    isBuyPlanClick = true;
    update();
    try {
      ResponseModel response = await repo.buyEvent(isGame ? gId : (event.id ?? '-1'), isGame: isGame);
      if (response.statusCode == 200) {
        BuySubscribePlanResponseModel bModel = BuySubscribePlanResponseModel.fromJson(jsonDecode(response.responseJson));
        if (bModel.status == 'success') {
          String subId = bModel.data?.subscriptionId ?? '';
          update();
          Get.toNamed(RouteHelper.depositScreen, arguments: [event.price.toString(), event.name.toString(), subId, event.id.toString()]);
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: [bModel.message?.error.toString() ?? MyStrings.failedToBuySubscriptionPlan], msg: [''], isError: true);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
      }
    } catch (e) {
      PrintHelper.printHelper(e.toString());
    }
    isBuyPlanClick = false;
    update();
  }
}
