import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';

import '../../../bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

class EpisodeShimmerEffect extends StatelessWidget {
  const EpisodeShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 1,
              itemBuilder: (context, index) => InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white12,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: const MyShimmerEffectUI.rectangular(
                                    height: 110,
                                    width: 110,
                                  )),
                              const Positioned(
                                  top: 8,
                                  right: 8,
                                  child: MyShimmerEffectUI.rectangular(
                                    height: 15,
                                    width: 35,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.spaceBetweenTextAndImage,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: const MyShimmerEffectUI.rectangular(
                                    height: 20,
                                    width: 120,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: const MyShimmerEffectUI.rectangular(
                                    height: 20,
                                    width: 120,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
