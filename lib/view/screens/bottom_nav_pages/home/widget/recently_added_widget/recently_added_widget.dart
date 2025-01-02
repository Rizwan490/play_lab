import 'package:flutter_animate/flutter_animate.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/dialog/login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/url_container.dart';
import '../../../../../../data/controller/home/home_controller.dart';
import '../../../../../components/dialog/subscribe_now_dialog.dart';
import '../../shimmer/portrait_movie_shimmer.dart';
import '../custom_network_image/custom_network_image.dart';

class RecentlyAddedWidget extends StatefulWidget {
  const RecentlyAddedWidget({super.key});

  @override
  State<RecentlyAddedWidget> createState() => _RecentlyAddedWidgetState();
}

class _RecentlyAddedWidgetState extends State<RecentlyAddedWidget> {
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
                      children: List.generate(
                        controller.recentlyAddedList.length,
                        (index) => GestureDetector(
                          onTap: () {
                            bool isFree = controller.recentlyAddedList[index].version == '0' ? true : false;
                            bool isRent = controller.recentlyAddedList[index].version == '2' ? true : false;
                            bool isPaidUser = controller.homeRepo.apiClient.isPaidUser();
                            if (controller.isGuest() && isFree == false) {
                              showLoginDialog(context);
                            } else if (!isPaidUser && isFree == false && isRent == false) {
                              showSubscribeDialog(context);
                            } else {
                              Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [controller.recentlyAddedList[index].id, -1]);
                            }
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
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                                      child: CustomNetworkImage(
                                        imageUrl: '${UrlContainer.baseUrl}${controller.recentlyAddedImagePath}/${controller.recentlyAddedList[index].image?.portrait}',
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
                                    Text(controller.recentlyAddedList[index].title?.tr ?? '', style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontSmall, overflow: TextOverflow.ellipsis)),
                                  ],
                                ),
                                CategoryButton(
                                  text: controller.recentlyAddedList[index].version == '0'
                                      ? controller.recentlyAddedList[index].isTrailer == "1"
                                          ? MyStrings.trailer
                                          : MyStrings.free
                                      : controller.recentlyAddedList[index].version == '1'
                                          ? MyStrings.paid
                                          : MyStrings.rent,
                                  press: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )));
  }
}
