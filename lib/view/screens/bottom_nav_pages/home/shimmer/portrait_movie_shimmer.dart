import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../core/utils/dimensions.dart';
import 'custom_shimmer_effect.dart';

class PortraitShimmer extends StatelessWidget {
  const PortraitShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
        child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white24,
                ),
                width: 105,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const MyShimmerEffectUI.rectangular(
                        width: 105,
                        height: 120,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.spaceBetweenTextAndImage,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const MyShimmerEffectUI.rectangular(
                        width: 105,
                        height: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    ));
  }
}
