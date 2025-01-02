import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:shimmer/shimmer.dart';
import '../../../all_live_tv/widget/live_tv_grid_item/live_tv_grid_item.dart';

class LiveTvShimmer extends StatelessWidget {
  const LiveTvShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: MyColor.textFieldColor,
              highlightColor: MyColor.textFieldColor,
          child: LiveTvGridItem(
              liveTvName: '',
              imageUrl: '',
              press: () {

                }),
          ));
  }
}
