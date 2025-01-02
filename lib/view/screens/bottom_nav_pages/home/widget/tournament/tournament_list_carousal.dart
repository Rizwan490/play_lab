import 'package:flutter/material.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/home/home_controller.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/dialog/login_dialog.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import 'package:get/get.dart';

class TournamentListCarousal extends StatelessWidget {
  const TournamentListCarousal({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
        child: CarouselView(
          itemExtent: context.width - 100,
          elevation: 4,
          itemSnapping: true,
          onTap: (value) {
            if (controller.isAuthorized()) {
              Get.toNamed(RouteHelper.tournamentDetailsScreen, arguments: controller.eventList[value].id);
            } else {
              showLoginDialog(context);
            }
          },
          shape: Border.all(),
          children: List.generate(
            controller.eventList.length,
            (index) => ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.cardRadius),
              child: Stack(
                children: [
                  MyImageWidget(
                    imageUrl: '${UrlContainer.baseUrl}${controller.tournamentImagePath}/${controller.eventList[index].image}',
                    radius: 0,
                    width: double.infinity,
                    height: double.maxFinite,
                  ),
                  if (!controller.subcribeEventList.contains(controller.eventList[index].id.toString())) ...[
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CategoryButton(text: "  ${MyStrings.paid.tr}  ", horizontalPadding: 8, verticalPadding: 2, press: () {}),
                    ),
                  ] else ...[
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CategoryButton(text: "Watch Now", horizontalPadding: 8, verticalPadding: 2, press: () {}),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
