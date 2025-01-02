import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import 'package:play_lab/data/model/play_video_response_model/play_video_response_model.dart';
import 'package:play_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:play_lab/view/components/custom_sized_box.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/buttons/custom_icon_button.dart';
import 'package:play_lab/view/components/row_item/icon_with_text.dart';
import 'package:play_lab/view/components/row_item/header_row.dart';
import 'package:play_lab/view/screens/movie_details/widget/body_widget/create_party_bottom_sheet.dart';
import 'package:play_lab/view/screens/movie_details/widget/body_widget/team_row.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../details_text_widget/details_text.dart';
import 'body_shimmer.dart';

class MovieDetailsBodyWidget extends StatefulWidget {
  const MovieDetailsBodyWidget({super.key});

  @override
  State<MovieDetailsBodyWidget> createState() => _MovieDetailsBodyWidgetState();
}

class _MovieDetailsBodyWidgetState extends State<MovieDetailsBodyWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(
      builder: (controller) => controller.videoDetailsLoading
          ? const SizedBox(child: MovieDetailsShimmer())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          controller.movieDetails.data?.item?.title?.tr ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ratingAndViewWidget(
                        controller.movieDetails.data?.item?.ratings ?? '0.0',
                        controller.movieDetails.data?.item?.view.toString() ?? '0.0',
                        iconSize: 22,
                        textSize: Dimensions.fontDefault,
                        controller: controller,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    '${controller.movieDetails.data?.item?.category?.name ?? ''} | ${controller.movieDetails.data?.item?.subCategory?.name ?? ''}',
                    style: mulishLight.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontDefault),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                controller.isNeedToRent
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            CategoryButton(
                                horizontalPadding: 10,
                                verticalPadding: 5,
                                textSize: 14,
                                color: controller.isTeamShow ? MyColor.colorWhite : MyColor.primaryColor,
                                text: MyStrings.description,
                                textColor: controller.isTeamShow ? MyColor.colorBlack : MyColor.colorWhite,
                                press: () {
                                  controller.changeIsTeamVisibility(false);
                                }),
                            const SizedBox(width: 10),
                            CategoryButton(
                              color: controller.isTeamShow ? MyColor.primaryColor : MyColor.colorWhite,
                              textColor: controller.isTeamShow ? MyColor.colorWhite : MyColor.colorBlack,
                              horizontalPadding: 10,
                              verticalPadding: 5,
                              textSize: 14,
                              text: MyStrings.team,
                              press: () {
                                controller.changeIsTeamVisibility(true);
                              },
                            ),
                            const SizedBox(width: 10),
                            if (controller.isAuthorized() && controller.movieDetailsRepo.apiClient.isWatchPartyEnable()) ...[
                              GestureDetector(
                                onTap: () async {
                                  CustomBottomSheet(
                                    bgColor: MyColor.bgColor,
                                    child: CreatePartyBottomSheet(
                                      episodeId: controller.episodeId.toString(),
                                      itemId: controller.itemId.toString(),
                                    ),
                                  ).customBottomSheet(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                                    border: Border.all(color: MyColor.colorWhite, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        MyStrings.watchParty.tr,
                                        style: mulishRegular.copyWith(),
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Icon(
                                        Icons.people_outline,
                                        color: MyColor.colorWhite,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                            const Spacer(),
                            controller.isAuthorized() && controller.showWishlistBtn
                                ? CustomIconButton(
                                    isLoading: controller.wishListLoading ? true : false,
                                    press: () {
                                      controller.addInWishList();
                                    },
                                    icon: controller.isFavourite ? Icons.favorite : Icons.favorite_outline,
                                    iconColor: controller.isFavourite ? Colors.red : MyColor.colorBlack2,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                const CustomSizedBox(),
                controller.isTeamShow
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TeamRow(firstText: '${MyStrings.director.tr}   :', secondText: controller.movieDetails.data?.item?.team?.director ?? ''),
                                  TeamRow(firstText: '${MyStrings.producer.tr} :', secondText: controller.movieDetails.data?.item?.team?.producer ?? ''),
                                  TeamRow(firstText: '${MyStrings.cast.tr}         :', secondText: controller.movieDetails.data?.item?.team?.casts ?? ''),
                                ],
                              )),
                          const CustomSizedBox(height: 15),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ExpandedTextWidget(
                              text: controller.movieDetails.data?.item?.description?.tr ?? '',
                            ),
                          ),
                          const SizedBox(height: 15)
                        ],
                      ),
                const SizedBox(height: 10),
                controller.isNeedToRent ? const SizedBox() : recentlyAdded(),
              ],
            ),
    );
  }

  Widget recentlyAdded() {
    return Padding(padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin, right: Dimensions.homePageRightMargin), child: HeaderRow(isShowMoreVisible: false, heading: MyStrings.recommended, onShowMorePress: () {}));
  }

  Widget ratingAndViewWidget(
    String rating,
    String watch, {
    double iconSize = 16,
    double textSize = Dimensions.fontSmall,
    required MovieDetailsController controller,
  }) {
    return Row(
      children: [
        if (controller.videoQualityList.isNotEmpty && controller.videoQualityList.length > 1) ...[
          // video quality cannot be empty & more than one
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
              border: Border.all(color: MyColor.colorWhite, width: 1),
            ),
            child: DropdownButton<VideoQuality>(
              padding: EdgeInsets.zero,
              value: controller.selectedVideoQuality,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: MyColor.colorWhite,
              ),
              isDense: true,
              underline: Container(height: 0, color: Colors.transparent),
              items: controller.videoQualityList.map<DropdownMenuItem<VideoQuality>>(
                (VideoQuality value) {
                  return DropdownMenuItem<VideoQuality>(
                    value: value,
                    alignment: Alignment.center,
                    child: Text(value.size.toString()),
                  );
                },
              ).toList(),
              onChanged: (v) {
                if (v != null) {
                  controller.changeVideoQuality(
                    quality: v,
                    currentDuration: controller.videoPlayerController.value.position,
                  );
                }
              },
            ),
          )
        ],
        const SizedBox(
          width: 5,
        ),
        IconWithText(
          icon: Icons.star,
          text: rating.toString(),
          iconSize: iconSize,
          textSize: textSize,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '|',
          style: mulishSemiBold.copyWith(color: MyColor.bodyTextColor),
        ),
        const SizedBox(
          width: 5,
        ),
        IconWithText(
          icon: Icons.remove_red_eye,
          isRating: false,
          text: watch,
          iconSize: iconSize,
          textSize: textSize,
        )
      ],
    );
  }
}
