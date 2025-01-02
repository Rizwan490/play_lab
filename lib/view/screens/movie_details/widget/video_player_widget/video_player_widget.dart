import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import 'package:play_lab/view/screens/sub_category/widget/player_shimmer_effect/player_shimmer_widget.dart';
import 'player_pre_loader_image.dart';

class VideoPlayerWidget extends StatefulWidget {
  MovieDetailsController controller;
  VideoPlayerWidget({super.key, required this.controller});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildVideoPlayerWidget(MovieDetailsController controller) {
    if (controller.playVideoLoading) {
      return Center(
        child: PlayerShimmerWidget(
          press: () async {
            await controller.clearData();
            Get.back();
          },
        ),
      );
    } else if (controller.lockVideo || controller.videoUrl.isEmpty) {
      return PlayerPreLoaderImage(
        image: '${UrlContainer.baseUrl}${controller.playerAssetPath}${controller.playerImage}',
        isShowLoader: controller.videoUrl.isEmpty && !controller.lockVideo,
      );
    } else if (controller.chewieController != null && controller.chewieController!.videoPlayerController.value.isInitialized && controller.videoDetailsLoading == false) {
      return Stack(
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(controller: controller.chewieController!),
              ),
            ),
          ),
          !controller.videoPlayerController.value.isPlaying
              ? IconButton(
                  onPressed: () async {
                    await controller.clearData();
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: MyColor.colorWhite,
                  ),
                )
              : const SizedBox.shrink(),
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
    return _buildVideoPlayerWidget(widget.controller);
  
  }
}
