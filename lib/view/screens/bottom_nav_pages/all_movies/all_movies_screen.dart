import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart' as ads;
import 'package:play_lab/view/screens/bottom_nav_pages/all_movies/widget/all_movie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../constants/my_strings.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../data/services/api_service.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/view/will_pop_widget.dart';
import 'package:play_lab/data/controller/all_movies_controller/all_movies_controller.dart';
import 'package:play_lab/data/repo/all_movies_repo/all_movies_repo.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/bottom_Nav/bottom_nav.dart';
import 'package:play_lab/view/components/nav_drawer/custom_nav_drawer.dart';

class AllMovieScreen extends StatefulWidget {
  const AllMovieScreen({super.key});

  @override
  State<AllMovieScreen> createState() => _AllMovieScreenState();
}

class _AllMovieScreenState extends State<AllMovieScreen> {
  ads.BannerAd? _bannerAd;

  final adUnitId = Platform.isAndroid ? MyStrings.homeAndroidBanner : MyStrings.homeIOSBanner;

  void loadAd() {
    _bannerAd = ads.BannerAd(
      adUnitId: adUnitId,
      request: const ads.AdRequest(),
      size: ads.AdSize.banner,
      listener: ads.BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AllMoviesRepo(apiClient: Get.find()));
    final controller = Get.put(AllMoviesController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller.repo.apiClient.isShowAdMobAds()) {
        loadAd();
      }
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemNavigationBarColor: MyColor.colorBlack2, statusBarColor: MyColor.colorBlack2, statusBarIconBrightness: Brightness.light, systemNavigationBarIconBrightness: Brightness.light));
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllMoviesController>(
        builder: (controller) => WillPopWidget(
              nextRoute: RouteHelper.homeScreen,
              child: Scaffold(
                backgroundColor: MyColor.colorBlack,
                drawer: const NavigationDrawerWidget(),
                appBar: const CustomAppBar(
                  title: MyStrings.allMovies,
                  isShowBackBtn: false,
                ),
                body: Stack(
                  children: [
                    !controller.isLoading && controller.movieList.isEmpty ? const NoDataFoundScreen() : const AllMovieListWidget(),
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
                  ],
                ),
                bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
              ),
            ));
  }
}
