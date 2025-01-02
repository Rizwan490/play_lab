import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmerEffectUI extends StatelessWidget {

  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const MyShimmerEffectUI.rectangular({super.key, 
    this.width = double.infinity,
    required this.height
  }): shapeBorder = const RoundedRectangleBorder();

  const MyShimmerEffectUI.circular({super.key, 
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder()
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor:MyColor.shimmerBaseColor ,
    highlightColor: MyColor.shimmerSplashColor,
    period: const Duration(seconds: 3),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: MyColor.hintTextColor,
        shape: shapeBorder,
      ),
    ),
  );
}