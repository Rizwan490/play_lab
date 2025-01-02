import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/video/videoListController.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/reels/reels_response_list.dart';
import 'package:play_lab/data/repo/reels_repo/reels_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:video_player/video_player.dart';

class ReelsController extends GetxController {
  ReelsRepo repo;
  ReelsController({required this.repo});

  PageController pageController = PageController();

  VideoListController videoListController = VideoListController();

  //
  bool isLoading = true;
  List<Reel> videos = [];
  String videoPath = "";

//
  Future<void> loadData(bool isMylist) async {
    videos = [];

    await getDashBoardData(isMylist).then((v) {
      if (videos.isNotEmpty) {
        initializeVideo();
      }
    });
    isLoading = false;
    update();
  }

  Future<void> favorite(String id) async {
    try {
      ResponseModel responseModel = await repo.favorite(id: id);
      if (responseModel.statusCode == 200) {
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == "success") {
          if (model.remark == 'added_list') {
            favoriteList.add(id);
          } else {
            favoriteList.remove(id);
          }
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
  }

  Future<void> likeVideo(String id, {required bool isDislike}) async {
    try {
      ResponseModel responseModel = await repo.likeDislikeVideo(id: id, type: isDislike ? "unlikes" : "likes");
      if (responseModel.statusCode == 200) {
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == "success") {
          String remark = model.remark!;
          if (remark == 'reel_liked') {
            likeList.add(id);
            disLikeList.remove(id);
          } else if (remark == 'reel_unliked') {
            disLikeList.add(id);
            likeList.remove(id);
          }
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
  }

//
  List<String> likeList = [];
  List<String> disLikeList = [];
  List<String> favoriteList = [];
  Future<void> getDashBoardData(bool isMylist) async {
    isLoading = true;
    update();
    ResponseModel model = await repo.getReels(isMylist);

    if (model.statusCode == 200) {
      UserReelsListResponseModel responseModel = UserReelsListResponseModel.fromJson(jsonDecode(model.responseJson));
      if (responseModel.data != null) {
        videoPath = responseModel.data?.videoPath ?? '';
        videos.addAll(responseModel.data?.reels ?? []);
        // videos.addAll(Environment.sorts);
        likeList.addAll(responseModel.data?.userLikesId ?? []);
        disLikeList.addAll(responseModel.data?.userUnLikesId ?? []);
        favoriteList.addAll(responseModel.data?.userListId ?? []);
        update();
      } else {
        CustomSnackbar.showCustomSnackbar(
          errorList: responseModel.message?.error ?? [MyStrings.somethingWentWrong],
          msg: [],
          isError: true,
        );
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
    }
  }

// initializeVideoController for reels
  Future<void> initializeVideo() async {
    videoListController.init(
      pageController: pageController,
      initialList: videos.map((e) => VPVideoController(videoInfo: "${UrlContainer.baseUrl}$videoPath/${e.video}", builder: () => VideoPlayerController.networkUrl(Uri.parse("${UrlContainer.baseUrl}$videoPath/${e.video}")))).toList(),
      videoProvider: (int index, List<VPVideoController> list) async {
        return videos.map((e) => VPVideoController(videoInfo: "${UrlContainer.baseUrl}$videoPath/${e.video}", builder: () => VideoPlayerController.networkUrl(Uri.parse("${UrlContainer.baseUrl}$videoPath/${e.video}")))).toList();
      },
    );
  }
}
