import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/home/home_controller.dart';
import '../../../bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';
import '../shimmer/latest_series_shimmer.dart';

class LatestSeries extends StatelessWidget {
  const LatestSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => controller.latestSeriesMovieLoading
          ? const LatestSeriesShimmer()
          : Container(
              height: 185,
              padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.latestSeriesList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [controller.latestSeriesList[index].id, -1]);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: Dimensions.gridViewMainAxisSpacing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                          child: CustomNetworkImage(
                            imageUrl: '${UrlContainer.baseUrl}${controller.latestSeriesImagePath}/${controller.latestSeriesList[index].image?.landscape}',
                            width: MediaQuery.of(context).size.width * .85,
                            height: 170,
                            boxFit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.spaceBetweenTextAndImage,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
