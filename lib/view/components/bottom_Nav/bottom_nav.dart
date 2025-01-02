// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/data/services/api_service.dart';

import '../../../core/route/route.dart';
import 'my_bottom_nav_bar_widget.dart';

class CustomBottomNav extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNav({super.key, required this.currentIndex});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: widget.currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      backgroundColor: MyColor.cardBg,
      onItemSelected: (index) {
        _onTap(index);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(icon: SvgPicture.asset(MyImages.homeIcon, height: 16, width: 16, color: widget.currentIndex == 0 ? MyColor.primaryColor : MyColor.colorWhite), title: Text(MyStrings.home.tr), activeColor: MyColor.primaryColor, textAlign: TextAlign.center, inactiveColor: MyColor.primaryText),
        BottomNavyBarItem(icon: SvgPicture.asset(MyImages.allMovieIcon, height: 16, width: 16, color: widget.currentIndex == 1 ? MyColor.primaryColor : MyColor.colorWhite), title: Text(MyStrings.movie.tr), activeColor: MyColor.primaryColor, textAlign: TextAlign.center, inactiveColor: MyColor.primaryText),
        BottomNavyBarItem(icon: SvgPicture.asset(MyImages.allTvSeriesIcon, height: 16, width: 16, color: widget.currentIndex == 2 ? MyColor.primaryColor : MyColor.colorWhite), title: Text(MyStrings.allSeries.tr), activeColor: MyColor.primaryColor, textAlign: TextAlign.center, inactiveColor: MyColor.primaryText),
        BottomNavyBarItem(icon: Image.asset(MyImages.reelsImage, height: 16, width: 16, color: widget.currentIndex == 3 ? MyColor.primaryColor : MyColor.colorWhite), title: Text(MyStrings.reels.tr), activeColor: MyColor.primaryColor, textAlign: TextAlign.center, inactiveColor: MyColor.primaryText),
        Get.find<ApiClient>().isAuthorizeUser()
            ? BottomNavyBarItem(icon: SvgPicture.asset(MyImages.menuIcon, height: 16, width: 16, color: widget.currentIndex == 4 ? MyColor.primaryColor : MyColor.colorWhite), title: Text(MyStrings.menu.tr), activeColor: MyColor.primaryColor, textAlign: TextAlign.center, inactiveColor: MyColor.primaryText)
            : BottomNavyBarItem(icon: const Icon(Icons.account_circle_rounded, color: MyColor.colorWhite), title: Text(MyStrings.login.tr), activeColor: MyColor.primaryColor, textAlign: TextAlign.center, inactiveColor: MyColor.primaryText),
      ],
    );
  }

  void _onTap(int index) {
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAllNamed(RouteHelper.homeScreen);
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.offAllNamed(RouteHelper.allMovieScreen);
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.offAllNamed(RouteHelper.allEpisodeScreen);
      }
    } else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.offAllNamed(RouteHelper.reelsVideoScreen);
      }
    } else if (index == 4) {
      if (Get.find<ApiClient>().isAuthorizeUser()) {
        printx('Tap $index');
        Scaffold.of(context).openDrawer();
      }
      Get.find<ApiClient>().isAuthorizeUser() ? Scaffold.of(context).openDrawer() : Get.offAllNamed(RouteHelper.loginScreen);
    }
  }
}
