import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:play_lab/constants/constant_helper.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/party_room/create_party_response_model.dart';
import 'package:play_lab/data/model/play_video_response_model/play_video_response_model.dart';
import 'package:play_lab/data/model/subscribe_plan/buy_subscribe_plan_response_model.dart';
import 'package:play_lab/data/model/video_details/video_details_response_model/video_details_response_model.dart';
import 'package:play_lab/data/model/wishlist_model/add_in_wishlist_response_model.dart';
import 'package:play_lab/data/repo/movie_details_repo/movie_details_repo.dart';
// import 'package:play_lab/data/services/pusher_service.dart';
import 'package:play_lab/view/components/dialog/login_dialog.dart';
import 'package:play_lab/view/components/dialog/subscribe_now_dialog.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../../constants/my_strings.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/my_color.dart';
import 'package:http/http.dart' as http;

class MovieDetailsController extends GetxController {
  MovieDetailsRepo movieDetailsRepo;

  MovieDetailsController({
    required this.movieDetailsRepo,
    required this.itemId,
    this.episodeId = -1,
  });

  late VideoPlayerController videoPlayerController;
  late ChewieController? chewieController;

  void _onProgressUpdate() async {
    final currentPosition = videoPlayerController.value.position.inSeconds;
    if (currentPosition >= videoPlayerController.value.duration.inSeconds) {
      videoPlayerController.pause();
      chewieController?.pause();
    }
    isShowBackBtn = videoPlayerController.value.isPlaying ? false : true;
    update();
  }

  Future<void> initializePlayer(String s, {required Duration playDuration}) async {
    await loadSubtitles();
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
        showControls: true,
        startAt: playDuration,
        allowedScreenSleep: false,
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
        subtitleBuilder: (context, subtitle) {
          final currentPosition = videoPlayerController.value.position;
          final subtitleToShow = selectedSubtitleDataList.firstWhere(
            (s) => s.start <= currentPosition && s.end >= currentPosition,
            orElse: () => Subtitle(
              start: Duration.zero,
              end: const Duration(seconds: 100),
              index: 0,
              text: '',
            ),
          );

          if (subtitleToShow.text == '') return Container();

          return Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              subtitleToShow.text,
              style: mulishRegular.copyWith(color: MyColor.colorWhite),
            ),
          );
        },
        additionalOptions: (context) {
          return <OptionItem>[
            if (subTitleLangList.isNotEmpty)
              OptionItem(
                onTap: () async {
                  await Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: Dimensions.space50,
                        top: Dimensions.space20,
                        left: Dimensions.space15,
                        right: Dimensions.space15,
                      ),
                      decoration: const BoxDecoration(
                        color: MyColor.secondaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.space10),
                          topRight: Radius.circular(Dimensions.space10),
                        ),
                      ),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              MyStrings.selectALanguage,
                              style: mulishSemiBold.copyWith(fontSize: Dimensions.fontLarge),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: subTitleLangList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    Get.back();
                                    changeSubtitleLang(subTitleLangList[index]);
                                    await loadSubtitles();
                                    chewieController?.setSubtitle(getSubtitlesData(subtitleString));
                                    Get.back();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: Dimensions.space15),
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space12),
                                    decoration: BoxDecoration(
                                      color: subTitleLangList[index] == selectedSubTitle ? MyColor.primaryColor.withOpacity(.8) : MyColor.shimmerBaseColor,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: subTitleLangList[index] == selectedSubTitle ? MyColor.primaryColor.withOpacity(.8) : MyColor.shimmerBaseColor),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(subTitleLangList[index].language ?? '', style: mulishSemiBold.copyWith(color: MyColor.colorWhite)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                iconData: Icons.subtitles,
                title: MyStrings.subtitles.tr,
              ),
          ];
        },
        subtitle: Subtitles(getSubtitlesData(subtitleString)),
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

  List<VideoQuality> videoQualityList = [];
  VideoQuality selectedVideoQuality = VideoQuality();
  changeVideoQuality({
    required VideoQuality quality,
    required Duration currentDuration,
  }) async {
    selectedVideoQuality = quality;
    update();
    await initializePlayer(quality.content ?? '', playDuration: currentDuration);
  }

  changeVideoDuration(Duration duration) {
    videoPlayerController.seekTo(duration);
    update();
  }

  Map<String, String> adsTime = <String, String>{};

  Future<dynamic> loadVideoUrl() async {
    playVideoLoading = true;
    videoQualityList.clear();
    update();

    final model = await movieDetailsRepo.getVideoData(itemId, episodeId: episodeId);
    if (model.statusCode == 200) {
      final responseModel = PlayVideoResponseModel.fromJson(jsonDecode(model.responseJson));

      if (responseModel.data != null && responseModel.data?.video != null && (responseModel.data?.video!.isNotEmpty ?? false)) {
        subTitleLangList = responseModel.data?.subtitles ?? [];
        if (subTitleLangList.isNotEmpty) {
          selectedSubTitle = subTitleLangList[0];
        }
        if (responseModel.data?.video != null) {
          videoQualityList.addAll(responseModel.data?.video ?? []);
          selectedVideoQuality = videoQualityList.first;
        }
        if (responseModel.data?.adsTime != {}) {
          adsTime = responseModel.data?.adsTime ?? {};
        }

        await initializePlayer(selectedVideoQuality.content ?? '', playDuration: const Duration(seconds: 0));
      } else if (responseModel.remark == 'unauthorized_rent') {
        isNeedToRent = true;
        playerImage = movieDetails.data?.item?.image?.landscape ?? '';
        playerAssetPath = movieDetails.data?.landscapePath ?? '';
      } else if (responseModel.remark == 'unauthorized_paid') {
        if (isAuthorized()) {
          showSubscribeDialog(Get.context!);
        } else {
          showLoginDialog(Get.context!);
        }
      } else {
        lockVideo = true;
        CustomSnackbar.showCustomSnackbar(
          errorList: responseModel.message?.error ?? [MyStrings.somethingWentWrong],
          msg: [],
          isError: true,
        );
      }
    } else {
      CustomSnackbar.showCustomSnackbar(
        errorList: [model.message],
        msg: [],
        isError: true,
      );
      lockVideo = true;
    }
    playVideoLoading = false;
    update();
  }

  String videoUrl = '';
  String currency = '';
  String currencySym = '';

  bool isDescriptionShow = true;
  bool isTeamShow = false;
  late int itemId;
  late int episodeId;

  bool playVideoLoading = true;
  bool videoDetailsLoading = true;

  bool isEpisode = false;
  String portraitImagePath = '';
  String episodePath = '';
  String userId = '';

  List<RelatedItems> relatedItemsList = [];
  List<Episodes> episodeList = [];

  VideoDetailsResponseModel movieDetails = VideoDetailsResponseModel();

  Future<dynamic> initData(int itemId, int episodeId) async {
    currency = movieDetailsRepo.apiClient.getCurrencyOrUsername(isCurrency: true);
    currencySym = movieDetailsRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    userId = movieDetailsRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userIDKey) ?? '';
    playVideoLoading = true;
    update();

    this.itemId = itemId;
    this.episodeId = episodeId;

    // print('details: $itemId');

    await Future.wait([
      loadVideoDetails(),
      if (isAuthorized()) ...{checkWishlist()},
    ]);
  }

  bool isNeedToRent = false;
  bool isNeedToPurchase = false;

  Future<void> loadVideoDetails() async {
    videoDetailsLoading = true;
    update();

    final videoDetailsResponseModel = await movieDetailsRepo.getVideoDetails(itemId, episodeId: episodeId == -1 ? -1 : episodeId);

    if (videoDetailsResponseModel.statusCode == 200) {
      final videoDetailsModel = VideoDetailsResponseModel.fromJson(jsonDecode(videoDetailsResponseModel.responseJson));
      if (videoDetailsModel.status?.toLowerCase() == 'success' && videoDetailsModel.data?.item != null) {
        movieDetails = videoDetailsModel;
        playerImage = movieDetails.data?.item?.image?.landscape ?? '';
        playerAssetPath = movieDetails.data?.landscapePath ?? '';

        if (videoDetailsModel.data != null && videoDetailsModel.data!.relatedItems != null && videoDetailsModel.data!.relatedItems!.isNotEmpty) {
          relatedItemsList = videoDetailsModel.data!.relatedItems!;
          portraitImagePath = videoDetailsModel.data?.portraitPath ?? '';
          episodePath = videoDetailsModel.data?.episodePath ?? '';
        }

        if (videoDetailsModel.data?.episodes != null && videoDetailsModel.data!.episodes!.isNotEmpty) {
          episodeList = videoDetailsModel.data!.episodes!;
          episodeId = episodeId == -1 ? episodeList[0].id ?? -1 : episodeId;
        }
        isNeedToRent = false;
        lockVideo = false;
        await loadVideoUrl();
      } else {
        if (videoDetailsModel.remark == 'unauthorized') {
          if (isAuthorized()) {
            showSubscribeDialog(Get.context!);
          } else {
            showLoginDialog(Get.context!);
          }
        } else if (videoDetailsModel.remark == 'purchase_plan') {
          if (isAuthorized()) {
            showSubscribeDialog(Get.context!, fromDetails: true);
          } else {
            showLoginDialog(Get.context!, fromDetails: true);
          }
          CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.purchaseAPlan], msg: [], isError: true);
        } else if (videoDetailsModel.remark == 'unauthorized_paid') {
          isNeedToPurchase = true;
          movieDetails = videoDetailsModel;
          if (videoDetailsModel.data != null && videoDetailsModel.data!.relatedItems != null && videoDetailsModel.data!.relatedItems!.isNotEmpty) {
            relatedItemsList = videoDetailsModel.data!.relatedItems!;
            portraitImagePath = videoDetailsModel.data?.portraitPath ?? '';
            episodePath = videoDetailsModel.data?.episodePath ?? '';
          }
          playerImage = movieDetails.data?.item?.image?.landscape ?? '';
          playerAssetPath = movieDetails.data?.landscapePath ?? '';
        } else if (videoDetailsModel.remark == 'unauthorized_rent') {
          isNeedToRent = true;
          movieDetails = videoDetailsModel;
          if (videoDetailsModel.data != null && videoDetailsModel.data!.relatedItems != null && videoDetailsModel.data!.relatedItems!.isNotEmpty) {
            relatedItemsList = videoDetailsModel.data!.relatedItems!;
            portraitImagePath = videoDetailsModel.data?.portraitPath ?? '';
            episodePath = videoDetailsModel.data?.episodePath ?? '';
          }

          playerImage = movieDetails.data?.item?.image?.landscape ?? '';
          playerAssetPath = movieDetails.data?.landscapePath ?? '';
        } else {
          isNeedToRent = false;
          Get.back();
          CustomSnackbar.showCustomSnackbar(
            errorList: [
              StringConverter.removeQuotationAndSpecialCharacterFromString(videoDetailsModel.message?.error?.toString() ?? MyStrings.somethingWentWrong),
            ],
            msg: [],
            isError: true,
          );
        }

        lockVideo = true;
        playVideoLoading = false;
      }
    } else {
      lockVideo = true;
      playVideoLoading = false;
      CustomSnackbar.showCustomSnackbar(errorList: [videoDetailsResponseModel.message], msg: [], isError: true);
    }

    videoDetailsLoading = false;
    update();
  }

  bool isFavourite = false;
  bool showWishlistBtn = false;

  String playerImage = '';
  String playerAssetPath = '';
  bool lockVideo = false;

  void changeIsTeamVisibility(bool isTeamShow) {
    this.isTeamShow = isTeamShow;
    update();
  }

  Future<void> checkWishlist() async {
    // print('check wishlist called');

    wishListLoading = true;
    showWishlistBtn = false;
    update();
    bool inWishList = await movieDetailsRepo.checkWishlist(itemId, episodeId: episodeId);
    isFavourite = inWishList;
    showWishlistBtn = true;
    wishListLoading = false;
  }

  bool wishListLoading = false;
  void addInWishList() async {
    ResponseModel model = isFavourite ? await movieDetailsRepo.removeFromWishList(itemId, episodeId: episodeId) : await movieDetailsRepo.addInWishList(itemId, episodeId: episodeId);
    if (model.statusCode == 200) {
      AddInWishlistResponseModel m = AddInWishlistResponseModel.fromJson(jsonDecode(model.responseJson));
      if (m.status == 'success') {
        if (m.remark == 'added_successfully') {
          isFavourite = true;
        } else {
          isFavourite = false;
        }
        //  CustomSnackbar.showCustomSnackbar(errorList: [], msg: [m.message?.success ?? ''], isError: false);
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [m.message?.error ?? (isFavourite ? MyStrings.failToRemoveInWishlist : MyStrings.failToAddInWishlist)], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
    }
    wishListLoading = false;
    update();
  }

  bool isBuyPlanClick = false;
  void rentVideo() async {
    isBuyPlanClick = true;
    update();
    try {
      ResponseModel response = await movieDetailsRepo.buyPlan(movieDetails.data?.item?.id.toString() ?? '-1');
      if (response.statusCode == 200) {
        BuySubscribePlanResponseModel bModel = BuySubscribePlanResponseModel.fromJson(jsonDecode(response.responseJson));
        if (bModel.status == 'success') {
          String subId = bModel.data?.subscriptionId ?? '';
          update();
          Get.toNamed(RouteHelper.depositScreen, arguments: [movieDetails.data?.item?.rentPrice.toString(), movieDetails.data?.item?.title.toString(), subId, movieDetails.data?.item?.id.toString()]);
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

  bool isCreatePartyLoading = false;
  Future<void> createParty(
    String episodeId,
    String partyCode, {
    required String itemId,
  }) async {
    isCreatePartyLoading = true;
    update();
    ResponseModel responseModel = await movieDetailsRepo.createWatchParty(episodeId, itemId: itemId);
    if (responseModel.statusCode == 200) {
      CreatePartyResponseModel model = CreatePartyResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status!.toLowerCase() == MyStrings.success.toLowerCase()) {
        await clearData();
        Get.offAndToNamed(RouteHelper.watchPartyRoomScreen, arguments: [
          model.data?.watchParty?.partyCode.toString(),
          userId,
        ]);
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }

    isCreatePartyLoading = false;
    update();
  }

  void gotoNextPage(int id, int episodeId) async {
    if (isNeedToRent == false) {
      // print('isRental$isNeedToRent');
      await clearData();
    }
    Get.offAndToNamed(RouteHelper.movieDetailsScreen, arguments: [id, episodeId]);
  }

  Future<void> clearData() async {
    if (isNeedToRent == false) {
      try {
        chewieController?.dispose();
      } catch (e) {
        if (kDebugMode) {
          // print('clear video normal player error ${e.toString()}');
        }
      }

      try {
        await chewieController?.pause();
      } catch (e) {
        if (kDebugMode) {
          // print('clear video normal player error ${e.toString()}');
        }
      }

      try {
        await videoPlayerController.dispose();
      } catch (e) {
        if (kDebugMode) {
          // print('clear video player error ${e.toString()}');
        }
      }

      try {
        await clearCache();
      } catch (e) {
        if (kDebugMode) {
          // print('cache Error: ${e.toString()}');
        }
      }

      if (kDebugMode) {
        // print('clear come here');
      }

      isEpisode = false;
      playVideoLoading = true;
      videoDetailsLoading = true;
      lockVideo = false;
      videoUrl = '';
      update();
      relatedItemsList.clear();
      episodeList.clear();
    }
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

  bool isAuthorized() {
    String token = movieDetailsRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey) ?? '';
    return token.isEmpty ? false : true;
  }

  List<Subtitle> selectedSubtitleDataList = [];
  String subtitleString = '';
  String subTitlePath = '';
  bool isShowBackBtn = false;
  Future<void> loadSubtitles() async {
    try {
      String sourceLang = selectedSubTitle.file ?? '';
      sourceLang = '${UrlContainer.baseUrl}assets/subtitles/$sourceLang';
      http.Response response = await http.get(Uri.parse(sourceLang));
      if (response.statusCode == 200) {
        String responseBody = response.body;
        List<int> responseBytes = responseBody.codeUnits;
        subtitleString = utf8.decode(responseBytes);
        selectedSubtitleDataList = getSubtitlesData(subtitleString);
      } else {
        if (kDebugMode) {
          // print('Error loading subtitles');
        }
      }
      selectedSubtitleDataList = getSubtitlesData(subtitleString);
      update();
    } catch (e) {
      if (kDebugMode) {
        // print('subtitle error: ${e.toString()}');
      }
    }
  }

  List<SubtitleModel> subTitleLangList = [];
  bool showSkipBtn = false;

  SubtitleModel selectedSubTitle = SubtitleModel();
  void changeSubtitleLang(SubtitleModel subtitleModel) {
    selectedSubTitle = subtitleModel;
    update();
  }
}

List<Subtitle> getSubtitlesData(String subtitlesContent) {
  RegExp regExp;

  regExp = RegExp(
    r'((\d{2}):(\d{2}):(\d{2})\.(\d+)) +--> +((\d{2}):(\d{2}):(\d{2})\.(\d{3})).*[\r\n]+\s*((?:(?!\r?\n\r?).)*(\r\n|\r|\n)(?:.*))',
    caseSensitive: false,
    multiLine: true,
  );

  final matches = regExp.allMatches(subtitlesContent).toList();
  final subtitleList = <Subtitle>[];

  for (final regExpMatch in matches) {
    final startTimeHours = int.parse(regExpMatch.group(2)!);
    final startTimeMinutes = int.parse(regExpMatch.group(3)!);
    final startTimeSeconds = int.parse(regExpMatch.group(4)!);
    final startTimeMilliseconds = int.parse(regExpMatch.group(5)!);

    final endTimeHours = int.parse(regExpMatch.group(7)!);
    final endTimeMinutes = int.parse(regExpMatch.group(8)!);
    final endTimeSeconds = int.parse(regExpMatch.group(9)!);
    final endTimeMilliseconds = int.parse(regExpMatch.group(10)!);
    final text = removeAllHtmlTags(regExpMatch.group(11)!);

    final startTime = Duration(
      hours: startTimeHours,
      minutes: startTimeMinutes,
      seconds: startTimeSeconds,
      milliseconds: startTimeMilliseconds,
    );

    final endTime = Duration(
      hours: endTimeHours,
      minutes: endTimeMinutes,
      seconds: endTimeSeconds,
      milliseconds: endTimeMilliseconds,
    );

    subtitleList.add(
      Subtitle(index: subtitleList.length, start: startTime, end: endTime, text: text.trim()),
    );
  }

  return subtitleList;
}

String removeAllHtmlTags(String htmlText) {
  final exp = RegExp(
    '(<[^>]*>)',
    multiLine: true,
  );
  var newHtmlText = htmlText;
  exp.allMatches(htmlText).toList().forEach((RegExpMatch regExpMatch) {
    newHtmlText = regExpMatch.group(0) == '<br>' ? newHtmlText.replaceAll(regExpMatch.group(0)!, '\n') : newHtmlText.replaceAll(regExpMatch.group(0)!, '');
  });

  return newHtmlText;
}

//attention: this class only for convert map to list(tuple)
