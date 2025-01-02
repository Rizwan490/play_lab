import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utils/my_color.dart';

class AllLiveTvShimmer extends StatelessWidget {
  const AllLiveTvShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: 40,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 4,
            childAspectRatio: 1),
        itemBuilder: (context, index){
          return  Shimmer.fromColors(
            baseColor: MyColor.textFieldColor,
            highlightColor: MyColor.secondaryColor900.withOpacity(.8),
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              color: MyColor.textFieldColor,
              child: GestureDetector(
                  onTap: (){},
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        color:  MyColor.textFieldColor,
                        height: 80,
                        width: 80,
                      ))),
            ),
          );
        }
    );
  }
}