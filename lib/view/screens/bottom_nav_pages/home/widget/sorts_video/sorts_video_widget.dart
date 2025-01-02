import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:video_player/video_player.dart';

class SortsVideoWidget extends StatefulWidget {
  final String url;
  final bool isAutoInit;
  final int index;
  const SortsVideoWidget({super.key, required this.url, required this.isAutoInit, required this.index});

  @override
  State<SortsVideoWidget> createState() => _SortsVideoWidgetState();
}

class _SortsVideoWidgetState extends State<SortsVideoWidget> {
  late VideoPlayerController chewieController;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    try {
      chewieController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      await chewieController.initialize();
      chewieController.setLooping(true);
      chewieController.setVolume(100);

      if (mounted) {
        setState(() {
          isInitialized = true;
        });
      }
    } catch (e) {
      // print('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (chewieController.value.isPlaying) {
          chewieController.pause();
        } else {
          chewieController.play();
        }
        setState(() {});
        print(widget.url);
        print("ChewieController.play() ${chewieController.value.isPlaying}");
      },
      customBorder: const LinearBorder(),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
          border: Border.all(color: MyColor.borderColor, width: .5),
        ),
        // margin: const EdgeInsets.only(right: Dimensions.space10),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
              child: isInitialized
                  ? VideoPlayer(chewieController)
                  : const SizedBox(
                      height: 25,
                      width: 25,
                      child: Center(
                          child: SpinKitThreeBounce(
                        size: 20,
                        color: MyColor.primaryColor,
                      ))),
            ),
            if (chewieController.value.isPlaying == false && isInitialized == true) ...[
              const Positioned.fill(child: Align(alignment: Alignment.center, child: Icon(Icons.play_arrow, color: MyColor.primaryColor, size: 30))),
            ]
          ],
        ),
      ),
    );
  }
}
