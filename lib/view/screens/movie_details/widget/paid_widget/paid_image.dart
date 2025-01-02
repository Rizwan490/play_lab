import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import 'package:play_lab/view/components/dialog/login_dialog.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import 'package:play_lab/view/screens/sub_category/widget/player_shimmer_effect/player_shimmer_widget.dart';

class PaidImages extends StatelessWidget {
  MovieDetailsController controller;
  PaidImages({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.videoDetailsLoading
        ? const PlayerShimmerWidget(showLoading: false)
        : GestureDetector(
            onTap: () async {
              if (controller.isAuthorized()) {
                Get.toNamed(RouteHelper.subscribeScreen);
              } else {
                showLoginDialog(Get.context!, fromDetails: true);
              }
            },
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 9 / 9,
                  child: Opacity(
                    opacity: 0.4,
                    child: MyImageWidget(
                      imageUrl: '${UrlContainer.baseUrl}${controller.playerAssetPath}${controller.playerImage}',
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 10,
                  child: IconButton(
                    onPressed: () async {
                      await controller.clearData();
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: MyColor.colorWhite,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          color: MyColor.primaryColor,
                          size: 50,
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Text(MyStrings.subscribeNow.tr.toUpperCase(), style: mulishRegular.copyWith(color: MyColor.colorWhite)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
