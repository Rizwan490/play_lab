import 'package:flutter_animate/flutter_animate.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/url_container.dart';
import '../../../../../../data/controller/home/home_controller.dart';
import '../../shimmer/portrait_movie_shimmer.dart';
import '../custom_network_image/custom_network_image.dart';

class RentWidget extends StatefulWidget {
  const RentWidget({super.key});

  @override
  State<RentWidget> createState() => _RentWidgetState();
}

class _RentWidgetState extends State<RentWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Padding(
            padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
            child: controller.recentMovieLoading
                ? const SizedBox(height: 180, child: PortraitShimmer())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.rentList.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [controller.rentList[index].id, -1]);
                          },
                          child: Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: Dimensions.gridViewMainAxisSpacing),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                                      child: CustomNetworkImage(
                                        imageUrl: '${UrlContainer.baseUrl}${controller.rentImagePath}/${controller.rentList[index].image?.portrait}',
                                        width: 120,
                                        height: 160,
                                      ),
                                    ).animate().fadeIn(
                                          duration: const Duration(seconds: 2),
                                          delay: Duration(microseconds: index * 100),
                                        ),
                                    const SizedBox(
                                      height: Dimensions.spaceBetweenTextAndImage,
                                    ),
                                    Text(controller.rentList[index].title?.tr ?? '', style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontSmall, overflow: TextOverflow.ellipsis)),
                                  ],
                                ),
                                CategoryButton(text: MyStrings.rent, press: () {})
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  )));
  }
}
