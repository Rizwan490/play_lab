import 'package:flutter/material.dart';
import 'dart:math';

class FavoriteAnimationIcon extends StatefulWidget {
  final Offset? position;
  final double size;
  final Function? onAnimationComplete;

  const FavoriteAnimationIcon({
    super.key,
    this.onAnimationComplete,
    this.position,
    this.size = 100,
  });

  @override
  _FavoriteAnimationIconState createState() => _FavoriteAnimationIconState();
}

class _FavoriteAnimationIconState extends State<FavoriteAnimationIcon> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    _animationController!.addListener(() {
      setState(() {});
    });
    startAnimation();
    super.initState();
  }

  startAnimation() async {
    await _animationController!.forward();
    widget.onAnimationComplete?.call();
  }

  double rotate = pi / 10.0 * (2 * Random().nextDouble() - 1);

  double? get value => _animationController?.value;

  double appearDuration = 0.1;
  double dismissDuration = 0.8;

  double get opa {
    if (value! < appearDuration) {
      return 0.99 / appearDuration * value!;
    }
    if (value! < dismissDuration) {
      return 0.99;
    }
    var res = 0.99 - (value! - dismissDuration) / (1 - dismissDuration);
    return res < 0 ? 0 : res;
  }

  double get scale {
    if (value! < appearDuration) {
      return 1 + appearDuration - value!;
    }
    if (value! < dismissDuration) {
      return 1;
    }
    return (value! - dismissDuration) / (1 - dismissDuration) + 1;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Icon(
      Icons.favorite,
      size: widget.size,
      color: Colors.redAccent,
    );
    content = ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => RadialGradient(
        center: Alignment.topLeft.add(const Alignment(0.66, 0.66)),
        colors: const [
          Color(0xffEF6F6F),
          Color(0xffF03E3E),
        ],
      ).createShader(bounds),
      child: content,
    );
    Widget body = Transform.rotate(
      angle: rotate,
      child: Opacity(
        opacity: opa,
        child: Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: scale,
          child: content,
        ),
      ),
    );
    return widget.position == null
        ? Container()
        : Positioned(
            left: widget.position!.dx - widget.size / 2,
            top: widget.position!.dy - widget.size / 2,
            child: body,
          );
  }
}
