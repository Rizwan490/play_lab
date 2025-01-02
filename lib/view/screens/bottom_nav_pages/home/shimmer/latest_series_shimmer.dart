import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:shimmer/shimmer.dart';

class LatestSeriesShimmer extends StatelessWidget {
  const LatestSeriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:10,
            itemBuilder: (context, index) =>Shimmer.fromColors(
              baseColor: MyColor.shimmerBaseColor,
              highlightColor: MyColor.shimmerSplashColor,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColor.textFieldColor
                      ),
                      child: const SizedBox(
                        width: 270,
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: Dimensions.spaceBetweenTextAndImage,),
                  ],
                ),
              ),
            ) ));
  }
}
