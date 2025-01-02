import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/date_converter.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/tournament/tournament_controller.dart';
import 'package:play_lab/data/model/global/tournament/game_model.dart';
import 'package:play_lab/data/repo/event/event_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/card/movie_details_card.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';
import 'package:play_lab/view/components/custom_sized_box.dart';
import 'package:play_lab/view/components/dialog/login_dialog.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import 'package:play_lab/view/components/show_more_row/show_more_row.dart';
import 'package:play_lab/view/screens/tournament/widget/drawer.dart';
import 'package:play_lab/view/screens/tournament/widget/subscribe_image.dart';

class TournamentDetailsScreen extends StatefulWidget {
  const TournamentDetailsScreen({super.key});

  @override
  State<TournamentDetailsScreen> createState() => _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
  final scafoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TournamentRepo(apiClient: Get.find()));
    final controller = Get.put(TournamentController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      controller.getEventDetails(Get.arguments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      backgroundColor: MyColor.secondaryColor,
      endDrawer: MyDrawer(
        onDrawerItemTap: () {
          scafoldKey.currentState?.closeEndDrawer();
        },
      ),
      body: GetBuilder<TournamentController>(
        builder: (controller) {
          return controller.isLoading
              ? const CustomLoader(isFullScreen: true)
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.isInitialize && controller.chewieController.videoPlayerController.value.isInitialized) ...[
                        AspectRatio(
                          aspectRatio: 9 / 9,
                          child: controller.isVideoLoading
                              ? const CustomLoader(isPagination: true)
                              : Chewie(
                                  controller: controller.chewieController,
                                ),
                        ),
                      ] else
                        InkWell(
                          onTap: () {
                            if (controller.repo.apiClient.isAuthorizeUser()) {
                              if (controller.canPlay) {
                                scafoldKey.currentState?.openEndDrawer();
                              } else {
                                controller.subcribeNow();
                              }
                            } else {
                              showLoginDialog(Get.context!, fromDetails: true);
                            }
                          },
                          child: SubscribeOrWatch(
                            url: '${UrlContainer.baseUrl}${controller.imagePath}/${controller.event.image}',
                            watch: controller.canPlay,
                            isLoading: controller.isVideoLoading,
                          ),
                        ),
                      const CustomSizedBox(),
                      Padding(
                        padding: Dimensions.padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.event.name ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
                            ),
                            const SizedBox(height: Dimensions.space10),
                            Text(
                              controller.event.description ?? '',
                              maxLines: 20,
                              overflow: TextOverflow.ellipsis,
                              style: mulishRegular.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
                            ),
                            const SizedBox(height: Dimensions.space20),
                            MovieDetailsCard(title: 'Season', subtitle: controller.event.season ?? ''),
                            const SizedBox(height: Dimensions.space20),
                            MovieDetailsCard(title: 'Price', subtitle: '${controller.currencySym}${StringConverter.twoDecimalPlaceFixedWithoutRounding(controller.event.price ?? '0', precision: 2)}'),
                            const SizedBox(height: Dimensions.space50 + -10),
                            ShowMoreText(headerText: "Matches", press: () {}, isShowMoreVisible: false),
                            ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              children: controller.gamesmap.entries.map(
                                (entry) {
                                  String date = entry.key;
                                  List<GameModel> games = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin, right: Dimensions.homePageRightMargin),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: Dimensions.space10),
                                        Text(DateConverter.gameDate(date), style: mulishRegular.copyWith(color: MyColor.colorWhite)),
                                        const SizedBox(height: Dimensions.space10),
                                        SizedBox(
                                          height: 100,
                                          child: CarouselView(
                                            itemExtent: context.width - 100,
                                            elevation: 4,
                                            itemSnapping: true,
                                            shape: Border.all(color: MyColor.transparentColor, width: .5),
                                            onTap: (value) {
                                              if (controller.canPlay == false) {
                                                Get.toNamed(RouteHelper.gameWatchScreen, arguments: games[value].id);
                                              } else {
                                                controller.initializePlayer(games[value].link ?? '-1');
                                              }
                                            },
                                            children: List.generate(
                                              games.length,
                                              (index) {
                                                return ClipRRect(
                                                  borderRadius: BorderRadius.circular(2),
                                                  child: Stack(
                                                    children: [
                                                      MyImageWidget(imageUrl: '${UrlContainer.gameImagePath}/${games[index].image}', radius: 0, width: double.infinity, height: double.maxFinite),
                                                      if (controller.canPlay == false) ...[
                                                        Positioned(
                                                          top: 5,
                                                          right: 5,
                                                          child: CategoryButton(text: controller.subscribedEventId.contains(games[index].id) ? "  ${MyStrings.watchNow.tr}  " : MyStrings.paid, horizontalPadding: 8, verticalPadding: 2, press: () {}, color: controller.subscribedEventId.contains(games[index].id) ? MyColor.greenSuccessColor : MyColor.primaryColor),
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.space20),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
