import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:shimmer/shimmer.dart';

class GridShimmer extends StatelessWidget {
  final int crossAsixCount;
  const GridShimmer({super.key, this.crossAsixCount = 3});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 15, mainAxisSpacing: 12, crossAxisCount: crossAsixCount, childAspectRatio: .55),
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          color: MyColor.colorBlack,
          shape: const RoundedRectangleBorder(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Shimmer.fromColors(highlightColor: MyColor.shimmerSplashColor, baseColor: MyColor.shimmerBaseColor, child: Container(height: 200, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: MyColor.textFieldColor)))),
              Container(padding: const EdgeInsets.all(8.0), width: 20, color: MyColor.colorBlack),
              const Padding(padding: EdgeInsets.only(left: 8))
            ],
          ),
        );
      },
    );
  }
}
