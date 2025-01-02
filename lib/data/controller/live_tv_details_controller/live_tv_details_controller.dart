import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/live_tv/live_tv_details_response_model.dart';
import 'package:play_lab/data/repo/live_tv_repo/live_tv_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/my_strings.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';

class LiveTvDetailsController extends GetxController implements GetxService {
  LiveTvRepo repo;
  LiveTvDetailsController({required this.repo});

  bool isLoading = true;

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  List<RelatedTv> relatedTvList = [];
  String imagePath = '';
  Tv tvObject = Tv();

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

  Future<dynamic> initializePlayer(String s) async {
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
    } catch (e) {
      // print('error: ${e.toString()}');
    }

    isLoading = false;
    update();
  }

  String videoUrl = '';

  void initData(String liveTv) async {
    isLoading = true;
    ResponseModel model = await repo.getLiveTvDetails(liveTv);

    if (model.statusCode == 200) {
      LiveTvDetailsResponseModel responseModel = LiveTvDetailsResponseModel.fromJson(jsonDecode(model.responseJson));
      if (responseModel.status == 'success') {
        tvObject = responseModel.data!.tv!;
        imagePath = responseModel.data?.imagePath ?? '';
        if (responseModel.data?.relatedTv != null && responseModel.data!.relatedTv != []) {
          relatedTvList.clear();
          relatedTvList.addAll(responseModel.data!.relatedTv!);
        }
        await initializePlayer(responseModel.data?.tv?.url ?? '');
      } else {
        Get.back();
        CustomSnackbar.showCustomSnackbar(errorList: responseModel.message?.error ?? [], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
    }
    isLoading = false;
    update();
  }

  void clearAllData() {
    try {
      isLoading = true;
      videoUrl = '';
      relatedTvList.clear();
      videoPlayerController.dispose();
      chewieController.dispose();
    } catch (e) {
      e.printInfo();
    }
  }
}
