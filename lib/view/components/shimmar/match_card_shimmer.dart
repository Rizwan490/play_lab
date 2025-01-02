import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:shimmer/shimmer.dart';

class MatchCardShimmer extends StatelessWidget {
  const MatchCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColor.colorGrey.withOpacity(0.2),
      highlightColor: MyColor.primaryColor.withOpacity(0.7),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.2), borderRadius: BorderRadius.circular(Dimensions.mediumRadius)),
        height: 150,
        width: context.width,
      ),
    );
  }
}
