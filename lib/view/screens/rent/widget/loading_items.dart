import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:shimmer/shimmer.dart';

class LoadingItems extends StatelessWidget {
  double? height;
  double? width;
  LoadingItems({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColor.colorGrey3.withOpacity(0.01),
      highlightColor: MyColor.colorGrey.withOpacity(0.1),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space10),
        width: width ?? context.width,
        height: height ?? context.width / 4,
        decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
