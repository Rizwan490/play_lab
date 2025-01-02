import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotateChildWidget extends StatefulWidget {
  final Widget child;
  const RotateChildWidget({super.key,required this.child});

  @override
  State<RotateChildWidget> createState() => _RotateChildWidgetState();
}


class _RotateChildWidgetState extends State<RotateChildWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }
}