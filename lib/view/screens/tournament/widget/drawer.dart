import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/tournament/tournament_controller.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import 'package:play_lab/view/components/show_more_row/show_more_row.dart';

class MyDrawer extends StatelessWidget {
  final Function() onDrawerItemTap;
  const MyDrawer({super.key, required this.onDrawerItemTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadiusDirectional.only(),
      child: SafeArea(
        child: Drawer(
          width: context.width / 1.3,
          backgroundColor: MyColor.secondaryColor,
          surfaceTintColor: MyColor.cardBg,
          child: GetBuilder<TournamentController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space20),
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.space20),
                  ShowMoreText(headerText: 'Matches', press: () {}, isShowMoreVisible: false),
                  const SizedBox(height: Dimensions.space20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      controller.games.length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            onDrawerItemTap();
                            controller.initializePlayer(controller.games[index].link ?? '-1');
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Stack(
                              children: [
                                MyImageWidget(
                                  imageUrl: '${UrlContainer.baseUrl}${"assets/images/game"}/${controller.games[index].image}', //changed
                                  radius: 0,
                                  width: (context.width / 1.4) - 30,
                                ),
                                if (controller.videoUrl.toString().toLowerCase().trim() == controller.games[index].link.toString().toLowerCase().trim()) ...[
                                  const Positioned.fill(child: Align(alignment: Alignment.center, child: Icon(Icons.bar_chart_rounded, color: MyColor.primaryColor))),
                                ] else ...[
                                  const Positioned.fill(child: Align(alignment: Alignment.center, child: Icon(Icons.play_arrow_sharp, color: MyColor.primaryColor))),
                                ]
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
