import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/physics.dart';
import 'package:play_lab/data/controller/video/videoListController.dart';
import 'package:video_player/video_player.dart';

class ReelsVideoList extends StatefulWidget {
  const ReelsVideoList({super.key});

  @override
  State<ReelsVideoList> createState() => _ReelsVideoListState();
}

class _ReelsVideoListState extends State<ReelsVideoList> with WidgetsBindingObserver {
  PageController pageController = PageController();
  VideoListController videoListController = VideoListController();

  List<String> videoDataList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    videoListController.init(
      pageController: pageController,
      initialList: videoDataList.map((e) => VPVideoController(videoInfo: e, builder: () => VideoPlayerController.networkUrl(Uri.parse(e)))).toList(),
      videoProvider: (int index, List<VPVideoController> list) async {
        return videoDataList.map((e) => VPVideoController(videoInfo: e, builder: () => VideoPlayerController.networkUrl(Uri.parse(e)))).toList();
      },
    );
    videoListController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) {
      videoListController.currentPlayer.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    videoListController.currentPlayer.pause();
    videoListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: PageView.builder(
              key: const Key('reels'),
              physics: const QuickerScrollPhysics(),
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: videoListController.videoCount,
              itemBuilder: (context, i) {
                var player = videoListController.playerOfIndex(i)!;
                // video
                Widget currentVideo = Center(
                  child: AspectRatio(
                    aspectRatio: player.controller.value.aspectRatio,
                    child: Chewie(
                      controller: ChewieController(videoPlayerController: player.controller),
                    ),
                  ),
                );

                return SizedBox(
                  height: 200,
                  child: currentVideo,
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: MyColor.primaryColor100, width: .5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_right),
            ),
          )
        ],
      ),
    );
  }
}
