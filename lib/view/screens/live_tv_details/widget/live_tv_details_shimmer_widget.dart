import 'package:flutter/material.dart';
import '../../../../core/utils/my_color.dart';
import '../../bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';
import '../../bottom_nav_pages/home/shimmer/live_tv_shimmer.dart';
import '../../sub_category/widget/player_shimmer_effect/player_shimmer_widget.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../components/custom_sized_box.dart';

class LiveTvDetailsShimmerWidget extends StatefulWidget {
  const LiveTvDetailsShimmerWidget({super.key});

  @override
  State<LiveTvDetailsShimmerWidget> createState() =>
      _LiveTvDetailsShimmerWidgetState();
}

class _LiveTvDetailsShimmerWidgetState
    extends State<LiveTvDetailsShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const PlayerShimmerWidget(),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyShimmerEffectUI.rectangular(
                          height: 15,
                          width: 60,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MyShimmerEffectUI.rectangular(
                          height: 15,
                          width: 60,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(
                height: 15,
              ),
              const Divider(
                height: 1,
                color: MyColor.bodyTextColor,
              ),
              const CustomSizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: MyShimmerEffectUI.rectangular(
                        height: 20,
                        width: 100,
                      )),
                  const CustomSizedBox(),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: MyShimmerEffectUI.rectangular(
                        height: 100,
                        width: MediaQuery.of(context).size.width * .8,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding:  EdgeInsets.only(left: 10),
                child: MyShimmerEffectUI.rectangular(
                  height: 15,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: Dimensions.spaceBetweenCategory,
              ),
              const SizedBox(height: 110, child: LiveTvShimmer()),
              const SizedBox(
                height: 5,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
