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
import 'package:play_lab/data/model/game/game_watch_response_model.dart';
import 'package:play_lab/data/model/global/tournament/tournament_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/subscribe_plan/buy_subscribe_plan_response_model.dart';
import 'package:play_lab/data/repo/event/event_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:video_player/video_player.dart';

class GameController extends GetxController {
  TournamentRepo repo;
  GameController({required this.repo});

  //
  bool isLoading = true;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  String currency = '';
  String currencySym = '';
  String videoUrl = '';
  bool canPlay = false;
  TournamentModel event = TournamentModel(id: "-1");
  GameWatchModel game = GameWatchModel(id: "-1");
  String imagePath = '';
//

  Future<void> watchGame(String id) async {
    isLoading = true;
    canPlay = false;
    currency = repo.apiClient.getCurrencyOrUsername(isCurrency: true);
    currencySym = repo.apiClient.getCurrencyOrUsername(isSymbol: true);

    update();

    try {
      ResponseModel responseModel = await repo.watchGame(id);
      if (responseModel.statusCode == 200) {
        GameWatchResponseModel model = GameWatchResponseModel.fromJson(jsonDecode(responseModel.responseJson));

        if (model.status == "success" || model.remark?.toLowerCase() == 'purchase_subscription') {
          event = model.data?.game?.event ?? TournamentModel(id: "-1");
          canPlay = model.data?.watchEligable.toString() == "true" ? true : false;
          game = model.data?.game ?? GameWatchModel(id: '-1');
          printx(model.data?.watchEligable.toString());
          imagePath = model.data?.imagePath ?? '';
          update();
          if (canPlay) {
            // initializePlayer(game.link ?? '-1');
          }
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

//
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

//
  bool isBuyPlanClick = false;
  Future<void> subcribeGame() async {
    isBuyPlanClick = true;
    update();
    try {
      ResponseModel response = await repo.buyEvent(game.id ?? '-1', isGame: true);
      if (response.statusCode == 200) {
        BuySubscribePlanResponseModel bModel = BuySubscribePlanResponseModel.fromJson(jsonDecode(response.responseJson));
        if (bModel.status == 'success') {
          String subId = bModel.data?.subscriptionId ?? '';
          update();
          Get.toNamed(RouteHelper.depositScreen, arguments: [game.price.toString(), game.slug.toString(), subId, game.id.toString()]);
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

  ///
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
}
