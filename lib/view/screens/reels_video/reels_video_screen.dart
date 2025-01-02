import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/physics.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/reels/reels_controller.dart';
import 'package:play_lab/data/repo/reels_repo/reels_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/bottom_Nav/bottom_nav.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';
import 'package:play_lab/view/components/nav_drawer/custom_nav_drawer.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/screens/movie_details/widget/details_text_widget/details_text.dart';
import 'package:play_lab/view/screens/reels_video/widgets/video_guesture.dart';
import 'package:play_lab/view/screens/reels_video/widgets/videoButtonColumn.dart';
import 'package:play_lab/view/will_pop_widget.dart';

//info: this is all reels
class ReelsVideoScreen extends StatefulWidget {
  const ReelsVideoScreen({super.key});

  @override
  State<ReelsVideoScreen> createState() => _ReelsVideoScreenState();
}

class _ReelsVideoScreenState extends State<ReelsVideoScreen> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) {
      Get.find<ReelsController>().videoListController.currentPlayer.pause();
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReelsRepo(apiClient: Get.find()));
    final controller = Get.put(ReelsController(repo: Get.find()));

    WidgetsBinding.instance.addObserver(this);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      controller.loadData(false);

      controller.videoListController.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Get.find<ReelsController>().videoListController.currentPlayer.pause();
    Get.find<ReelsController>().videoListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double a = MediaQuery.of(context).size.aspectRatio;
    bool hasBottomPadding = a < 0.55;
    return GetBuilder<ReelsController>(
      builder: (controller) {
        return WillPopWidget(
          child: Scaffold(
            drawer: const NavigationDrawerWidget(),
            body: controller.isLoading
                ? const CustomLoader(isFullScreen: true)
                : (controller.videos.isEmpty && controller.isLoading == false)
                    ? const NoDataFoundScreen(message: "There is no sort videos found")
                    : PageView.builder(
                        key: const Key('home'),
                        physics: const QuickerScrollPhysics(),
                        controller: controller.pageController,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.videoListController.videoCount,
                        reverse: false,
                        itemBuilder: (context, index) {
                          var player = controller.videoListController.playerOfIndex(index);
                          var data = player!.videoInfo!;

                          Widget buttons = VideoButtonColumn(
                            isFavorite: controller.favoriteList.contains(controller.videos[index].id),
                            isLike: controller.likeList.contains(controller.videos[index].id),
                            isDisLike: controller.disLikeList.contains(controller.videos[index].id),
                            onDislike: () {
                              if (controller.disLikeList.contains(controller.videos[index].id)) {
                                controller.likeVideo(controller.videos[index].id.toString(), isDislike: false);
                              } else {
                                controller.likeVideo(controller.videos[index].id.toString(), isDislike: true);
                              }
                            },
                            onFavorite: () {
                              controller.favorite(controller.videos[index].id.toString());
                            },
                            onLike: () {
                              if (controller.likeList.contains(controller.videos[index].id)) {
                                controller.likeVideo(controller.videos[index].id.toString(), isDislike: true);
                              } else {
                                controller.likeVideo(controller.videos[index].id.toString(), isDislike: false);
                              }
                            },
                          );

                          Widget currentVideoPlayer = Center(
                            child: AspectRatio(
                              aspectRatio: player.controller.value.aspectRatio,
                              child: controller.videoListController.currentPlayer.prepared
                                  ?
                                  //VideoPlayer(player.controller)
                                  Chewie(
                                      controller: ChewieController(
                                        videoPlayerController: player.controller,
                                        allowFullScreen: false,
                                        showControls: false,
                                        looping: true,
                                        showOptions: false,
                                        zoomAndPan: false,
                                      ),
                                    )
                                  : const CustomLoader(),
                            ),
                          );

                          Widget currentVideo = VideoPlayWidget(
                            hidePauseIcon: controller.videoListController.currentPlayer.prepared && controller.videoListController.currentPlayer.controller.value.isPlaying,
                            aspectRatio: 9 / 16.0,
                            key: Key('$data$index'),
                            tag: data,
                            bottomPadding: hasBottomPadding ? 16.0 : 16.0,
                            onSingleTap: () async {
                              if (controller.videoListController.currentPlayer.controller.value.isPlaying) {
                                await controller.videoListController.currentPlayer.pause();
                              } else {
                                await controller.videoListController.currentPlayer.play();
                              }
                              setState(() {});
                            },
                            onAddFavorite: () {
                              printx('FAV');
                            },
                            rightButtonColumn: controller.repo.apiClient.isAuthorizeUser() ? buttons : null,
                            video: currentVideoPlayer,
                            userInfoWidget: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.videos[index].title ?? '', style: mulishBold.copyWith()),
                                  SizedBox(
                                    width: context.width,
                                    child: ExpandedTextWidget(text: controller.videos[index].description ?? ""),
                                  ),
                                ],
                              ),
                            ),
                          );

                          return InkWell(
                            onTap: () async {
                              if (controller.videoListController.currentPlayer.controller.value.isPlaying) {
                                await controller.videoListController.currentPlayer.pause();
                              } else {
                                await controller.videoListController.currentPlayer.play();
                              }
                            },
                            child: currentVideo,
                          );
                        },
                      ),
            bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
          ),
        );
      },
    );
  }
}
