import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/wish_list_controller/wish_list_controller.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/nav_drawer/custom_nav_drawer.dart';
import 'package:play_lab/view/screens/wish_list/widget/wishlist_widget.dart';
import '../../../constants/my_strings.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as ads;

import '../../../data/repo/wish_list_repo/wish_list_repo.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  ads.BannerAd? _bannerAd;

  final adUnitId = Platform.isAndroid ? MyStrings.wishListAndroidBanner : MyStrings.wishListIOSBanner;

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
    Get.put(WishListRepo(apiClient: Get.find()));
    final controller = Get.put(WishListController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      backgroundColor: MyColor.colorBlack,
      appBar: const CustomAppBar(
        title: MyStrings.wishList,
        isShowBackBtn: true,
      ),
      body: const WishlistWidget(),
      bottomNavigationBar: _bannerAd != null
          ? SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: ads.AdWidget(ad: _bannerAd!),
            )
          : const SizedBox(),
    );
  }
}
