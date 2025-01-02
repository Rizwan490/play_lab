import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/latest_trailer_widget/trailer_card.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../data/controller/home/home_controller.dart';
import '../../shimmer/portrait_movie_shimmer.dart';

class LatestTrailerWidget extends StatefulWidget {
  const LatestTrailerWidget({super.key});

  @override
  State<LatestTrailerWidget> createState() => _LatestTrailerWidgetState();
}

class _LatestTrailerWidgetState extends State<LatestTrailerWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
        child: controller.trailerMovieLoading
            ? const SizedBox(height: 180, child: PortraitShimmer())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    controller.trailerMovieList.length,
                    (index) => TrailerCard(trailer: controller.trailerMovieList[index], trailerImagePath: controller.trailerImagePath),
                  ),
                ),
              ),
      ),
    );
  }
}
