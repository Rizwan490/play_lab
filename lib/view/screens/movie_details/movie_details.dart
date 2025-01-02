import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import 'package:play_lab/data/repo/movie_details_repo/movie_details_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/custom_sized_box.dart';
import 'package:play_lab/view/screens/movie_details/widget/paid_widget/paid_image.dart';
import 'package:play_lab/view/screens/movie_details/widget/rent_widgets/rent_image.dart';
import 'widget/body_widget/movie_details_widget.dart';
import 'widget/episode_widget/episode_widget.dart';
import 'widget/recommended_section/recommended_list_widget.dart';
import 'widget/video_player_widget/video_player_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int itemId;
  final int episodeId;
  const MovieDetailsScreen({super.key, required this.itemId, required this.episodeId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  InterstitialAd? _interstitialAd;
  final String _adUnitId = Platform.isAndroid ? MyStrings.videoDetailsInterstitialAndroidAds : MyStrings.videoDetailsInterstitialIOSAds;

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MovieDetailsRepo(apiClient: Get.find()));
    MovieDetailsController movieDetailsController = Get.put(
      MovieDetailsController(
        movieDetailsRepo: Get.find(),
        itemId: int.parse("${widget.itemId}"),
        episodeId: int.parse(widget.episodeId.toString()),
      ),
    );

    movieDetailsController.isDescriptionShow = true;
    movieDetailsController.isTeamShow = false;

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      movieDetailsController.initData(widget.itemId, widget.episodeId);

      if (movieDetailsController.movieDetailsRepo.apiClient.isShowAdMobAds()) {
        _loadAd();
      }
    });
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    Get.find<MovieDetailsController>().clearData();
    super.dispose();
  }

  void _loadAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {},
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdClicked: (ad) {});
          _interstitialAd = ad;
          _interstitialAd?.show();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(
      builder: (controller) => PopScope(
        onPopInvokedWithResult: (b, _) async {
          await controller.clearData();
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.secondaryColor,
            body: RefreshIndicator(
              backgroundColor: MyColor.cardBg,
              color: MyColor.primaryColor,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                if (controller.initialized) {
                  await controller.loadVideoDetails();
                }
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.isNeedToRent == true) ...[
                      RentImages(controller: controller),
                    ] else if (controller.isNeedToPurchase) ...[
                      PaidImages(controller: controller),
                    ] else ...[
                      VideoPlayerWidget(controller: controller),
                    ],
                    const CustomSizedBox(),
                    const EpisodeWidget(),
                    const MovieDetailsBodyWidget().animate().fade(delay: 500.ms).scale(),
                    const CustomSizedBox(),
                    const SizedBox(height: Dimensions.spaceBetweenCategory),
                    const RecommendedListWidget(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
