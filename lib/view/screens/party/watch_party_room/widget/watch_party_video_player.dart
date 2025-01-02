import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/watch_party_controller/watch_party_controller.dart';
import 'package:play_lab/view/screens/sub_category/widget/player_shimmer_effect/player_shimmer_widget.dart';
import 'package:play_lab/view/screens/movie_details/widget/video_player_widget/player_pre_loader_image.dart';

class WatchPartyVideoPlayerWidget extends StatefulWidget {
  const WatchPartyVideoPlayerWidget({super.key});

  @override
  State<WatchPartyVideoPlayerWidget> createState() => _WatchPartyVideoPlayerWidgetState();
}

class _WatchPartyVideoPlayerWidgetState extends State<WatchPartyVideoPlayerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildVideoPlayerWidget(WatchPartyController controller) {
    if (controller.isLoading) {
      return Center(
        child: PlayerShimmerWidget(
          press: () async {
            Get.back();
          },
        ),
      );
    } else if (controller.lockVideo || controller.videoUrl.isEmpty) {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: SpinKitFadingCircle(
            size: 60,
            color: MyColor.primaryColor,
          ),
        ),
      );
    } else if (controller.chewieController != null && controller.chewieController!.videoPlayerController.value.isInitialized) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.black,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Chewie(
                    controller: controller.chewieController!,
                  ),
                ),
              ),
            ),
          ),
          if (controller.isCurrentUserHost) ...[
            !controller.videoPlayerController.value.isPlaying && controller.isCurrentUserHost
                ? Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        if (controller.isCurrentUserHost) {
                          controller.playPauseVideo(controller.roomModel.data?.partyRoom?.id.toString() ?? '-1');
                        }
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: MyColor.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 4,
                    left: 2,
                    child: GestureDetector(
                      onTap: () {
                        if (controller.videoPlayerController.value.isPlaying) {
                          controller.playPauseVideo(controller.roomModel.data?.partyRoom?.id.toString() ?? '-1');
                        }
                      },
                      child: const Icon(
                        Icons.pause,
                        size: 30,
                        color: MyColor.colorWhite,
                      ),
                    ),
                  ),
          ],
          Positioned(
            bottom: 4,
            right: 15,
            child: GestureDetector(
              onTap: () {
                if (controller.chewieController?.isFullScreen ?? false) {
                  controller.chewieController?.exitFullScreen();
                } else {
                  controller.chewieController?.enterFullScreen();
                }
              },
              child: const Icon(
                Icons.fullscreen,
                size: 25,
                color: MyColor.colorWhite,
              ),
            ),
          )
        ],
      );
    } else {
      return PlayerPreLoaderImage(
        image: '${UrlContainer.baseUrl}${controller.playerAssetPath}${controller.playerImage}',
        isShowLoader: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchPartyController>(
      builder: _buildVideoPlayerWidget,
    );
  }
}
