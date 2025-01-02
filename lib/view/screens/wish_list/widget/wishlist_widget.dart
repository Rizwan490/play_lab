import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/wish_list_controller/wish_list_controller.dart';
import 'package:play_lab/data/repo/wish_list_repo/wish_list_repo.dart';
import 'package:play_lab/view/components/dialog/app_dialog.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/screens/movie_details/widget/rating_and_watch_widget/RatingAndWatchWidget.dart';
import 'package:play_lab/view/screens/wish_list/widget/wish_list_shimmer.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/url_container.dart';
import '../../bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({super.key});

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<WishListController>().fetchNewWishlist();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<WishListController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(WishListRepo(apiClient: Get.find()));
    WishListController controller = Get.put(WishListController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchInitialWishlist();
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
    return GetBuilder<WishListController>(
        builder: (controller) => controller.isLoading
            ? SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: const WishlistShimmer())
            : controller.wishlist.isEmpty
                ? const NoDataFoundScreen(
                    paddingTop: 150,
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    controller: _controller,
                    itemCount: controller.wishlist.length + 1,
                    itemBuilder: (context, index) {
                      if (controller.wishlist.length == index) {
                        return controller.hasNext()
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: MyColor.primaryColor,
                              ))
                            : const SizedBox();
                      }
                      return Wrap(
                        children: [
                          GestureDetector(
                            onTap: () {
                              int itemId = int.tryParse(controller.wishlist[index].itemId ?? '-1') ?? -1;
                              int episodeId = int.parse(controller.wishlist[index].episodeId ?? '-1');
                              if (itemId != -1) {
                                Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [itemId, episodeId]);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        width: 120,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: CustomNetworkImage(
                                            imageUrl: '${UrlContainer.baseUrl}${controller.portraitImagePath}${controller.wishlist[index].item?.image?.portrait}',
                                            height: 150,
                                            width: 120,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        (controller.wishlist[index].item?.title ?? '').tr,
                                                        overflow: TextOverflow.fade,
                                                        maxLines: 2,
                                                        style: mulishRegular.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontDefault),
                                                      ),
                                                      const SizedBox(height: Dimensions.space5),
                                                      RatingAndWatchWidget(watch: controller.wishlist[index].item?.view ?? '0', rating: controller.wishlist[index].item?.ratings ?? '0'),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: Dimensions.space10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    AppDialog().closePartyDialog(context, () {
                                                      controller.removeFromWishlist(index);
                                                    }, msgText: 'Are you sure you want to remove this item from wishlist?');
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.all(5),
                                                    alignment: Alignment.center,
                                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: MyColor.textFieldColor),
                                                    child: controller.removeLoading && index == controller.selectedIndex
                                                        ? const SpinKitFadingCircle(
                                                            size: 20,
                                                            color: MyColor.primaryColor,
                                                          )
                                                        : const Icon(
                                                            Icons.clear,
                                                            color: MyColor.colorWhite,
                                                            size: 20,
                                                          ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const SizedBox(
                                              height: Dimensions.space15,
                                            ),
                                            Text(
                                              (controller.wishlist[index].item?.description ?? '').tr,
                                              overflow: TextOverflow.fade,
                                              maxLines: 3,
                                              style: mulishRegular.copyWith(color: MyColor.primaryText, fontSize: Dimensions.fontSmall),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: controller.wishlist.length - 1 == index && !controller.hasNext() ? Colors.transparent : MyColor.bodyTextColor,
                                  ),
                                  SizedBox(
                                    height: controller.wishlist.length - 1 == index && !controller.hasNext() ? 0 : 10,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }));
  }
}
