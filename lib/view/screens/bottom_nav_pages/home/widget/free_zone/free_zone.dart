import 'package:flutter/material.dart';
import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/url_container.dart';
import '../../../../../../data/controller/home/home_controller.dart';
import 'package:get/get.dart';
import '../../shimmer/portrait_movie_shimmer.dart';
import '../custom_network_image/custom_network_image.dart';

class FreeZoneWidget extends StatefulWidget {
  const FreeZoneWidget({super.key});

  @override
  State<FreeZoneWidget> createState() => _FreeZoneWidgetState();
}

class _FreeZoneWidgetState extends State<FreeZoneWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => controller.freeZoneMovieLoading
            ? const SizedBox(height: 180, child: PortraitShimmer())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
                child: Row(
                  children: List.generate(
                    controller.freeZoneList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        // print('${UrlContainer.baseUrl}${controller.freeZoneImagePath}${controller.freeZoneList[index].image?.portrait}');
                        Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [controller.freeZoneList[index].id, -1]);
                      },
                      child: Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: Dimensions.gridViewMainAxisSpacing),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                              child: CustomNetworkImage(
                                imageUrl: '${UrlContainer.baseUrl}${controller.freeZoneImagePath}${controller.freeZoneList[index].image?.portrait}',
                                width: 120,
                                height: 160,
                              ),
                            ),
                            const SizedBox(
                              height: Dimensions.spaceBetweenTextAndImage,
                            ),
                            Text(
                              controller.freeZoneList[index].title?.tr ?? '',
                              style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontSmall, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
