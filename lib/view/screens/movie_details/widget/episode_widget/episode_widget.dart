import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/header_light_text.dart';
import 'package:play_lab/view/screens/movie_details/widget/episode_widget/episode_shimmer_effect.dart';

import '../../../../../constants/my_strings.dart';
import '../../../bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

class EpisodeWidget extends StatefulWidget {
  const EpisodeWidget({super.key});

  @override
  State<EpisodeWidget> createState() => _EpisodeWidgetState();
}

class _EpisodeWidgetState extends State<EpisodeWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(builder: (controller) {
      int episodeLength = controller.movieDetails.data?.episodes != null ? controller.movieDetails.data!.episodes!.length : 0;
      return controller.videoDetailsLoading
          ? const EpisodeShimmerEffect()
          : episodeLength == 0
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.episodeList.length,
                          itemBuilder: (context, index) => InkWell(
                                borderRadius: BorderRadius.circular(8),
                                splashColor: MyColor.primaryColor500,
                                onTap: () {
                                  int itemId = -1;
                                  try {
                                    itemId = int.parse(controller.episodeList[index].itemId ?? '-1');
                                  } catch (e) {
                                    e.printError();
                                  }
                                  Get.offAndToNamed(RouteHelper.movieDetailsScreen, arguments: [itemId, controller.episodeList[index].id ?? -1]);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10, bottom: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: controller.episodeId == controller.episodeList[index].id ? Colors.grey.withOpacity(.15) : MyColor.transparentColor,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: CustomNetworkImage(width: 110, height: 120, imageUrl: '${UrlContainer.baseUrl}${controller.episodePath}${controller.episodeList[index].image ?? ''}'),
                                          ),
                                          Positioned(top: 8, right: 8, child: CategoryButton(text: controller.episodeList[index].version == '0' ? 'Free' : 'Paid', horizontalPadding: 8, verticalPadding: 2, press: () {})),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: Dimensions.spaceBetweenTextAndImage,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            HeaderLightText(text: controller.episodeList[index].title?.tr ?? ''),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              MyStrings.playNow.tr,
                                              style: mulishRegular.copyWith(color: MyColor.primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
    });
  }
}
