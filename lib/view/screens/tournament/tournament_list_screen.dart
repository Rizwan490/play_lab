import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/tournament/tournament_controller.dart';
import 'package:play_lab/data/repo/event/event_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/dialog/login_dialog.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/shimmer/grid_shimmer.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

class TournamentListScreen extends StatefulWidget {
  const TournamentListScreen({super.key});

  @override
  State<TournamentListScreen> createState() => _TournamentListScreenState();
}

class _TournamentListScreenState extends State<TournamentListScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TournamentRepo(apiClient: Get.find()));
    final controller = Get.put(TournamentController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      controller.initialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.secondaryColor,
      body: GetBuilder<TournamentController>(
        builder: (controller) {
          return Padding(
            padding: Dimensions.padding,
            child: controller.isLoading
                ? const GridShimmer(crossAsixCount: 2)
                : Column(
                    children: [
                      const SizedBox(height: Dimensions.space20),
                      Expanded(
                        child: AnimationLimiter(
                          child: GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                            physics: const BouncingScrollPhysics(),
                            // controller: _controller,
                            itemCount: controller.events.length + 1,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: Dimensions.gridViewCrossAxisSpacing, mainAxisSpacing: Dimensions.gridViewMainAxisSpacing, crossAxisCount: 2, childAspectRatio: .55),
                            itemBuilder: (context, index) {
                              if (controller.events.length == index) {
                                return controller.hasNext()
                                    ? const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: MyColor.primaryColor,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }

                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 1000),
                                columnCount: 2,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.zero,
                                      color: MyColor.colorBlack,
                                      shape: const RoundedRectangleBorder(),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.repo.apiClient.isAuthorizeUser()) {
                                            Get.toNamed(RouteHelper.tournamentDetailsScreen, arguments: controller.events[index].id);
                                          } else {
                                            showLoginDialog(context);
                                          }
                                        },
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Expanded(
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                                                    child: CustomNetworkImage(imageUrl: '${UrlContainer.baseUrl}${controller.imagePath}/${controller.events[index].image}', height: 200),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
                                                  color: MyColor.colorBlack,
                                                  child: Text(controller.events[index].name?.tr ?? '', style: mulishSemiBold.copyWith(color: MyColor.colorWhite, overflow: TextOverflow.ellipsis)),
                                                ),
                                              ],
                                            ),
                                            CategoryButton(
                                              text: controller.subcribeGameList.contains(controller.events[index].id) ? MyStrings.watchNow : MyStrings.paid,
                                              press: () {},
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
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
