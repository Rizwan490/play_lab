import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:play_lab/core/utils/styles.dart';

class VideoPlayWidget extends StatelessWidget {
  final Widget? video;
  final double aspectRatio;
  final String? tag;
  final double bottomPadding;

  final Widget? rightButtonColumn;
  final Widget? userInfoWidget;

  final bool hidePauseIcon;

  final Function? onAddFavorite;
  final Function? onSingleTap;

  const VideoPlayWidget({
    super.key,
    this.bottomPadding = 16,
    this.tag,
    this.rightButtonColumn,
    this.userInfoWidget,
    this.onAddFavorite,
    this.onSingleTap,
    this.video,
    this.aspectRatio = 11 / 16.0,
    this.hidePauseIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget rightButtons = rightButtonColumn ?? Container();

    Widget videoContainer = Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          alignment: Alignment.center,
          child: AspectRatio(aspectRatio: aspectRatio, child: video),
        ),
        if (!hidePauseIcon) ...[
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            child: Icon(Icons.play_circle_outline, size: 120, color: Colors.white.withOpacity(0.4)),
          )
        ],
        Positioned(
          bottom: 2,
          right: 2,
          left: 2,
          child: userInfoWidget ?? const SizedBox(),
        )
      ],
    );
    Widget body = Stack(
      children: [
        videoContainer,
        Container(height: double.infinity, width: double.infinity, alignment: Alignment.bottomRight, child: rightButtons),
      ],
    );
    return body;
  }
}

class VideoLoadingPlaceHolder extends StatelessWidget {
  const VideoLoadingPlaceHolder({
    super.key,
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            Colors.blue,
            Colors.green,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitWave(size: 36, color: Colors.white.withOpacity(0.3)),
          Container(padding: const EdgeInsets.all(50), child: Text(tag, style: regularSmall)),
        ],
      ),
    );
  }
}
