// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:play_lab/view/components/buttons/favorite_button_animations.dart';

class VideoGesture extends StatefulWidget {
  const VideoGesture({
    super.key,
    required this.child,
    this.onAddFavorite,
    this.onSingleTap,
  });

  final Function? onAddFavorite;
  final Function? onSingleTap;
  final Widget child;

  @override
  _VideoGestureState createState() => _VideoGestureState();
}

class _VideoGestureState extends State<VideoGesture> {
  final GlobalKey _key = GlobalKey();

  // 内部转换坐标点
  Offset _p(Offset p) {
    RenderBox getBox = _key.currentContext!.findRenderObject() as RenderBox;
    return getBox.globalToLocal(p);
  }

  List<Offset> icons = [];

  bool canAddFavorite = false;
  bool justAddFavorite = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    var iconStack = Stack(
      children: icons
          .map<Widget>(
            (p) => FavoriteAnimationIcon(
              key: Key(p.toString()),
              position: p,
              onAnimationComplete: () {
                icons.remove(p);
              },
            ),
          )
          .toList(),
    );
    return GestureDetector(
      key: _key,
      onTapDown: (detail) {
        setState(() {
          if (canAddFavorite) {
            // print('添加爱心，当前爱心数量:${icons.length}');
            icons.add(_p(detail.globalPosition));
            widget.onAddFavorite?.call();
            justAddFavorite = true;
          } else {
            justAddFavorite = false;
          }
        });
      },
      onTapUp: (detail) {
        timer?.cancel();
        var delay = canAddFavorite ? 1200 : 600;
        timer = Timer(Duration(milliseconds: delay), () {
          canAddFavorite = false;
          timer = null;
          if (!justAddFavorite) {
            widget.onSingleTap?.call();
          }
        });
        canAddFavorite = true;
      },
      onTapCancel: () {},
      child: Stack(
        children: <Widget>[
          widget.child,
          iconStack,
        ],
      ),
    );
  }
}
