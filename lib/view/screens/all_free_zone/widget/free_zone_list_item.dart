import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../data/controller/all_free_zone_controller/all_free_zone_controller.dart';
import '../../bottom_nav_pages/home/shimmer/grid_shimmer.dart';
import '../../bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

class AllFreeZoneListWidget extends StatefulWidget {
  const AllFreeZoneListWidget({super.key});

  @override
  State<AllFreeZoneListWidget> createState() => _AllFreeZoneListWidgetState();
}

class _AllFreeZoneListWidgetState extends State<AllFreeZoneListWidget> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<AllFreeZoneController>().fetchNewMovieList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<AllFreeZoneController>().hasNext()) {
        Get.find<AllFreeZoneController>().updatePaginationLoading(true);
        fetchData();
      }
    } else {
      Get.find<AllFreeZoneController>().updatePaginationLoading(false);
    }
  }

  @override
  void initState() {
    Get.put(AllFreeZoneController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllFreeZoneController>(
      builder: (controller) => controller.isLoading ?
      const Flexible(child: GridShimmer()) :
      AnimationLimiter(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          itemCount: controller.movieList.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: Dimensions.gridViewCrossAxisSpacing, mainAxisSpacing: Dimensions.gridViewMainAxisSpacing, crossAxisCount: 3, childAspectRatio: .55),
          itemBuilder: (context, index) {

            if(index == controller.movieList.length){
              return controller.hasNext()? const CustomLoader(isPagination: true) : const SizedBox.shrink();
            }

            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 1200),
              columnCount: 3,
              child: SlideAnimation(
                child: FlipAnimation(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.zero,
                    color: MyColor.colorBlack,
                    shape: const RoundedRectangleBorder(),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [controller.movieList[index].id, -1]);
                      },
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CustomNetworkImage(
                                    imageUrl: '${UrlContainer.baseUrl}${controller.portraitImagePath}${controller.movieList[index].image?.portrait}',
                                    height: 200,
                                  ),
                              )),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: MyColor.colorBlack,
                                child: Text(controller.movieList[index].title ?? '', style: mulishSemiBold.copyWith(color: MyColor.colorWhite, overflow: TextOverflow.ellipsis)),
                              ),
                            ],
                          ),
                          CategoryButton(
                            text: MyStrings.free,
                            press: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
