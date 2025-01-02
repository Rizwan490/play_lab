import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/data/controller/all_episode_controller/all_episode_controller.dart';
import 'package:play_lab/data/repo/all_episode_repo/all_episode_repo.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/bottom_Nav/bottom_nav.dart';
import 'package:play_lab/view/components/nav_drawer/custom_nav_drawer.dart';
import 'package:play_lab/view/screens/all_episode/widget/all_episode_list_item.dart';
import 'package:play_lab/view/will_pop_widget.dart';
import '../../../constants/my_strings.dart';
import '../../../core/utils/my_color.dart';
import '../../../data/services/api_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as ads;

class AllEpisodeScreen extends StatefulWidget {
  const AllEpisodeScreen({super.key});

  @override
  State<AllEpisodeScreen> createState() => _AllEpisodeScreenState();
}

class _AllEpisodeScreenState extends State<AllEpisodeScreen> {
  ads.BannerAd? _bannerAd;

  final adUnitId = Platform.isAndroid ? MyStrings.allEpisodeAndroidBanner : MyStrings.allEpisodeIOSBanner;

  void loadAd() {
    _bannerAd = ads.BannerAd(
      adUnitId: adUnitId,
      request: const ads.AdRequest(),
      size: ads.AdSize.banner,
      listener: ads.BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {});
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AllEpisodeRepo(apiClient: Get.find()));
    final controller = Get.put(AllEpisodeController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchInitialMovieList();
      if (controller.repo.apiClient.isShowAdMobAds()) {
        loadAd();
      }
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllEpisodeController>(
        builder: (controller) => WillPopWidget(
              nextRoute: RouteHelper.homeScreen,
              child: Scaffold(
                backgroundColor: MyColor.colorBlack,
                drawer: const NavigationDrawerWidget(),
                appBar: const CustomAppBar(
                  title: MyStrings.allSeries,
                  isShowBackBtn: false,
                ),
                body: Stack(
                  children: [
                    if (_bannerAd != null)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SafeArea(
                          child: SizedBox(
                            width: _bannerAd!.size.width.toDouble(),
                            height: _bannerAd!.size.height.toDouble(),
                            child: ads.AdWidget(ad: _bannerAd!),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                      child: !controller.isLoading && controller.episodeList.isEmpty ? const NoDataFoundScreen() : const AllEpisodeListWidget(),
                    ),
                  ],
                ),
                bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
              ),
            ));
  }
}
