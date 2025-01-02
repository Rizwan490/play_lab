import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/my_watch_history_controller/my_watch_history_controller.dart';
import 'package:play_lab/data/repo/mywatch_repo/my_watch_history_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/screens/movie_details/widget/rating_and_watch_widget/RatingAndWatchWidget.dart';

import '../../../constants/my_strings.dart';
import '../../components/header_light_text.dart';
import '../bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';
import '../wish_list/widget/wish_list_shimmer.dart';

class MyWatchHistoryScreen extends StatefulWidget {
  const MyWatchHistoryScreen({super.key});

  @override
  State<MyWatchHistoryScreen> createState() => _MyWatchHistoryScreenState();
}

class _MyWatchHistoryScreenState extends State<MyWatchHistoryScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<MyWatchHistoryController>().fetchNewList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<MyWatchHistoryController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MyWatchHistoryRepo(apiClient: Get.find()));
    final controller = Get.put(MyWatchHistoryController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchInitialList();
      _controller.addListener(() {
        _scrollListener();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWatchHistoryController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.secondaryColor,
        appBar: const CustomAppBar(title: MyStrings.myHistory),
        body: controller.isLoading
            ? const WishlistShimmer(
                isShowCircle: false,
              )
            : controller.movieList.isEmpty
                ? const NoDataFoundScreen()
                : Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ListView.builder(
                      itemCount: controller.movieList.length + 1,
                      controller: _controller,
                      itemBuilder: (context, index) {
                        if (controller.movieList.length == index) {
                          return controller.hasNext()
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: MyColor.primaryColor,
                                ))
                              : const SizedBox();
                        }
                        return GestureDetector(
                          onTap: () {
                            controller.gotoDetailsPage(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                                      child: CustomNetworkImage(
                                        imageUrl: controller.getImagePath(index),
                                        height: 150,
                                        width: 120,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          HeaderLightText(text: controller.movieList[index].item != null ? controller.movieList[index].item?.title?.tr ?? '' : controller.movieList[index].episode?.title?.tr ?? ''),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [RatingAndWatchWidget(watch: controller.movieList[index].item?.view ?? '0.0', rating: controller.movieList[index].item?.ratings ?? '0.0')],
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
                                  color: controller.movieList.length - 1 == index && !controller.hasNext() ? Colors.transparent : MyColor.bodyTextColor,
                                ),
                                SizedBox(
                                  height: controller.movieList.length - 1 == index && !controller.hasNext() ? 0 : 10,
                                )
                              ],
                            ),
                          ).animate().fade(
                                begin: .6,
                                end: 1,
                                delay: (100 * index).microseconds,
                                duration: (index * 100).ms,
                              ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
