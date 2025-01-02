import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/game/game_controller.dart';
import 'package:play_lab/data/repo/event/event_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/card/movie_details_card.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';
import 'package:play_lab/view/components/custom_sized_box.dart';
import 'package:play_lab/view/screens/tournament/widget/subscribe_image.dart';
import 'package:play_lab/view/screens/movie_details/widget/details_text_widget/details_text.dart';

class GameWatchScreen extends StatefulWidget {
  const GameWatchScreen({super.key});

  @override
  State<GameWatchScreen> createState() => _GameWatchScreenState();
}

class _GameWatchScreenState extends State<GameWatchScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TournamentRepo(apiClient: Get.find()));
    final controller = Get.put(GameController(repo: Get.find()));
    test();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      controller.watchGame(Get.arguments);
    });
  }

  test() {
    printx(Get.parameters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.secondaryColor,
      body: GetBuilder<GameController>(
        builder: (controller) {
          return controller.isLoading
              ? const CustomLoader(isFullScreen: true)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      if (controller.isInitialize && controller.chewieController.videoPlayerController.value.isInitialized) ...[
                        AspectRatio(
                          aspectRatio: 9 / 9,
                          child: controller.isVideoLoading ? const CustomLoader(isPagination: true) : Chewie(controller: controller.chewieController),
                        ),
                      ] else ...[
                        InkWell(
                          onTap: () {
                            printx('${UrlContainer.baseUrl}${controller.imagePath}/${controller.game.image}');
                            if (controller.canPlay) {
                              controller.initializePlayer(controller.game.link ?? '');
                            } else {
                              controller.subcribeGame();
                            }
                          },
                          child: SubscribeOrWatch(
                            url: '${UrlContainer.baseUrl}${controller.imagePath}/${controller.game.image}',
                            watch: controller.canPlay,
                            isLoading: controller.isVideoLoading,
                          ),
                        ),
                      ],
                      const CustomSizedBox(),
                      Padding(
                        padding: Dimensions.padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.game.teamOne?.name} VS ${controller.game.teamTwo?.name}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
                            ),
                            const SizedBox(height: Dimensions.space10),
                            ExpandedTextWidget(
                              text: controller.game.details ?? '',
                            ),
                            const SizedBox(height: Dimensions.space20),
                            MovieDetailsCard(title: 'Release Date', subtitle: (controller.game.startTime ?? '').split(' ')[0]),
                            const SizedBox(height: Dimensions.space10),
                            MovieDetailsCard(title: 'Event', subtitle: controller.event.name ?? ''),
                            const SizedBox(height: Dimensions.space10),
                            MovieDetailsCard(title: 'Season', subtitle: controller.event.season ?? ''),
                            const SizedBox(height: Dimensions.space10),
                            MovieDetailsCard(title: 'Price', subtitle: '${controller.currencySym}${StringConverter.twoDecimalPlaceFixedWithoutRounding(controller.game.price ?? '0', precision: 2)} ${controller.currency}'),
                            const SizedBox(height: Dimensions.space50),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
