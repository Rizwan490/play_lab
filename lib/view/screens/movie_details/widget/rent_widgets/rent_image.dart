import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import 'package:play_lab/view/components/dialog/app_dialog.dart';
import 'package:play_lab/view/components/dialog/login_dialog.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import 'package:play_lab/view/screens/sub_category/widget/player_shimmer_effect/player_shimmer_widget.dart';

class RentImages extends StatelessWidget {
  MovieDetailsController controller;
  RentImages({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.videoDetailsLoading
        ? const PlayerShimmerWidget(showLoading: false)
        : controller.isBuyPlanClick
            ? AspectRatio(
                aspectRatio: 9 / 9,
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 9,
                      child: Opacity(
                        opacity: .1,
                        child: MyImageWidget(
                          imageUrl: '${UrlContainer.baseUrl}${controller.playerAssetPath}${controller.playerImage}',
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 22,
                        width: 22,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: MyColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () async {
                  if (controller.isAuthorized()) {
                    AppDialog().rentItemDialog(
                      context,
                      () {
                        controller.rentVideo();
                      },
                      msgText: '${controller.movieDetails.data?.item?.rentPeriod} ${MyStrings.days}',
                      imageUrl: '${UrlContainer.baseUrl}${controller.playerAssetPath}${controller.playerImage}',
                    );
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
                            Text(MyStrings.purchaseNow.tr.toUpperCase(), style: mulishRegular.copyWith(color: MyColor.colorWhite)),
                            const SizedBox(height: Dimensions.space10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${controller.currencySym}${StringConverter.twoDecimalPlaceFixedWithoutRounding(
                                    controller.movieDetails.data?.item?.rentPrice ?? '0',
                                    precision: 2,
                                  )}',
                                  style: mulishBold.copyWith(color: MyColor.primaryColor, fontSize: 35),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: Dimensions.space10),
                                Text(
                                  "${MyStrings.for_.tr} ${controller.movieDetails.data?.item?.rentPeriod ?? ''} ${MyStrings.days.tr}",
                                  style: mulishLight.copyWith(color: MyColor.colorWhite, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
