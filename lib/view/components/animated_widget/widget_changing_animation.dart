import 'package:flutter/material.dart';

class WidgetChangingFadeInAnimation extends StatelessWidget {

  final int animationDuration;
  final Widget firstChild;
  final Widget secondChild;
  final bool isShowFirst;

  const WidgetChangingFadeInAnimation({
    super.key,
    required this.firstChild,
    required this.secondChild,
    required this.isShowFirst,
    this.animationDuration = 3,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration:  Duration(seconds: animationDuration),
      firstChild: firstChild,
      secondChild: secondChild,
      crossFadeState: isShowFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
