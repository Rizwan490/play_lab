import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import '../../../bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import '../../../bottom_nav_pages/home/shimmer/portrait_movie_shimmer.dart';

class RecommendedListWidget extends StatefulWidget {
  const RecommendedListWidget({super.key});

  @override
  State<RecommendedListWidget> createState() => _RecommendedListWidgetState();
}

class _RecommendedListWidgetState extends State<RecommendedListWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(
      builder: (controller) => controller.videoDetailsLoading
          ? const SizedBox(height: 180, child: PortraitShimmer())
          : Padding(
              padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    controller.relatedItemsList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        controller.gotoNextPage(controller.relatedItemsList[index].id ?? -1, -1);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  clipBehavior: Clip.hardEdge,
                                  child: CustomNetworkImage(
                                    width: 140,
                                    height: 180,
                                    imageUrl: '${UrlContainer.baseUrl}${controller.portraitImagePath}${controller.relatedItemsList[index].image?.portrait ?? ''}',
                                  ).animate().scale(),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: CategoryButton(
                                    text: controller.relatedItemsList[index].version == '2'
                                        ? MyStrings.rent
                                        : controller.relatedItemsList[index].version == '2'
                                            ? MyStrings.paid
                                            : MyStrings.free.tr,
                                    horizontalPadding: 8,
                                    verticalPadding: 2,
                                    press: () {},
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
