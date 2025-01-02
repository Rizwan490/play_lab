import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/live_tv_details_controller/live_tv_details_controller.dart';
import '../../../../core/utils/dimensions.dart';
import '../../all_live_tv/widget/live_tv_grid_item/live_tv_grid_item.dart';
import '../../bottom_nav_pages/home/shimmer/live_tv_shimmer.dart';

class RelatedTvList extends StatefulWidget {
  const RelatedTvList({super.key});

  @override
  State<RelatedTvList> createState() => _RelatedTvListState();
}

class _RelatedTvListState extends State<RelatedTvList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveTvDetailsController>(
        builder: (controller) => controller.isLoading
            ? const SizedBox(height: 100, child: LiveTvShimmer())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: Dimensions.space12),
                child: AnimationLimiter(
                  child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.relatedTvList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: Dimensions.gridViewCrossAxisSpacing, mainAxisSpacing: Dimensions.gridViewMainAxisSpacing, crossAxisCount: 3, childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 1200),
                          columnCount: 3,
                          child: SlideAnimation(
                            child: FlipAnimation(
                              child: LiveTvGridItem(
                                  marginLeft: 0,
                                  liveTvName: controller.relatedTvList[index].title?.tr ?? '',
                                  imageUrl: '${UrlContainer.baseUrl}${controller.imagePath}/${controller.relatedTvList[index].image}',
                                  press: () {
                                    int id = controller.relatedTvList[index].id ?? -1;
                                    controller.clearAllData();
                                    Get.offAndToNamed(RouteHelper.liveTvDetailsScreen, arguments: id.toString());
                                  }),
                            ),
                          ),
                        );
                      }),
                ),
              ));
  }
}
